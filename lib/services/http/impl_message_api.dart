import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
  importance: Importance.max,
);

class ImplMessageApi extends MessageApi {
  StreamSubscription<String>? _onTokenRefresh;
  StreamSubscription<RemoteMessage>? _onForegroundMessage;
  StreamSubscription<RemoteMessage>? _onNonTerminatedOpened;
  Function(LangameNotification)? _addCallback;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// [localNotifications] stores the mapping Langame notification id -> local notification id
  final Map<String, int> localNotifications = {};

  ImplMessageApi(FirebaseApi firebase,
      void Function(LangameNotification) onBackgroundOrForegroundOpened)
      : super(firebase, onBackgroundOrForegroundOpened);

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
      onBackgroundOrForegroundOpened(pJson['question'] != null
          ? LangameNotificationReadyToPlay.fromJson(pJson)
          : LangameNotificationPlay.fromJson(pJson));
    });
    print((await flutterLocalNotificationsPlugin.pendingNotificationRequests())
        .map((e) => e.title));

    if (Platform.isAndroid) {
      List<ActiveNotification>? r = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.getActiveNotifications();

      r?.map((e) => print(e.body));
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

    _onNonTerminatedOpened = FirebaseMessaging.onMessageOpenedApp.listen((m) =>
        onBackgroundOrForegroundOpened(m.data['question'] == null
            ? LangameNotificationPlay.fromJson(m.data)
            : LangameNotificationReadyToPlay.fromJson(m.data)));
    runZonedGuarded(() {
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    },
        (_, __) => print(
            'ignoring usual FirebaseMessaging.onBackgroundMessage Null check'));
  }

  void _add(RemoteMessage m, {bool background = false}) {
    print("received message ${m.data}");
    print("${m.data}: ${m.sentTime.toString()}");
    RemoteNotification? notification = m.notification;
    AndroidNotification? android = m.notification?.android;
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
              ),
            ),
            payload: jsonEncode(m.data),
            // Then add id to local notifications
          )
          .then((value) =>
              localNotifications[m.data['id']] = notification.hashCode);
    }
    if (_addCallback != null) {
      var n = m.data['question'] == null
          ? LangameNotificationPlay.fromJson(m.data)
          : LangameNotificationReadyToPlay.fromJson(m.data);
      n.background = background;
      _addCallback!(n);
    }
  }

  Future<void> _firebaseMessagingForegroundHandler(
      RemoteMessage message) async {
    _add(message);
  }

  // https://firebase.flutter.dev/docs/messaging/usage#handling-messages
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    _add(message, background: true);
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
    throw UnimplementedError();
  }

  Future<List<LangameNotification>?> fetchAll() async {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) async {
    // await flutterLocalNotificationsPlugin.cancel(id);

    throw UnimplementedError();
    // TODO: delete in firestore
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

  @override
  Future<LangameNotification?> getInitialMessage() async {
    var m = await firebase.messaging.getInitialMessage();
    return m != null ? LangameNotification.fromJson(m.data) : null;
  }

  @override
  Future<String?> sendReadyForLangame(
      String recipient, String topic, String question) async {
    HttpsCallable callable = firebase.functions.httpsCallable(
      AppConst.sendReadyForLangameFunction,
      options: HttpsCallableOptions(
        timeout: Duration(seconds: 10),
      ),
    );

    try {
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{
          'recipient': recipient,
          'topic': topic,
          'question': question,
        },
      );
      FirebaseFunctionsResponseSendLangame response =
          FirebaseFunctionsResponseSendLangame.fromJson(
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
      return response.result;
    } catch (e) {
      throw LangameSendReadyForLangameException(e.toString());
    }
  }
}
