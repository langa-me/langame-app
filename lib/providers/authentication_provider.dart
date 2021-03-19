import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:langame/api/api.pb.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/services/http/authentication_api.dart';
import 'package:langame/services/http/fake_authentication_api.dart';
import 'package:langame/services/http/impl_authentication_api.dart';

class LoginResponse {
  final LoginStatus status;
  final String? errorMessage;

  LoginResponse(this.status, {this.errorMessage});
}

enum LoginStatus { cancelled, failed, succeed }

class AuthenticationProvider extends ChangeNotifier {
  /// Defines whether it's fake API or real
  bool _fake = true;
  late AuthenticationApi _api;
  LangameUser? _user;

  LangameUser? get user {
    return _user;
  }

  List<Friend> _friends = <Friend>[];

  List<Friend> get friends {
    return _friends;
  }

  Future<LoginResponse> _loginWith(Future<LangameUser?> Function() fn) async {
    try {
      _user = await fn();
    } on GetUserException catch (e) {
      return LoginResponse(LoginStatus.failed, errorMessage: e.cause);
    }
    if (_user == null) return LoginResponse(LoginStatus.cancelled);
    _friends = await _api.getFriends(_user!.uid);
    notifyListeners();
    return LoginResponse(LoginStatus.succeed);
  }

  Future<LoginResponse> loginWithFacebook() async {
    return _loginWith(_api.loginWithFacebook);
  }

  Future<LoginResponse> loginWithGoogle() async {
    return _loginWith(_api.loginWithGoogle);
  }

  Future<LoginResponse> loginWithApple() async {
    return _loginWith(_api.loginWithApple);
  }

  Future<bool> getFriends() async {
    if (_user != null) {
      _friends = await _api.getFriends(_user!.uid);
      return true;
    }
    return false;
  }

  /// Create an authentication provider, and
  AuthenticationProvider({bool fake = true, bool emulator = false}) {
    _fake = fake;
    // Emulator overcome fake api
    if (emulator) {
      // https://firebase.google.com/docs/emulator-suite
      // Warning: change local IP accordingly i.e. `ip a`
      FirebaseAuth.instance.useEmulator('http://192.168.0.24:9099');
      FirebaseFunctions.instance
          .useFunctionsEmulator(origin: 'http://192.168.0.24:5001');
      _api = ImplAuthenticationApi();
      return;
    }
    _api = _fake ? FakeAuthenticationApi() : ImplAuthenticationApi();
  }
}
