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

  ImplMessageApi(FirebaseApi firebase,
      void Function(LangameNotification?) onBackgroundOrForegroundOpened)
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
            channel.description,
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
      onBackgroundOrForegroundOpened(n);
    });

    if (Platform.isAndroid) {
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
      return LangameResponse(LangameStatus.succeed);
    }
    throw LangameMessagePermissionException('Permissions denied');
  }

  @override
  Future<String> send(List<String> recipients, List<String> topics) async {
    HttpsCallable callable = firebase.functions!.httpsCallable(
        AppConst.sendLangameFunction,
        options: HttpsCallableOptions(timeout: Duration(seconds: 10)));

    try {
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{
          'recipients': recipients,
          'topics': topics,
        },
      );
      FirebaseFunctionsResponse response = FirebaseFunctionsResponse.fromJson(
          Map<String, dynamic>.from(result.data));
      switch (response.statusCode) {
        case FirebaseFunctionsResponseStatusCode.OK:
          return response.result!['channelName'];
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
  Future<void> sendLangameEnd(String channelName) async {
    HttpsCallable callable = firebase.functions!.httpsCallable(
        AppConst.sendLangameEndFunction,
        options: HttpsCallableOptions(timeout: Duration(seconds: 10)));

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
          throw LangameSendEndException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.BAD_REQUEST.toString());
        case FirebaseFunctionsResponseStatusCode.UNAUTHORIZED:
          throw LangameSendEndException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.UNAUTHORIZED.toString());
        case FirebaseFunctionsResponseStatusCode.INTERNAL:
          throw LangameSendEndException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.INTERNAL.toString());
      }
    } catch (e) {
      throw LangameSendEndException(e.toString());
    }
  }

  @override
  Future<void> notifyPresence(String channelName) async {
    HttpsCallable callable = firebase.functions!.httpsCallable(
      AppConst.notifyPresenceFunction,
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
          throw LangameNotifyPresenceException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.BAD_REQUEST.toString());
        case FirebaseFunctionsResponseStatusCode.UNAUTHORIZED:
          throw LangameNotifyPresenceException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.UNAUTHORIZED.toString());
        case FirebaseFunctionsResponseStatusCode.INTERNAL:
          throw LangameNotifyPresenceException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.INTERNAL.toString());
      }
    } catch (e) {
      throw LangameNotifyPresenceException(e.toString());
    }
  }

  @override
  Future<void> listen(Function(LangameNotification?) add) async {
    // Get the token each time the application loads
    String? token = await firebase.messaging!.getToken();

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

    _onNonTerminatedOpened = FirebaseMessaging.onMessageOpenedApp
        .listen((m) => fetch(m.data['id']).then((n) {
              n?.id = m.data['id'];
              onBackgroundOrForegroundOpened(n);
            }));
    runZonedGuarded(() {
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    },
        (_, __) => debugPrint(
            'ignoring usual FirebaseMessaging.onBackgroundMessage Null check'));
  }

  Future<void> _emptyHandler(RemoteMessage message) async {}
  @override
  void cancel() {
    _onTokenRefresh?.cancel();
    _onForegroundMessage?.cancel();
    FirebaseMessaging.onBackgroundMessage(_emptyHandler);
    _onNonTerminatedOpened?.cancel();
  }

  @override
  Future<LangameNotification?> fetch(String id) async {
    CollectionReference notifications = firebase.firestore!
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
  Future<List<LangameNotification>> fetchAll() async {
    CollectionReference notifications = firebase.firestore!
        .collection(AppConst.firestoreNotificationsCollection);
    QuerySnapshot query = await notifications
        .where('recipientsUid', arrayContains: firebase.auth!.currentUser?.uid)
        .get();
    // If there is any non-null notifications, return all of them
    return query.docs.where((n) => n.exists).map((n) {
      var ln = LangameNotification.fromJson(n.data());
      ln.id = n.id;
      return ln;
    }).toList();
  }

  @override
  Future<void> delete(String channelName) async {
    var ns = await firebase.firestore!
        .collection(AppConst.firestoreNotificationsCollection)
        .where('channelName', isEqualTo: channelName)
        .where('recipientsUid', arrayContains: firebase.auth!.currentUser!.uid)
        .get();
    ns.docs.where((e) => e.exists).forEach((e) => firebase.firestore!
        .collection(AppConst.firestoreNotificationsCollection)
        .doc(e.id)
        .delete());

    // TODO: not sure it ever worked? (trying to delete notifications in status bar)
    return await flutterLocalNotificationsPlugin.cancel(0, tag: channelName);
  }

  Future<void> _saveTokenToDatabase(String token) async {
    // Assume user is logged in for this example
    String? userId = firebase.auth!.currentUser?.uid;

    // Somehow the user is not authenticated anymore but in the app
    if (userId == null) throw LangameNotAuthenticatedException();

    HttpsCallable callable = firebase.functions!.httpsCallable(
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
          firebase.crashlytics?.log('new FCM token');
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
    var rawNotification =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (rawNotification == null || rawNotification.payload == null) return null;
    var json = jsonDecode(rawNotification.payload!);
    if (json['id'] == null) return null;
    var notification = await fetch(json['id']);
    return notification;
  }
}
