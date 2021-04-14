import 'dart:async';
import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/models/channel.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/notification.dart';
import 'package:langame/models/question.dart';
import 'package:langame/models/user.dart';
import 'package:langame/services/http/authentication_api.dart';
import 'package:langame/services/http/fake_authentication_api.dart';
import 'package:langame/services/http/fake_message_api.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:langame/services/http/impl_authentication_api.dart';
import 'package:langame/services/http/impl_message_api.dart';
import 'package:langame/services/http/message_api.dart';

class AuthenticationProvider extends ChangeNotifier {
  FirebaseApi firebase;

  /// Authentication, relations, users ///

  /// Defines whether it's fake API or real
  late final AuthenticationApi authenticationApi;
  late Stream<User?> _firebaseUserStream;

  // ignore: close_sinks
  late StreamController<LangameUser?> _userStream;

  Stream<LangameUser?> get userStream {
    return _userStream.stream.asBroadcastStream();
  }

  LangameUser? _user;

  LangameUser? get user {
    return _user;
  }

  LangameUserRelations? _relations;

  /// Known people = friends, only this use relations
  LangameUserRelations? get relations {
    return _relations;
  }

  /// Messages, notifications ///

  /// Defines whether it's fake API or real
  late final MessageApi messageApi;

  /// In-memory local notifications
  List<LangameNotification> _notifications =
      []; // TODO: should automatically delete too old notifications?
  UnmodifiableListView<LangameNotification> get notifications =>
      UnmodifiableListView(_notifications);

  void _onNotificationHandler(LangameNotification? notification) {
    if (notification != null) _notifications.add(notification);
    notifyListeners();
  }

