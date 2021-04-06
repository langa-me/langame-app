import 'dart:async';
import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/notification.dart';
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

  // /// Stream of messages
  // // ignore: close_sinks
  // final _notificationsStream =
  //     StreamController<LangameNotification>.broadcast();
  //
  // Stream<LangameNotification> get notificationsStream {
  //   return _notificationsStream.stream.asBroadcastStream();
  // }

  void _onNotificationHandler(LangameNotification notification) {
    _notifications.add(notification);
    // _notificationsStream.add(notification);
    notifyListeners();
  }

  Future<LangameResponse> send(
      List<LangameUser> recipients, String topic) async {
    try {
      await messageApi.send(recipients.map((e) => e.uid!).toList(), topic);
    } catch (e, s) {
      firebase.crashlytics.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }

  Future<LangameResponse> sendReadyForLangame(
      List<String> recipientsUid, String topic, String question) async {
    try {
      await messageApi.sendReadyForLangame(recipientsUid, topic, question);
    } catch (e, s) {
      firebase.crashlytics.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }

  Future<void> getNotifications() async => await messageApi.fetchAll();

  Future<void> deleteNotification(String id) {
    var f = messageApi.delete(id);
    f
        .then((value) =>
            _notifications.removeWhere((element) => element.id == id))
        .then((value) => notifyListeners());
    return f;
  }

  void stopNotifications() => messageApi.cancel();

  Future<LangameResponse> _loginWith(OAuthCredential credential) async {
    try {
      await authenticationApi.loginWithFirebase(credential);
    } catch (e, s) {
      firebase.crashlytics.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }

  Future<LangameResponse> loginWithApple() async {
    return authenticationApi
        .loginWithApple()
        .then(_loginWith)
        .catchError(() => LangameResponse(LangameStatus.cancelled),
            test: (e) => e is LangameAppleSignInException)
        .catchError((err) =>
            LangameResponse(LangameStatus.failed, error: err.toString()));
  }

  Future<LangameResponse> loginWithFacebook() async {
    return authenticationApi
        .loginWithFacebook()
        .then(_loginWith)
        .catchError(() => LangameResponse(LangameStatus.cancelled),
            test: (e) => e is LangameFacebookSignInException)
        .catchError((err) =>
            LangameResponse(LangameStatus.failed, error: err.toString()));
  }

  Future<LangameResponse> loginWithGoogle() async {
    return authenticationApi
        .loginWithGoogle() // TODO: catch error here
        .then(_loginWith)
        .catchError((err) => LangameResponse(LangameStatus.cancelled),
            test: (e) => e is LangameGoogleSignInException)
        .catchError((err) =>
            LangameResponse(LangameStatus.failed, error: err.toString()));
  }

  Future<LangameResponse> getRelations() async {
    try {
      var u = await userStream.first;
      if (u == null)
        return LangameResponse(LangameStatus.failed,
            error: 'Not authenticated');
      _relations = await authenticationApi.getRelations(u);
      return LangameResponse(LangameStatus.succeed);
    } on LangameGetUserFriendsException catch (e, s) {
      firebase.crashlytics.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e.cause);
    }
  }

  Future<List<LangameUser>> getLangameUsersStartingWithTag(String tag) async {
    return await authenticationApi.getLangameUsersStartingWithTag(tag);
  }

  Future<LangameUser?> getLangameUser(String uid) async {
    return await authenticationApi.getLangameUser(uid);
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
    _firebaseUserStream.listen((data) async {
      if (data == null) return null;
      try {
        _user = await authenticationApi.getLangameUser(data.uid);
        if (_user == null) {
          _user = await authenticationApi.addLangameUser(data);
        }
        // } on LangameAddUserException catch (e) {
        //   // Fail at addLangameUser
        //   print(e.cause);
        // } on LangameAuthException catch (e) {
        //   // Fail at generateTag
        //   print(e.cause);
      } catch (e, s) {
        firebase.crashlytics.recordError(e, s);
        if (!kReleaseMode) {
          debugPrint(e.toString());
          debugPrint(s.toString());
        }
      }
      notifyListeners();
    });
    final firebaseUserToLangameUser =
        StreamTransformer<User?, LangameUser?>.fromHandlers(
            handleData: (data, sink) async {
      if (data == null) return null;
      LangameUser? langameUser =
          await authenticationApi.getLangameUser(data.uid);
      try {
        if (langameUser == null) {
          langameUser = await authenticationApi.addLangameUser(data);
        }
        // } on LangameAddUserException catch (e) {
        //   // Fail at addLangameUser
        //   print(e.cause);
        // } on LangameAuthException catch (e) {
        //   // Fail at generateTag
        //   print(e.cause);
      } catch (e, s) {
        firebase.crashlytics.recordError(e, s);
        if (!kReleaseMode) {
          debugPrint(e.toString());
          debugPrint(s.toString());
        }
      }
      sink.add(langameUser);
    });
    _userStream = StreamController.broadcast();
    _userStream.addStream(Stream.empty()).then((_) {
      _firebaseUserStream
          .transform(firebaseUserToLangameUser)
          .pipe(_userStream);
    });
  }

  Future<LangameResponse> initializeMessageApi(
      void Function(LangameNotification) onBackgroundOrForegroundOpened,
      {bool fake = false}) async {
    messageApi = fake
        ? FakeMessageApi(
            authenticationApi.firebase, onBackgroundOrForegroundOpened)
        : ImplMessageApi(
            authenticationApi.firebase, onBackgroundOrForegroundOpened);
    try {
      await messageApi.initializePermissions();
      await messageApi.listen(_onNotificationHandler);
    } catch (e, s) {
      firebase.crashlytics.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e);
    }
    return LangameResponse(LangameStatus.succeed);
  }
}
