import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/services/http/message_api.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;

import 'firebase.dart';

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  enableLights: true,
  importance: Importance.max,
);

class ImplMessageApi extends MessageApi {
  // ignore: cancel_subscriptions
  StreamSubscription<String>? _onTokenRefresh;
  // ignore: cancel_subscriptions
  StreamSubscription<RemoteMessage>? _onForegroundMessage;
  // ignore: cancel_subscriptions
  StreamSubscription<RemoteMessage>? _onNonTerminatedOpened;
  Function(lg.Message)? _addCallback;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  ImplMessageApi(FirebaseApi firebase,
      void Function(lg.Message) onBackgroundOrForegroundOpened)
      : super(firebase, onBackgroundOrForegroundOpened);

  void _add(RemoteMessage m) async {
    RemoteNotification? notification = m.notification;
    AndroidNotification? android = m.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          iOS: IOSNotificationDetails(),
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: '@mipmap/ic_launcher',
            importance:
                Importance.max, // Seems only to work on other people phones :)
            priority: Priority.high,
            tag: notification.android?.tag,
          ),
        ),
        payload: jsonEncode(m.data),
        // Then add id to local notifications
      );
    }
    if (_addCallback != null) _addCallback!(MessageExt.fromObject(m.data));
  }

  Future<void> _firebaseMessagingForegroundHandler(
      RemoteMessage message) async {
    _add(message);
  }

  // https://firebase.flutter.dev/docs/messaging/usage#handling-messages
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    _add(message);
  }

  @override
  Future<void> initializePermissions() async {
    /// lot of mess https://pub.dev/packages/flutter_local_notifications#initialisation
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (payload) async {
      if (payload == null)
        throw LangameException('received null payload on notification tap');
      onBackgroundOrForegroundOpened(
          MessageExt.fromObject(jsonDecode(payload)));
    });

    if (UniversalPlatform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }

    // TODO: should show "we wil ask you permission bla bla.."
    NotificationSettings settings = await firebase.messaging!.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    // https://firebase.flutter.dev/docs/messaging/permissions
    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      return;
    }
    throw LangameMessagePermissionException('Permissions denied');
  }

  @override
  Future<void> listen(Function(lg.Message)? add) async {
    // Get the token each time the application loads
    String? token = await firebase.messaging!.getToken(
        vapidKey: AppConst.isDev
            ? 'BFRs0auVQUjC1RuKwZprcEmv1d-JPr52sMUdHQxKa99WBCmZWhUS6sb6FelhbkZxK9LgVy7efWoynHJ1Y1Pt_RY'
            : 'BMe8L3jPKhCUJEGPKr5K9IaUqdcxoowuEnLv6RBjmVjf9G3u5BFG8x_ztvp-Z7tDHmk9Usdp4Hp0JsAWYzrGLeE');

    if (token == null)
      throw LangameMessageException('could_not_get_firebase_messaging_token');

    // Save the initial token to the database
    try {
      await _saveTokenToDatabase(token);
    } on LangameMessageException catch (e) {
      throw LangameMessageException(e.cause);
    }

    // Any time the token refreshes, store this in the database too.
    _onTokenRefresh =
        firebase.messaging!.onTokenRefresh.listen(_saveTokenToDatabase);

    _addCallback = add;

    // https://firebase.flutter.dev/docs/messaging/notifications
    _onForegroundMessage =
        FirebaseMessaging.onMessage.listen(_firebaseMessagingForegroundHandler);

    _onNonTerminatedOpened = FirebaseMessaging.onMessageOpenedApp.listen(
        (m) => onBackgroundOrForegroundOpened(MessageExt.fromObject(m.data)));
    runZonedGuarded(
        () => FirebaseMessaging.onBackgroundMessage(
            _firebaseMessagingBackgroundHandler),
        (_, __) => debugPrint(
            'ignoring usual FirebaseMessaging.onBackgroundMessage Null check'));
  }

  Future<void> _emptyHandler(RemoteMessage message) async {}

  @override
  Future<void> cancel() {
    runZonedGuarded(
        () => FirebaseMessaging.onBackgroundMessage(_emptyHandler),
        (_, __) => debugPrint(
            'ignoring usual FirebaseMessaging.onBackgroundMessage Null check'));

    List<Future> futures = [];
    if (_onTokenRefresh != null) futures.add(_onTokenRefresh!.cancel());
    if (_onForegroundMessage != null)
      futures.add(_onForegroundMessage!.cancel());
    if (_onNonTerminatedOpened != null)
      futures.add(_onNonTerminatedOpened!.cancel());
    futures.add(firebase.messaging!.deleteToken().catchError((_) {}));
    return Future.wait<void>(futures);
  }

  Future<void> _saveTokenToDatabase(String token) async {
    // Assume user is logged in for this example
    String? userId = firebase.auth!.currentUser?.uid;

    // Somehow the user is not authenticated anymore but in the app
    if (userId == null) throw LangameNotAuthenticatedException();

    firebase.firestore!
        .collection(AppConst.firestoreUsersCollection)
        .doc(userId)
        .update({
      'tokens': FieldValue.arrayUnion([token]),
    });
  }

  @override
  Future<lg.Message?> getInitialMessage() async {
    var n2 = await Future.wait([
      flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails(),
      firebase.messaging!.getInitialMessage(),
    ]);

    if (n2.length > 1 && n2[1] != null && (n2[1] as RemoteMessage?) != null) {
      return MessageExt.fromObject((n2[1] as RemoteMessage).data);
    }
    return null;
  }
}
