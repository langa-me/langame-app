import 'package:cloud_firestore/cloud_firestore.dart';
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

  /// Login with Apple, return Apple account and credentials
  Future<OAuthCredential> loginWithApple();

  Future<UserCredential> loginWithHack(String password);

  /// Login with firebase with previously acquired credential
  Future<UserCredential> loginWithFirebase(OAuthCredential credential);

  /// Login with firebase with previously acquired credential
  Future<void> logout();

  /// Delete user
  Future<void> delete();

  /// Get [LangameUser] from Firestore using Firebase uid
  Stream<DocumentSnapshot<lg.User>> getLangameUser(String uid);

  /// Get [LangameUser] from Firestore using Langame [tag]
  Future<List<lg.User>> getLangameUsersStartingWithTag(
      String ignoreTag, String tag,
      {int limit = 5});

  /// Update current authenticated user, at the firebase level
  /// and firestore [LangameUser], throw if not authenticated
  Future<void> updateProfile({
    String? displayName,
    String? photoURL,
    String? newEmail,
    String? newPhoneNumber,
    String? tag,
    List<String>? topics,
    bool google = false,
    bool apple = false,
  });

  Future<List<lg.User>> getUserRecommendations(lg.User user);

  Future<int?> getInteraction(String uid, String otherUid);

  Future<List<Tuple2<String, int>>> getInteractions(String uid,
      {int limit = 5});

  Future<void> reAuthenticate(OAuthCredential credential);
}
