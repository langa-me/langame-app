import 'package:firebase_auth/firebase_auth.dart';
import 'package:langame/models/user.dart';

abstract class AuthenticationApi {
  /// Login with Google, return Google account and credentials
  Future<OAuthCredential> loginWithGoogle();

  /// Login with Facebook, return Facebook account and credentials
  Future<OAuthCredential> loginWithFacebook();

  /// Login with Apple, return Apple account and credentials
  Future<OAuthCredential> loginWithApple();

  /// Login with firebase with previously acquired credential
  Future<Stream<User?>> loginWithFirebase(OAuthCredential credential);

  /// Get [LangameUser] from Firestore using Firebase uid
  Future<LangameUser?> getLangameUser(String uid);

  /// Add [LangameUser] to Firestore using Firebase [User]
  Future<LangameUser> addLangameUser(User user);

  /// Find all relations from Google, Facebook, Apple (if connected)
  /// update databases (yes, client-side, easier for now)
  Future<LangameUserRelations> getRelations(LangameUser user);
}