  Future<LangameResponse> send(
      List<LangameUser> recipients, List<Question> topics) async {
    try {
      debugPrint(recipients.map((e) => e.uid!).join(','));
      // TODO: we'd likely send the whole  topic in the future (with classifications)
      await messageApi.send(recipients.map((e) => e.uid!).toList(),
          topics.map((e) => e.question).toList());
    } catch (e, s) {
      firebase.crashlytics.log('failed to send langame');
      firebase.crashlytics.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }

  Future<LangameResponse> sendReadyForLangame(String channelName) async {
    try {
      await messageApi.sendReadyForLangame(channelName);
    } catch (e, s) {
      firebase.crashlytics.log('failed to sendReadyForLangame');
      firebase.crashlytics.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }

  Future<LangameResponse<String>> getChannelToken(String channelName) async {
    try {
      var r = await authenticationApi.getChannelToken(channelName);
      return LangameResponse<String>(LangameStatus.succeed, result: r);
    } catch (e, s) {
      firebase.crashlytics.log('failed to get channel $channelName token');
      firebase.crashlytics.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<LangameChannel>> getChannel(String channelName) async {
    try {
      var r = await authenticationApi.getChannel(channelName);
      return LangameResponse<LangameChannel>(LangameStatus.succeed, result: r);
    } catch (e, s) {
      firebase.crashlytics.log('failed to get channel $channelName');
      firebase.crashlytics.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<LangameNotification>> getNotification(
      String id) async {
    try {
      var r = await messageApi.fetch(id);
      return LangameResponse<LangameNotification>(LangameStatus.succeed,
          result: r);
    } catch (e, s) {
      firebase.crashlytics.log('failed to getNotification');
      firebase.crashlytics.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  // TODO: use langame resp
  Future<void> getNotifications() async => await messageApi.fetchAll();

  Future<LangameResponse<void>> deleteNotification(String id) async {
    try {
      var f = messageApi.delete(id);
      f
          .then((value) =>
              _notifications.removeWhere((element) => element.id == id))
          .then((value) => notifyListeners());
      // return f;
    } catch (e, s) {
      firebase.crashlytics.log('failed to deleteNotification');
      firebase.crashlytics.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }

  void stopNotifications() => messageApi.cancel();

  Future<LangameResponse> _loginWith(OAuthCredential credential) async {
    try {
      await authenticationApi.loginWithFirebase(credential);
    } catch (e, s) {
      firebase.crashlytics.log('failed to _loginWith');
      firebase.crashlytics.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    firebase.analytics.logLogin();
    return LangameResponse(LangameStatus.succeed);
  }

  Future<LangameResponse> loginWithApple() async {
    return authenticationApi
        .loginWithApple()
        .then(_loginWith)
        .catchError(() => LangameResponse(LangameStatus.cancelled),
            test: (e) => e is LangameAppleSignInException)
        .catchError((e, s) {
      firebase.crashlytics.log('failed to loginWithApple');
      firebase.crashlytics.recordError(e, s);
      LangameResponse(LangameStatus.failed, error: e.toString());
    });
  }

  Future<LangameResponse> loginWithFacebook() async {
    return authenticationApi
        .loginWithFacebook()
        .then(_loginWith)
        .catchError(() => LangameResponse(LangameStatus.cancelled),
            test: (e) => e is LangameFacebookSignInException)
        .catchError((e, s) {
      firebase.crashlytics.log('failed to loginWithFacebook');
      firebase.crashlytics.recordError(e, s);
      LangameResponse(LangameStatus.failed, error: e.toString());
    });
  }

  Future<LangameResponse> loginWithGoogle() async {
    return authenticationApi
        .loginWithGoogle() // TODO: catch error here
        .then(_loginWith)
        .catchError((err) => LangameResponse(LangameStatus.cancelled),
            test: (e) => e is LangameGoogleSignInException)
        .catchError((e, s) {
      firebase.crashlytics.log('failed to loginWithGoogle');
      firebase.crashlytics.recordError(e, s);
      LangameResponse(LangameStatus.failed, error: e.toString());
    });
  }

  Future<LangameResponse> getRelations() async {
    throw UnimplementedError();
  }

  // TODO langame response
  Future<List<LangameUser>> getLangameUsersStartingWithTag(String tag) async {
    return await authenticationApi.getLangameUsersStartingWithTag(tag);
  }

  Future<LangameResponse<LangameUser>> getLangameUser(String uid) async {
    try {
      var r = await authenticationApi.getLangameUser(uid);
      return LangameResponse<LangameUser>(LangameStatus.succeed, result: r);
    } catch (e, s) {
      firebase.crashlytics.log('failed to getLangameUser $uid');
      firebase.crashlytics.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<List<LangameUser>>> getLangameUsers(
      List<String> userIds) async {
    try {
      List<LangameUser> r = [];
      for (var i = 0; i < userIds.length; i++) {
        var user = await authenticationApi.getLangameUser(userIds[i]);
        if (user != null) r.add(user);
      }
      return LangameResponse<List<LangameUser>>(LangameStatus.succeed,
          result: r);
    } catch (e, s) {
      firebase.crashlytics.log('failed to get users ${userIds.join(",")}');
      firebase.crashlytics.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  /// Create an authentication provider, and
  AuthenticationProvider(this.firebase, {bool fake = false}) {
    // Emulator overcome fake api
    if (firebase.useEmulator) {
      print('Using emulator');
      authenticationApi = ImplAuthenticationApi(firebase);
    } else {
      authenticationApi = fake
          ? FakeAuthenticationApi(firebase)
          : ImplAuthenticationApi(firebase);
    }
    _firebaseUserStream = authenticationApi.userChanges;
    _userStream = StreamController.broadcast();
    _firebaseUserStream.listen((data) async {
      if (data == null) return null;
      try {
        await firebase.crashlytics.setUserIdentifier(data.uid);
        await firebase.analytics.setUserId(data.uid);
        _user = await authenticationApi.getLangameUser(data.uid);
        if (_user == null) {
          _user = await authenticationApi.addLangameUser(data);
        }
      } catch (e, s) {
        firebase.crashlytics.log(
            'failed to setup user on firebase stream change uid: ${data.uid}');
        firebase.crashlytics.recordError(e, s);
      }
      _userStream.add(_user);
      notifyListeners();
    });
  }

  Future<LangameResponse> initializeMessageApi(
      void Function(LangameNotification?) onBackgroundOrForegroundOpened,
      {bool fake = false}) async {
    messageApi = fake
        ? FakeMessageApi(
            authenticationApi.firebase, onBackgroundOrForegroundOpened)
        : ImplMessageApi(
            authenticationApi.firebase, onBackgroundOrForegroundOpened);
    try {
      await messageApi.initializePermissions();
      await messageApi.listen(_onNotificationHandler);
      // i.e. no internet
      // TODO  Caused by: java.net.UnknownHostException: Unable to resolve host "firestore.googleapis.com": No address associated with hostname
    } catch (e, s) {
      firebase.crashlytics.log('failed to initializeMessageApi');
      firebase.crashlytics.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }
}
