import 'package:firebase_auth/firebase_auth.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:tuple/tuple.dart';

import 'firebase.dart';

abstract class AuthenticationApi {
  final FirebaseApi firebase;
  Stream<User?> get userChanges;

  AuthenticationApi(
    this.firebase,
  );

  /// Login with Google, return Google account and credentials
  Future<OAuthCredential> loginWithGoogle();

  /// Login with Facebook, return Facebook account and credentials
  Future<OAuthCredential> loginWithFacebook();

  /// Login with Apple, return Apple account and credentials
  Future<OAuthCredential> loginWithApple();

  /// Login with firebase with previously acquired credential
  Future<void> loginWithFirebase(OAuthCredential credential);

  /// Login with firebase with previously acquired credential
  Future<void> logout();

  /// Delete user
  Future<void> delete();

  /// Get [LangameUser] from Firestore using Firebase uid
  Future<lg.User?> getLangameUser(String uid);

  /// Get [LangameUser] from Firestore using Langame [tag]
  Future<List<lg.User>> getLangameUsersStartingWithTag(
      String ignoreTag, String tag,
      {int limit = 5});

  /// Add [LangameUser] to Firestore using Firebase [User]
  Future<lg.User> addLangameUser(User user);

  /// Update current authenticated user, at the firebase level
  /// and firestore [LangameUser], throw if not authenticated
  Future<void> updateProfile(
      {String? displayName,
      String? photoURL,
      String? newEmail,
      String? tag,
      List<String>? topics});

  Future<String> getChannelToken(String channelName);
  Future<lg.Langame> getChannel(String channelName);
  Future<List<lg.User>> getUserRecommendations(lg.User user);
  Future<void> sendLangameEnd(String channelName);
  Future<int?> getInteraction(String uid, String otherUid);
  Future<List<Tuple2<String, int>>> getInteractions(String uid,
      {int limit = 5});
}
