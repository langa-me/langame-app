import 'dart:async';
import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
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
  /// Authentication, relations, users ///

  /// Defines whether it's fake API or real
  late final AuthenticationApi authenticationApi;
  late Stream<User?> _firebaseUserStream;

  // ignore: close_sinks
  late StreamController<LangameUser?> _user;

  Stream<LangameUser?> get user {
    return _user.stream.asBroadcastStream();
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

  Future send(LangameUser recipient, String topic) async =>
      await messageApi.send(recipient.uid!, topic);

  Future<void> getNotifications() async => await messageApi.fetchAll();

  Future<void> deleteNotification(String id) {
    var f = messageApi.delete(id);
    f.then(
        (value) => _notifications.removeWhere((element) => element.id == id));
    return f;
  }

  void stopNotifications() => messageApi.cancel();

  Future<LangameResponse> _loginWith(OAuthCredential credential) async {
    try {
      await authenticationApi.loginWithFirebase(credential);
      // await user.first;
    } on FirebaseAuthException catch (e) {
      return LangameResponse(LangameStatus.failed, errorMessage: e.code);
    } on LangameFirebaseSignInException catch (e) {
      return LangameResponse(LangameStatus.failed, errorMessage: e.cause);
    } catch (e) {
      return LangameResponse(LangameStatus.failed, errorMessage: e.toString());
    }

    // Otherwise update UI and return succeed
    // notifyListeners();
    return LangameResponse(LangameStatus.succeed);
  }

  Future<LangameResponse> loginWithApple() async {
    return authenticationApi
        .loginWithApple()
        .then(_loginWith)
        .catchError(() => LangameResponse(LangameStatus.cancelled),
            test: (e) => e is LangameAppleSignInException)
        .catchError(
            (err) =>
                LangameResponse(LangameStatus.failed, errorMessage: err.cause),
            test: (e) => e is LangameGetUserException)
        .catchError((err) => LangameResponse(LangameStatus.failed,
            errorMessage: err.toString()));
  }

  Future<LangameResponse> loginWithFacebook() async {
    return authenticationApi
        .loginWithFacebook()
        .then(_loginWith)
        .catchError(() => LangameResponse(LangameStatus.cancelled),
            test: (e) => e is LangameFacebookSignInException)
        .catchError(
            (err) =>
                LangameResponse(LangameStatus.failed, errorMessage: err.cause),
            test: (e) => e is LangameGetUserException)
        .catchError((err) => LangameResponse(LangameStatus.failed,
            errorMessage: err.toString()));
  }

  Future<LangameResponse> loginWithGoogle() async {
    return authenticationApi
        .loginWithGoogle() // TODO: catch error here
        .then(_loginWith)
        .catchError((err) => LangameResponse(LangameStatus.cancelled),
            test: (e) => e is LangameGoogleSignInException)
        .catchError(
            (err) =>
                LangameResponse(LangameStatus.failed, errorMessage: err.cause),
            test: (e) => e is LangameGetUserException)
        .catchError((err) => LangameResponse(LangameStatus.failed,
            errorMessage: err.toString()));
  }

  Future<LangameResponse> getRelations() async {
    try {
      var u = await user.first;
      if (u == null)
        return LangameResponse(LangameStatus.failed,
            errorMessage: 'Not authenticated');
      _relations = await authenticationApi.getRelations(u);
      return LangameResponse(LangameStatus.succeed);
    } on LangameGetUserFriendsException catch (e) {
      return LangameResponse(LangameStatus.failed, errorMessage: e.cause);
    }
  }

  Future<List<LangameUser>> getLangameUsersStartingWithTag(String tag) async {
    return await authenticationApi.getLangameUsersStartingWithTag(tag);
  }

  Future<LangameUser?> getLangameUser(String uid) async {
    return await authenticationApi.getLangameUser(uid);
  }

  /// Create an authentication provider, and
  AuthenticationProvider(FirebaseApi firebase, {bool fake = false}) {
    // Emulator overcome fake api
    if (firebase.useEmulator) {
      print('Using emulator');
      authenticationApi = ImplAuthenticationApi(firebase);
      return;
    }
    authenticationApi = fake
        ? FakeAuthenticationApi(firebase)
        : ImplAuthenticationApi(firebase);
    _firebaseUserStream = authenticationApi.authStateChanges;
    final firebaseUserToLangameUser =
        StreamTransformer<User?, LangameUser?>.fromHandlers(
            handleData: (data, sink) async {
      if (data == null) return null;
      LangameUser? langameUser =
          await authenticationApi.getLangameUser(data.uid);
      try {
        if (langameUser == null)
          langameUser = await authenticationApi.addLangameUser(data);
      } on LangameAddUserException catch (e) {
        print(LangameResponse(LangameStatus.failed, errorMessage: e.cause));
      } catch (e) {
        print(
            LangameResponse(LangameStatus.failed, errorMessage: e.toString()));
      }
      sink.add(langameUser);
    });
    _user = StreamController.broadcast();
    _user.addStream(Stream.empty()).then((_) {
      _firebaseUserStream.transform(firebaseUserToLangameUser).pipe(_user);
    });
  }

  Future<LangameResponse> initializeMessageApi({bool fake = false}) async {
    messageApi = fake
        ? FakeMessageApi(authenticationApi.firebase)
        : ImplMessageApi(authenticationApi.firebase);
    try {
      messageApi.initializePermissions();
      await messageApi.listen(_onNotificationHandler);
    } on LangameMessageException catch (e) {
      return LangameResponse(LangameStatus.failed, errorMessage: e.cause);
    } catch (e) {
      return LangameResponse(LangameStatus.failed, errorMessage: e.toString());
    }
    return LangameResponse(LangameStatus.succeed);
  }
}
