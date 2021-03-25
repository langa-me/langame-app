import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:langame/models/user.dart';

abstract class AuthenticationApi {
  final FirebaseAuth firebaseAuth;
  final FirebaseFunctions firebaseFunctions;
  final FirebaseFirestore firebaseFirestore;
  final GoogleSignIn googleSignIn;

  AuthenticationApi(
    this.firebaseAuth,
    this.firebaseFunctions,
    this.firebaseFirestore,
    this.googleSignIn,
  );

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

  /// Get [LangameUser] from Firestore using Langame [tag]
  Future<List<LangameUser>> getLangameUsersStartingWithTag(String tag);

  /// Add [LangameUser] to Firestore using Firebase [User]
  Future<LangameUser> addLangameUser(User user);

  /// Find all relations from Google, Facebook, Apple (if connected)
  /// update databases (yes, client-side, easier for now)
  Future<LangameUserRelations> getRelations(LangameUser user);
}
