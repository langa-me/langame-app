import 'dart:math';

import 'package:langame/protos/api.pb.dart';
import 'package:langame/services/http/authentication_api.dart';

/// FakeAuthenticationApi returns fake auth data with 50% chance of returning a null value (fail)
class FakeAuthenticationApi implements AuthenticationApi {
  @override
  Future<LangameUser> loginWithApple() {
    return Future<LangameUser>.value(Random().nextDouble() > 0.5
        ? LangameUser(displayName: 'SteveJobs')
        : null);
  }

  @override
  Future<LangameUser> loginWithFacebook() {
    return Future<LangameUser>.value(Random().nextDouble() > 0.5
        ? LangameUser(displayName: 'MarkZuckerberg')
        : null);
  }

  @override
  Future<LangameUser> loginWithGoogle() {
    return Future<LangameUser>.value(Random().nextDouble() > 0.5
        ? LangameUser(displayName: 'LarryPage')
        : null);
  }
}
