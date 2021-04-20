import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:langame/helpers/fake.dart';
import 'package:langame/helpers/random.dart';
import 'package:langame/models/channel.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/services/http/authentication_api.dart';

import 'firebase.dart';

/// FakeAuthenticationApi returns fake auth data with 50% chance of returning a null value (fail)
class FakeAuthenticationApi extends AuthenticationApi {
  FakeAuthenticationApi(FirebaseApi firebase) : super(firebase) {
    Timer.periodic(Duration(seconds: 5), (timer) {
      _userChanges.add(_user);
    });
  }
  late StreamController<MockUser?> _userChanges = StreamController.broadcast();
  MockUser _user = getMockUser();
  @override
  Stream<User?> get userChanges => _userChanges.stream.asBroadcastStream();

  @override
  Future<lg.User> addLangameUser(User user) async {
    return faang.pickAny()!;
  }

  @override
  Future<lg.User?> getLangameUser(String uid) async {
    return faang.pickAny();
  }

  @override
  Future<List<lg.User>> getLangameUsersStartingWithTag(String tag) async {
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

  @override
  Future<void> updateProfile(
      {String? displayName,
      String? photoURL,
      String? newEmail,
      String? tag,
      List<String>? topics}) async {
    _user =
        MockUser(displayName: displayName, photoURL: photoURL, email: newEmail);
  }

  @override
  Future<LangameChannel> getChannel(String channelName) {
    // TODO: implement getChannel
    throw UnimplementedError();
  }

  @override
  Future<String> getChannelToken(String channelName) {
    // TODO: implement getChannelToken
    throw UnimplementedError();
  }

  @override
  Future<List<lg.User>> getUserRecommendations(lg.User user) {
    // TODO: implement getUserRecommendations
    throw UnimplementedError();
  }

  @override
  Future<void> sendLangameEnd(String channelName) {
    // TODO: implement sendLangameEnd
    throw UnimplementedError();
  }

  @override
  Future<int?> getInteraction(String uid, String otherUid) {
    // TODO: implement getInteraction
    throw UnimplementedError();
  }
}
