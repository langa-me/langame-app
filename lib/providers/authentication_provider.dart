import 'dart:async';
import 'dart:collection';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:langame/api/api.pb.dart';
import 'package:langame/models/errors.dart';
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
  /// Defines whether it's fake API or real
  bool _fakeAuthenticationApi = true;
  late AuthenticationApi _authenticationApi;
  LangameUser? _user;

  LangameUser? get user {
    return _user;
  }

  List<Relation> _relations = <Relation>[];

  /// Known people = friends, only this use relations
  List<Relation> get relations {
    return _relations;
  }

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

  Future<LoginResponse> _loginWith(Future<LangameUser?> Function() fn) async {
    try {
      _user = await fn();
    } on GetUserException catch (e) {
      return LoginResponse(LoginStatus.failed, errorMessage: e.cause);
    }
    if (_user == null) return LoginResponse(LoginStatus.cancelled);
    // Once authenticated, get friends
    var getFriendsResponse = await getFriends();
    // If it failed, return
    if (getFriendsResponse.status != LoginStatus.succeed)
      return getFriendsResponse;
    // Otherwise update UI and return succeed
    notifyListeners();
    return LoginResponse(LoginStatus.succeed);
  }

  Future<LoginResponse> loginWithFacebook() async {
    return _loginWith(_authenticationApi.loginWithFacebook);
  }

  Future<LoginResponse> loginWithGoogle() async {
    return _loginWith(_authenticationApi.loginWithGoogle);
  }

  Future<LoginResponse> loginWithApple() async {
    return _loginWith(_authenticationApi.loginWithApple);
  }

  Future<LoginResponse> getFriends() async {
    if (_user != null) {
      try {
        _relations = (await _authenticationApi.getFriends(_user!.uid));
        return LoginResponse(LoginStatus.succeed);
      } on GetUserFriendsException catch (e) {
        return LoginResponse(LoginStatus.failed, errorMessage: e.cause);
      }
    }
    return LoginResponse(LoginStatus.failed, errorMessage: 'Not authenticated');
  }

  /// Create an authentication provider, and
  AuthenticationProvider(
      {bool fakeAuthentication = true,
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
