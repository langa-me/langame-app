import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/protos/api.pb.dart';
import 'package:langame/services/http/authentication_api.dart';
import 'package:langame/services/http/fake_authentication_api.dart';
import 'package:langame/services/http/impl_authentication_api.dart';

enum LoginStatus { cancelled, failed, succeed }

class AuthenticationProvider extends ChangeNotifier {
  /// Defines whether it's fake API or real
  bool _fake = true;
  AuthenticationApi _api;
  LangameUser _user;
  LangameUser get user {
    return _user;
  }

  // TODO: better errors than boolean
  Future<LoginStatus> loginWithFacebook() async {
    try {
      _user = await _api.loginWithFacebook();
    } on GetUserException {
      return LoginStatus.failed;
    }
    if (_user == null) return LoginStatus.cancelled;
    notifyListeners();
    return LoginStatus.succeed;
  }

  Future<LoginStatus> loginWithGoogle() async {
    try {
      _user = await _api.loginWithGoogle();
    } on GetUserException {
      return LoginStatus.failed;
    }
    if (_user == null) return LoginStatus.cancelled;
    notifyListeners();
    return LoginStatus.succeed;
  }

  Future<LoginStatus> loginWithApple() async {
    try {
      _user = await _api.loginWithApple();
    } on GetUserException {
      return LoginStatus.failed;
    }
    if (_user == null) return LoginStatus.cancelled;
    notifyListeners();
    return LoginStatus.succeed;
  }

  /// Create an authentication provider, and
  AuthenticationProvider({bool fake = true, bool emulator = true}) {
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
