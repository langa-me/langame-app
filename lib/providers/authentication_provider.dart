import 'package:flutter/material.dart';
import 'package:langame/protos/api.pb.dart';
import 'package:langame/services/http/authentication_api.dart';
import 'package:langame/services/http/fake_authentication_api.dart';
import 'package:langame/services/http/impl_authentication_api.dart';

class AuthenticationProvider extends ChangeNotifier {
  /// Defines whether it's fake API or real
  bool _fake = true;
  AuthenticationApi _api;
  LangameUser _user;
  LangameUser get user {
    return _user;
  }

  // TODO: better errors than boolean
  Future<bool> loginWithFacebook() async {
    _user = await _api.loginWithFacebook();
    if (_user == null) return false;
    notifyListeners();
    return true;
  }

  Future<bool> loginWithGoogle() async {
    _user = await _api.loginWithGoogle();
    if (_user == null) return false;
    notifyListeners();
    return true;
  }

  Future<bool> loginWithApple() async {
    _user = await _api.loginWithApple();
    if (_user == null) return false;
    notifyListeners();
    return true;
  }

  AuthenticationProvider({bool fake = true}) {
    _fake = fake;
    _api = _fake ? FakeAuthenticationApi() : ImplAuthenticationApi();
  }
}
