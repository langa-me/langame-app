import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/models/notification.dart';
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
  late StreamController<lg.User?> _userStream;

  Stream<lg.User?> get userStream {
    return _userStream.stream.asBroadcastStream();
  }

  lg.User? _user;

  lg.User? get user {
    return _user;
  }

  List<lg.User> _userRecommendations = [];

  List<lg.User> get userRecommendations {
    return _userRecommendations;
  }

  /// Messages, notifications ///

  /// Defines whether it's fake API or real
  late final MessageApi messageApi;

  /// In-memory local notifications
  List<LangameNotification> _notifications = [];
  List<LangameNotification> get notifications => _notifications;

  void _log(String msg) {
    if (kDebugMode) debugPrint(msg);
    firebase.crashlytics?.log(msg);
  }

  void _onNotificationHandler(LangameNotification? notification) {
    if (notification == null) return;
    _notifications.add(notification);
    notifyListeners();
  }

  Future<LangameResponse<String>> send(
      List<lg.User> recipients, List<lg.Topic> topics,
      {bool now = false}) async {
    try {
      final String msg =
          'send langame to ${recipients.map((e) => e.uid).join(',')}';
      _log(msg);

      // TODO: we'd likely send the whole  topic in the future (with classifications)
      var channelName = await messageApi.send(
          recipients.map((e) => e.uid).toList(),
          topics.map((e) => e.content).toList());
      if (now) await notifyPresence(channelName);
      return LangameResponse(LangameStatus.succeed, result: channelName);
    } catch (e, s) {
      _log('failed to send langame');
      firebase.crashlytics?.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse> notifyPresence(String channelName) async {
    try {
      await messageApi.notifyPresence(channelName);
      _log('notifyPresence');
    } catch (e, s) {
      _log('failed to notifyPresence');
      firebase.crashlytics?.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }

  Future<LangameResponse<String>> getChannelToken(String channelName) async {
    try {
      var r = await authenticationApi.getChannelToken(channelName);
      _log('getChannelToken $r');
      return LangameResponse<String>(LangameStatus.succeed, result: r);
    } catch (e, s) {
      _log('failed to get channel $channelName token');
      firebase.crashlytics?.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<lg.Langame>> getChannel(String channelName) async {
    try {
      var r = await authenticationApi.getChannel(channelName);
      _log('getChannel ${r.channelName}');
      return LangameResponse<lg.Langame>(LangameStatus.succeed, result: r);
    } catch (e, s) {
      _log('failed to get channel $channelName');
      firebase.crashlytics?.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  /// Get a precise notification
  Future<LangameResponse<LangameNotification>> getNotification(
      String id) async {
    try {
      var r = await messageApi.fetch(id);
      _log('getNotification ${r?.channelName}');
      return LangameResponse<LangameNotification>(LangameStatus.succeed,
          result: r);
    } catch (e, s) {
      _log('failed to getNotification');
      firebase.crashlytics?.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  // TODO: use langame resp
  Future<LangameResponse<void>> fetchNotifications() async {
    try {
      var r = await messageApi.fetchAll(); // TODO: make it a generator
      r.forEach((n) {
        _notifications.add(n);
        notifyListeners();
      });
      _log('fetchNotifications');
      return LangameResponse<LangameNotification>(LangameStatus.succeed);
    } catch (e, s) {
      _log('failed to fetchNotifications');
      firebase.crashlytics?.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<void>> deleteNotification(String channelName) async {
    try {
      var f = messageApi.delete(channelName);
      f
          .then((value) => _notifications
              .removeWhere((element) => element.channelName == channelName))
          .then((value) => notifyListeners());
      _log('deleteNotification');
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      _log('failed to deleteNotification');
      firebase.crashlytics?.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  void stopNotifications() => messageApi.cancel();

  Future<LangameResponse> _loginWith(OAuthCredential credential) async {
    try {
      await authenticationApi.loginWithFirebase(credential);
      _log('_loginWith');
    } catch (e, s) {
      _log('failed to _loginWith');
      firebase.crashlytics?.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    firebase.analytics?.logLogin();
    return LangameResponse(LangameStatus.succeed);
  }

  Future<LangameResponse> loginWithApple() async {
    return authenticationApi
        .loginWithApple()
        .then(_loginWith)
        .catchError(() => LangameResponse(LangameStatus.cancelled),
            test: (e) => e is LangameAppleSignInException)
        .catchError((e, s) {
      _log('failed to loginWithApple');
      firebase.crashlytics?.recordError(e, s);
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
      _log('failed to loginWithFacebook');
      firebase.crashlytics?.recordError(e, s);
      LangameResponse(LangameStatus.failed, error: e.toString());
    });
  }

  Future<LangameResponse> loginWithGoogle() async {
    return authenticationApi
        .loginWithGoogle() // TODO: catch error here
        .catchError((e, s) {
          _log('failed to loginWithGoogle');
          firebase.crashlytics?.recordError(e, s);
          LangameResponse(LangameStatus.failed, error: e.toString());
        })
        .then(_loginWith)
        .catchError((err) => LangameResponse(LangameStatus.cancelled),
            test: (e) => e is LangameGoogleSignInException);
  }

  Future<LangameResponse> getRelations() async {
    throw UnimplementedError();
  }

  // TODO langame response
  Future<List<lg.User>> getLangameUsersStartingWithTag(String tag) async {
    _log('getLangameUsersStartingWithTag $tag');
    return await authenticationApi.getLangameUsersStartingWithTag(
        _user!.tag, tag);
  }

  Future<LangameResponse<lg.User>> getLangameUser(String uid) async {
    try {
      var r = await authenticationApi.getLangameUser(uid);
      _log('getLangameUser $uid');
      return LangameResponse<lg.User>(LangameStatus.succeed, result: r);
    } catch (e, s) {
      _log('failed to getLangameUser $uid');
      firebase.crashlytics?.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<List<lg.User>>> getLangameUsers(
      List<String> userIds) async {
    try {
      List<lg.User> r = [];
      for (var i = 0; i < userIds.length; i++) {
        var user = await authenticationApi.getLangameUser(userIds[i]);
        if (user != null) r.add(user);
      }
      _log('getLangameUsers ${userIds.join(",")}');
      return LangameResponse<List<lg.User>>(LangameStatus.succeed, result: r);
    } catch (e, s) {
      _log('failed to get users ${userIds.join(",")}');
      firebase.crashlytics?.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<void>> getUserRecommendations() async {
    try {
      _userRecommendations =
          await authenticationApi.getUserRecommendations(_user!);
      _log('getUserRecommendations ${user!.uid}');
      notifyListeners();
      return LangameResponse<void>(LangameStatus.succeed);
    } catch (e, s) {
      _log('failed to getUserRecommendations ${user?.uid}');
      firebase.crashlytics?.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<void>> sendLangameEnd(String channelName) async {
    try {
      await authenticationApi.sendLangameEnd(channelName);
      _log('sendLangameEnd $channelName');
      return LangameResponse<void>(LangameStatus.succeed);
    } catch (e, s) {
      _log('failed to sendLangameEnd $channelName');
      firebase.crashlytics?.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
  }

  Future<LangameResponse<lg.InteractionLevel?>> getInteraction(
      String otherUid) async {
    try {
      var r = await authenticationApi.getInteraction(_user!.uid, otherUid);
      _log('getInteraction $otherUid');
      if (r == null)
        return LangameResponse(LangameStatus.failed, error: 'no interactions');
      return LangameResponse(LangameStatus.succeed,
          result: r.toInteractionLevel());
    } catch (e, s) {
      _log('failed to getInteraction $otherUid');
      firebase.crashlytics?.recordError(e, s);
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
        await firebase.crashlytics?.setUserIdentifier(data.uid);
        await firebase.analytics?.setUserId(data.uid);
        _user = await authenticationApi.getLangameUser(data.uid);
        if (_user == null) {
          _user = await authenticationApi.addLangameUser(data);
        }
      } catch (e, s) {
        _log('failed to setup user on firebase stream change uid: ${data.uid}');
        firebase.crashlytics?.recordError(e, s);
      }
      _log('_firebaseUserStream.listen ${_user?.uid}');
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
      _log('failed to initializeMessageApi');
      firebase.crashlytics?.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }
}
