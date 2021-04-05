import 'package:firebase_auth/firebase_auth.dart';
import 'package:langame/models/user.dart';

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

  /// Get [LangameUser] from Firestore using Firebase uid
  Future<LangameUser?> getLangameUser(String uid);

  /// Get [LangameUser] from Firestore using Langame [tag]
  Future<List<LangameUser>> getLangameUsersStartingWithTag(String tag);

  /// Add [LangameUser] to Firestore using Firebase [User]
  Future<LangameUser> addLangameUser(User user);

  /// Find all relations from Google, Facebook, Apple (if connected)
  /// update databases (yes, client-side, easier for now)
  Future<LangameUserRelations> getRelations(LangameUser user);

  /// Update current authenticated user, at the firebase level
  /// and firestore [LangameUser], throw if not authenticated
  Future<void> updateProfile(
      {String? displayName,
      String? photoURL,
      String? newEmail,
      String? tag,
      List<String>? topics});
}
