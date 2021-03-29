import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:langame/helpers/fake.dart';
import 'package:langame/helpers/random.dart';
import 'package:langame/models/user.dart';
import 'package:langame/services/http/authentication_api.dart';

import 'firebase.dart';

/// FakeAuthenticationApi returns fake auth data with 50% chance of returning a null value (fail)
class FakeAuthenticationApi extends AuthenticationApi {
  FakeAuthenticationApi(FirebaseApi firebase) : super(firebase) {
    Timer.periodic(Duration(seconds: 5), (timer) {
      _authStateChanges.add(getMockUser());
    });
  }
  late StreamController<MockUser?> _authStateChanges =
      StreamController.broadcast();
  @override
  Stream<User?> get authStateChanges =>
      _authStateChanges.stream.asBroadcastStream();

  @override
  Future<LangameUser> addLangameUser(User user) async {
    return faang.pickAny()!;
  }

  @override
  Future<LangameUser?> getLangameUser(String uid) async {
    return faang.pickAny();
  }

  @override
  Future<List<LangameUser>> getLangameUsersStartingWithTag(String tag) async {
    return faang.where((e) => e.uid!.startsWith(tag)).toList();
  }

  @override
  Future<LangameUserRelations> getRelations(LangameUser user) {
    // TODO: implement getRelations
    throw UnimplementedError();
  }

  @override
  Future<OAuthCredential> loginWithApple() {
    // TODO: implement loginWithApple
    throw UnimplementedError();
  }

  @override
  Future<OAuthCredential> loginWithFacebook() {
    // TODO: implement loginWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<void> loginWithFirebase(OAuthCredential credential) async {}

  @override
  Future<OAuthCredential> loginWithGoogle() async {
    return OAuthCredential(
        providerId: 'providerId', signInMethod: 'signInMethod');
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
