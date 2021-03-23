import 'dart:async';
import 'dart:collection';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/notification.dart';
import 'package:langame/models/user.dart';
import 'package:langame/services/http/authentication_api.dart';
import 'package:langame/services/http/fake_authentication_api.dart';
import 'package:langame/services/http/fake_message_api.dart';
import 'package:langame/services/http/impl_authentication_api.dart';
import 'package:langame/services/http/impl_message_api.dart';
import 'package:langame/services/http/message_api.dart';

class LoginResponse {
  final LoginStatus status;
  final String? errorMessage;

  LoginResponse(this.status, {this.errorMessage});
}

enum LoginStatus { cancelled, failed, succeed }

class AuthenticationProvider extends ChangeNotifier {
  /// Authentication, relations, users ///

  /// Defines whether it's fake API or real
  bool _fakeAuthenticationApi = true;
  late AuthenticationApi _authenticationApi;
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
  bool _fakeMessageApi = true;
  late MessageApi _messageApi;

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

  Future send(String topic) async => _messageApi.send(topic);
  void getNotifications() => _messageApi.get();
  Future<void> deleteNotification(LangameNotification n) {
    var f = _messageApi.delete(n);
    f.then(
        (value) => _notifications.removeWhere((element) => element.id == n.id));
    return f;
  }

  Future<LoginResponse> _loginWith(OAuthCredential credential) async {
    try {
      _firebaseUserStream =
          await _authenticationApi.loginWithFirebase(credential);
    } on FirebaseAuthException catch (e) {
      return LoginResponse(LoginStatus.failed, errorMessage: e.code);
    } on FirebaseSignInException catch (e) {
      return LoginResponse(LoginStatus.failed, errorMessage: e.cause);
    } catch (e) {
      return LoginResponse(LoginStatus.failed, errorMessage: e.toString());
    }
    User? u = await _firebaseUserStream.first;
    if (u == null)
      return LoginResponse(LoginStatus.failed,
          errorMessage: 'failed to get user from Firebase');
    LangameUser? langameUser = await _authenticationApi.getLangameUser(u.uid);
    try {
      if (langameUser == null) await _authenticationApi.addLangameUser(u);
    } on AddUserException catch (e) {
      LoginResponse(LoginStatus.failed, errorMessage: e.cause);
    } catch (e) {
      LoginResponse(LoginStatus.failed, errorMessage: e.toString());
    }
    // Once authenticated, get friends
    var getRelationsResponse = await getRelations();
    // If it failed, return
    if (getRelationsResponse.status != LoginStatus.succeed)
      return getRelationsResponse;
    // Otherwise update UI and return succeed
    notifyListeners();
    return LoginResponse(LoginStatus.succeed);
  }

  Future<LoginResponse> loginWithApple() async {
    return _authenticationApi
        .loginWithApple()
        .then(_loginWith)
        .catchError(() => LoginResponse(LoginStatus.cancelled),
            test: (e) => e is AppleSignInException)
        .catchError((err) =>
            LoginResponse(LoginStatus.failed, errorMessage: err.cause));
  }

  Future<LoginResponse> loginWithFacebook() async {
    return _authenticationApi
        .loginWithFacebook()
        .then(_loginWith)
        .catchError(() => LoginResponse(LoginStatus.cancelled),
            test: (e) => e is FacebookSignInException)
        .catchError((err) =>
            LoginResponse(LoginStatus.failed, errorMessage: err.cause));
  }

  Future<LoginResponse> loginWithGoogle() async {
    return _authenticationApi
        .loginWithGoogle()
        .then(_loginWith)
        .catchError(() => LoginResponse(LoginStatus.cancelled),
            test: (e) => e is GoogleSignInException)
        .catchError((err) =>
            LoginResponse(LoginStatus.failed, errorMessage: err.cause));
  }

  Future<LoginResponse> getRelations() async {
    if (_user != null) {
      try {
        _relations = (await _authenticationApi.getRelations(_user!));
        return LoginResponse(LoginStatus.succeed);
      } on GetUserFriendsException catch (e) {
        return LoginResponse(LoginStatus.failed, errorMessage: e.cause);
      }
    }
    return LoginResponse(LoginStatus.failed, errorMessage: 'Not authenticated');
  }

  /// Create an authentication provider, and
  AuthenticationProvider(
      {bool fakeAuthentication = false,
      bool fakeMessage = true,
      bool emulator = false}) {
    _fakeAuthenticationApi = fakeAuthentication;
    _fakeMessageApi = fakeMessage;
    // Emulator overcome fake api
    if (emulator) {
      // https://firebase.google.com/docs/emulator-suite
      // Warning: change local IP accordingly i.e. `ip a`
      FirebaseAuth.instance.useEmulator('http://192.168.0.24:9099');
      FirebaseFunctions.instance
          .useFunctionsEmulator(origin: 'http://192.168.0.24:5001');
      _authenticationApi = ImplAuthenticationApi();
      _messageApi = ImplMessageApi(_add);
      return;
    }
    _authenticationApi = _fakeAuthenticationApi
        ? FakeAuthenticationApi()
        : ImplAuthenticationApi();
    _messageApi = _fakeMessageApi ? FakeMessageApi(_add) : ImplMessageApi(_add);
  }
}
