import 'dart:async';
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/notification.dart';
import 'package:langame/models/user.dart';
import 'package:langame/services/http/authentication_api.dart';
import 'package:langame/services/http/fake_authentication_api.dart';
import 'package:langame/services/http/fake_message_api.dart';
import 'package:langame/services/http/impl_authentication_api.dart';
import 'package:langame/services/http/impl_message_api.dart';
import 'package:langame/services/http/message_api.dart';

class LangameResponse {
  final LangameStatus status;
  final String? errorMessage;

  LangameResponse(this.status, {this.errorMessage});
}

enum LangameStatus { cancelled, failed, succeed }

class AuthenticationProvider extends ChangeNotifier {
  /// Authentication, relations, users ///

  /// Defines whether it's fake API or real
  late final AuthenticationApi authenticationApi;
  late Stream<User?> _firebaseUserStream;
  LangameUser? _user;

  LangameUser? get user {
    // TODO: pipe firebase stream to langame user stream
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

  /// Stream of messages
  // ignore: close_sinks
  final _notificationsStream =
      StreamController<LangameNotification>.broadcast();

  Stream<LangameNotification> get notificationsStream {
    return _notificationsStream.stream.asBroadcastStream();
  }

  void _add(LangameNotification notification) {
    _notifications.add(notification);
    _notificationsStream.add(notification);
    notifyListeners();
  }

  Future send(String topic) async => messageApi.send(topic);

  void getNotifications() => messageApi.get();

  Future<void> deleteNotification(LangameNotification n) {
    var f = messageApi.delete(n);
    f.then(
        (value) => _notifications.removeWhere((element) => element.id == n.id));
    return f;
  }

  void stopNotifications() => messageApi.stopReceiving();

  Future<LangameResponse> _loginWith(OAuthCredential credential) async {
    try {
      _firebaseUserStream =
          await authenticationApi.loginWithFirebase(credential);
    } on FirebaseAuthException catch (e) {
      return LangameResponse(LangameStatus.failed, errorMessage: e.code);
    } on FirebaseSignInException catch (e) {
      return LangameResponse(LangameStatus.failed, errorMessage: e.cause);
    } catch (e) {
      return LangameResponse(LangameStatus.failed, errorMessage: e.toString());
    }
    User? u;

    try {
      u = await _firebaseUserStream.first;
      if (u == null)
        throw GetUserException(cause: 'failed to get user from Firebase');
    } catch (e) {
      return LangameResponse(LangameStatus.failed, errorMessage: e.toString());
    }

    LangameUser? langameUser = await authenticationApi.getLangameUser(u.uid);
    try {
      if (langameUser == null)
        langameUser = await authenticationApi.addLangameUser(u);
    } on AddUserException catch (e) {
      LangameResponse(LangameStatus.failed, errorMessage: e.cause);
    } catch (e) {
      LangameResponse(LangameStatus.failed, errorMessage: e.toString());
    }
    // Set the user
    _user = langameUser;
    // Once authenticated, get friends
    // var getRelationsResponse = await getRelations();
    // If it failed, return
    // if (getRelationsResponse.status != LoginStatus.succeed)
    //   return getRelationsResponse;
    // Otherwise update UI and return succeed
    notifyListeners();
    return LangameResponse(LangameStatus.succeed);
  }

  Future<LangameResponse> loginWithApple() async {
    return authenticationApi
        .loginWithApple()
        .then(_loginWith)
        .catchError(() => LangameResponse(LangameStatus.cancelled),
            test: (e) => e is AppleSignInException)
        .catchError(
            (err) =>
                LangameResponse(LangameStatus.failed, errorMessage: err.cause),
            test: (e) => e is GetUserException)
        .catchError((err) => LangameResponse(LangameStatus.failed,
            errorMessage: err.toString()));
  }

  Future<LangameResponse> loginWithFacebook() async {
    return authenticationApi
        .loginWithFacebook()
        .then(_loginWith)
        .catchError(() => LangameResponse(LangameStatus.cancelled),
            test: (e) => e is FacebookSignInException)
        .catchError(
            (err) =>
                LangameResponse(LangameStatus.failed, errorMessage: err.cause),
            test: (e) => e is GetUserException)
        .catchError((err) => LangameResponse(LangameStatus.failed,
            errorMessage: err.toString()));
  }

  Future<LangameResponse> loginWithGoogle() async {
    return authenticationApi
        .loginWithGoogle()
        .then(_loginWith)
        .catchError((err) => LangameResponse(LangameStatus.cancelled),
            test: (e) => e is GoogleSignInException)
        .catchError(
            (err) =>
                LangameResponse(LangameStatus.failed, errorMessage: err.cause),
            test: (e) => e is GetUserException)
        .catchError((err) => LangameResponse(LangameStatus.failed,
            errorMessage: err.toString()));
  }

  Future<LangameResponse> getRelations() async {
    if (_user != null) {
      try {
        _relations = (await authenticationApi.getRelations(_user!));
        return LangameResponse(LangameStatus.succeed);
      } on GetUserFriendsException catch (e) {
        return LangameResponse(LangameStatus.failed, errorMessage: e.cause);
      }
    }
    return LangameResponse(LangameStatus.failed,
        errorMessage: 'Not authenticated');
  }

  Future<List<LangameUser>> getLangameUsersStartingWithTag(String tag) async {
    return await authenticationApi.getLangameUsersStartingWithTag(tag);
  }

  /// Create an authentication provider, and
  AuthenticationProvider(
      FirebaseAuth firebaseAuth,
      FirebaseFunctions firebaseFunctions,
      FirebaseFirestore firebaseFirestore,
      GoogleSignIn googleSignIn,
      {bool fakeAuthentication = false,
      bool fakeMessage = true,
      bool emulator = false}) {
    // Emulator overcome fake api
    if (emulator) {
      /// https://firebase.google.com/docs/emulator-suite
      /// Warning: change local IP accordingly i.e. `ip a`
      /// then from mobile `telnet IP PORT`
      firebaseAuth.useEmulator('http://192.168.1.102:9099');
      firebaseFunctions.useFunctionsEmulator(
          origin: 'http://192.168.1.102:5001');
      firebaseFirestore.settings = Settings(
        host: '192.168.1.102:8080',
        sslEnabled: false,
      );
      authenticationApi = ImplAuthenticationApi(
          firebaseAuth, firebaseFunctions, firebaseFirestore, googleSignIn);
      messageApi = ImplMessageApi(_add);
      return;
    }
    authenticationApi = fakeAuthentication
        ? FakeAuthenticationApi(
            firebaseAuth, firebaseFunctions, firebaseFirestore, googleSignIn)
        : ImplAuthenticationApi(
            firebaseAuth, firebaseFunctions, firebaseFirestore, googleSignIn);
    messageApi = fakeMessage ? FakeMessageApi(_add) : ImplMessageApi(_add);
  }
}
