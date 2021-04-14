import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/firebase_functions_protocol.dart';
import 'package:langame/models/notification.dart';
import 'package:langame/services/http/message_api.dart';

import 'firebase.dart';

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.max,
);

class ImplMessageApi extends MessageApi {
  StreamSubscription<String>? _onTokenRefresh;
  StreamSubscription<RemoteMessage>? _onForegroundMessage;
  StreamSubscription<RemoteMessage>? _onNonTerminatedOpened;
  Function(LangameNotification?)? _addCallback;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// [localNotifications] stores the mapping Langame notification id -> local notification id
  final Map<String, int> localNotifications = {};

  ImplMessageApi(FirebaseApi firebase,
      void Function(LangameNotification?) onBackgroundOrForegroundOpened)
      : super(firebase, onBackgroundOrForegroundOpened);

  void _add(RemoteMessage m) async {
    RemoteNotification? notification = m.notification;
    AndroidNotification? android = m.notification?.android;
    debugPrint(
        'message: ${jsonEncode(m.data)} - ${m.notification?.android?.tag}');
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin
          .show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              iOS: IOSNotificationDetails(),
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: '@mipmap/ic_launcher',
                importance: Importance.max,
                priority: Priority.high,
                tag: notification.android?.tag,
              ),
            ),
            payload: jsonEncode(m.data),
            // Then add id to local notifications
          )
          .then((value) =>
              localNotifications[m.data['id']] = notification.hashCode);
    }
    if (_addCallback != null) {
      fetch(m.data['id']).then((n) {
        n?.id = m.data['id'];
        _addCallback!(n);
      });
    }
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
  Future<LangameResponse> initializePermissions() async {
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
      var pJson = jsonDecode(payload);
      if (pJson['id'] == null) onBackgroundOrForegroundOpened(null);
      var n = await fetch(pJson['id']);
      if (n == null) onBackgroundOrForegroundOpened(null);
      n!.id = pJson['id'];
      debugPrint('click ${n.toJson()}');
      onBackgroundOrForegroundOpened(n);
    });

    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }

    // TODO: should show "we wil ask you permission blabla.."
    NotificationSettings settings = await firebase.messaging.requestPermission(
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
      return LangameResponse(LangameStatus.succeed);
    }
    throw LangameMessagePermissionException('Permissions denied');
  }

  @override
  Future<void> send(List<String> recipients, List<String> topics) async {
    HttpsCallable callable = firebase.functions.httpsCallable(
        AppConst.sendLangameFunction,
        options: HttpsCallableOptions(timeout: Duration(seconds: 10)));

    try {
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{
          'recipients': recipients,
          'topics': topics,
        },
      );
      print(result.data);
      FirebaseFunctionsResponse response = FirebaseFunctionsResponse.fromJson(
          Map<String, dynamic>.from(result.data));
      switch (response.statusCode) {
        case FirebaseFunctionsResponseStatusCode.OK:
          break;
        case FirebaseFunctionsResponseStatusCode.BAD_REQUEST:
          throw LangameSendLangameException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.BAD_REQUEST.toString());
        case FirebaseFunctionsResponseStatusCode.UNAUTHORIZED:
          throw LangameSendLangameException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.UNAUTHORIZED.toString());
        case FirebaseFunctionsResponseStatusCode.INTERNAL:
          throw LangameSendLangameException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.INTERNAL.toString());
      }
    } catch (e) {
      throw LangameSendLangameException(e.toString());
    }
  }

  @override
  Future<void> sendReadyForLangame(String channelName) async {
    HttpsCallable callable = firebase.functions.httpsCallable(
      AppConst.sendReadyForLangameFunction,
      options: HttpsCallableOptions(
        timeout: Duration(seconds: 10),
      ),
    );

    try {
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{
          'channelName': channelName,
        },
      );
      FirebaseFunctionsResponse response = FirebaseFunctionsResponse.fromJson(
        Map<String, dynamic>.from(result.data),
      );
      switch (response.statusCode) {
        case FirebaseFunctionsResponseStatusCode.OK:
          break;
        case FirebaseFunctionsResponseStatusCode.BAD_REQUEST:
          throw LangameSendReadyForLangameException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.BAD_REQUEST.toString());
        case FirebaseFunctionsResponseStatusCode.UNAUTHORIZED:
          throw LangameSendReadyForLangameException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.UNAUTHORIZED.toString());
        case FirebaseFunctionsResponseStatusCode.INTERNAL:
          throw LangameSendReadyForLangameException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.INTERNAL.toString());
      }
    } catch (e) {
      throw LangameSendReadyForLangameException(e.toString());
    }
  }

  @override
  Future<void> listen(Function(LangameNotification?) add) async {
    // Get the token each time the application loads
    String? token = await firebase.messaging.getToken();

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
        firebase.messaging.onTokenRefresh.listen(_saveTokenToDatabase);

    _addCallback = add;

    // https://firebase.flutter.dev/docs/messaging/notifications
    _onForegroundMessage =
        FirebaseMessaging.onMessage.listen(_firebaseMessagingForegroundHandler);

    _onNonTerminatedOpened = FirebaseMessaging.onMessageOpenedApp
        .listen((m) => fetch(m.data['id']).then((n) {
              n?.id = m.data['id'];
              debugPrint('opened ${n?.toJson()}');
              onBackgroundOrForegroundOpened(n);
            }));
    runZonedGuarded(() {
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    },
        (_, __) => debugPrint(
            'ignoring usual FirebaseMessaging.onBackgroundMessage Null check'));
  }

  @override
  void cancel() {
    _onTokenRefresh?.cancel();
    _onForegroundMessage?.cancel();
    // TODO: test this hack
    Future<void> _emptyHandler(RemoteMessage message) async {}
    FirebaseMessaging.onBackgroundMessage(_emptyHandler);
    _onNonTerminatedOpened?.cancel();
  }

  @override
  Future<LangameNotification?> fetch(String id) async {
    CollectionReference notifications = firebase.firestore
        .collection(AppConst.firestoreNotificationsCollection);

    DocumentSnapshot doc = await notifications.doc(id).get();
    if (!doc.exists) {
      throw LangameMessageException('could not fetch notification $id');
    }
    var data = doc.data();
    if (data == null) {
      throw LangameMessageException('notification $id has no data');
    }
    // We store with format {data: ..., notification: ...}
    // Here we only care about the data?
    LangameNotification nResult = LangameNotification.fromJson(data);
    nResult.id = id;
    return nResult;
  }

  // TODO: might do a 'fetch non-acknowledged notifications'
  Future<List<LangameNotification>?> fetchAll() async {
    CollectionReference notifications = firebase.firestore
        .collection(AppConst.firestoreNotificationsCollection);
    QuerySnapshot query = await notifications
        .where('recipientsUid', arrayContains: firebase.auth.currentUser?.uid)
        .get();
    // If there is any non-null notifications, return all of them
    if (query.docs.any((n) => n.exists)) {
      return query.docs.where((n) => n.exists).map((n) {
        var ln = LangameNotification.fromJson(n.data());
        ln.id = n.data()['id'];
        return ln;
      }).toList();
    } else {
      throw LangameMessageException(
          'could not find any notifications for current user');
    }
  }

  @override
  Future<void> delete(String id) async {
    int? localNotification = localNotifications[id];
    if (localNotification == null) {
      throw LangameMessageException('unable to find local notification id');
    }
    Future f = flutterLocalNotificationsPlugin.cancel(localNotification);
    f.then((_) => localNotifications.remove(id));
    return f;
  }

  Future<void> _saveTokenToDatabase(String token) async {
    // Assume user is logged in for this example
    String? userId = firebase.auth.currentUser?.uid;

    // Somehow the user is not authenticated anymore but in the app
    if (userId == null) throw LangameNotAuthenticatedException();

    HttpsCallable callable = firebase.functions.httpsCallable(
        AppConst.saveTokenFunction,
        options: HttpsCallableOptions(timeout: Duration(seconds: 10)));

    try {
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{
          'tokens': [token],
        },
      );
      FirebaseFunctionsResponse response = FirebaseFunctionsResponse.fromJson(
          Map<String, dynamic>.from(result.data));
      switch (response.statusCode) {
        case FirebaseFunctionsResponseStatusCode.OK:
          firebase.crashlytics.log('new FCM token');
          break;
        case FirebaseFunctionsResponseStatusCode.BAD_REQUEST:
          throw LangameMessageException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.BAD_REQUEST.toString());
        case FirebaseFunctionsResponseStatusCode.UNAUTHORIZED:
          throw LangameMessageException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.UNAUTHORIZED.toString());
        case FirebaseFunctionsResponseStatusCode.INTERNAL:
          throw LangameMessageException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.INTERNAL.toString());
      }
    } catch (e) {
      throw LangameMessageException(e.toString());
    }
  }

  @override
  Future<LangameNotification?> getInitialMessage() async {
    var m = await firebase.messaging.getInitialMessage();
    if (m == null) return null;
    var n = LangameNotification.fromJson(m.data);
    n.id = m.data['id'];
    return n;
  }
}
