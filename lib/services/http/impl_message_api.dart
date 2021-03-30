import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
  importance: Importance.high,
);

class ImplMessageApi extends MessageApi {
  StreamSubscription<String>? _onTokenRefresh;
  StreamSubscription<RemoteMessage>? _onForegroundMessage;
  StreamSubscription<RemoteMessage>? _backgroundNotificationOpened;
  Function(LangameNotification)? _addCallback;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  ImplMessageApi(FirebaseApi firebase) : super(firebase);

  @override
  Future<LangameResponse> initializePermissions() async {
    // FirebaseAnalytics analytics = FirebaseAnalytics();

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
    // https://firebase.flutter.dev/docs/messaging/permissions
    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      return LangameResponse(LangameStatus.succeed);
    }
    throw LangameMessagePermissionException('Permissions denied');
  }

  @override
  Future<String?> send(String recipient, String topic) async {
    // TODO: unfortunately Android only
    // firebaseMessaging.sendMessage()

    HttpsCallable callable = firebase.functions.httpsCallable(
        AppConst.sendLangameFunction,
        options: HttpsCallableOptions(timeout: Duration(seconds: 10)));

    try {
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{
          'recipient': recipient,
          'topic': topic,
        },
      );
      FirebaseFunctionsResponseSendLangame response =
          FirebaseFunctionsResponseSendLangame.fromJson(
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
      return response.result;
    } catch (e) {
      throw LangameSendLangameException(e.toString());
    }
  }

  @override
  Future<void> listen(Function(LangameNotification) add) async {
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

    Future<void> _backgroundNotificationOpen(RemoteMessage message) async {
      print('opened background message: ${message.toString()}');
    }

    _backgroundNotificationOpened = FirebaseMessaging.onMessageOpenedApp
        .listen(_backgroundNotificationOpen);
    try {
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    } catch (e) {
      print('ignoring usual FirebaseMessaging.onBackgroundMessage Null check');
    }
  }

  void _add(RemoteMessage m) {
    print("received message ${m.notification?.title}: ${m.notification?.body}");
    print("${m.data}: ${m.sentTime.toString()}");
    RemoteNotification? notification = m.notification;
    AndroidNotification? android = m.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: '@mipmap/ic_launcher',
            ),
          ));
    }
    if (m.data['id'] == null || m.data['senderUid'] == null) {
      // TODO: prob sentry whatever
      return;
    }
    if (_addCallback != null) {
      _addCallback!(LangameNotification(m.data['id'], m.data['senderUid'],
          background: true));
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
  void cancel() {
    _onTokenRefresh?.cancel();
    _onForegroundMessage?.cancel();
    // TODO: test this hack
    Future<void> _emptyHandler(RemoteMessage message) async {}
    FirebaseMessaging.onBackgroundMessage(_emptyHandler);
    _backgroundNotificationOpened?.cancel();
  }

  @override
  Future<LangameNotification?> fetch(String id) async {
    throw UnimplementedError();
  }

  Future<List<LangameNotification>?> fetchAll() async {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) {
    throw UnimplementedError();
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
}
