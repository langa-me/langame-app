import 'dart:math';

import 'package:langame/protos/api.pb.dart';
import 'package:langame/services/http/authentication_api.dart';

/// FakeAuthenticationApi returns fake auth data with 50% chance of returning a null value (fail)
class FakeAuthenticationApi implements AuthenticationApi {
  @override
  Future<LangameUser> loginWithApple() {
    return Future<LangameUser>.value(Random().nextDouble() > 0.5
        ? LangameUser(
            username: 'SteveJobs', firstName: 'Steve', lastName: 'Jobs')
        : null);
  }

  @override
  Future<LangameUser> loginWithFacebook() {
    return Future<LangameUser>.value(Random().nextDouble() > 0.5
        ? LangameUser(
            username: 'MarkZuckerberg',
            firstName: 'Mark',
            lastName: 'Zuckerberg')
        : null);
  }

  @override
  Future<LangameUser> loginWithGoogle() {
    return Future<LangameUser>.value(Random().nextDouble() > 0.5
        ? LangameUser(
            username: 'LarryPage', firstName: 'Larry', lastName: 'Page')
        : null);
  }
}
