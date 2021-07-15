import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/helpers/string.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/services/http/firebase.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:tuple/tuple.dart';

import 'authentication_api.dart';

class ImplAuthenticationApi extends AuthenticationApi {
  GoogleSignInAccount? _google;
  AuthorizationCredentialAppleID? _apple;

  late Stream<User?> _authStateChanges;

  @override
  Stream<User?> get userChanges => _authStateChanges;

  ImplAuthenticationApi(FirebaseApi firebase) : super(firebase) {
    _authStateChanges = firebase.auth!.userChanges();
  }

  @override
  Future<OAuthCredential> loginWithApple() async {
    try {
      // To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of `rawNonce`.
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account.
      _apple = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      // Create an `OAuthCredential` from the credential returned by Apple.
      return OAuthProvider('apple.com').credential(
        idToken: _apple!.identityToken,
        rawNonce: rawNonce,
      );
    } catch (e) {
      throw LangameAppleSignInException(
          'authentication failed ${e.toString()}');
    }
  }

  @override
  Future<OAuthCredential> loginWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser =
          await firebase.googleSignIn!.signIn();

      // If Google Auth cancelled
      if (googleUser == null)
        throw LangameGoogleSignInException(
            'authentication likely have been cancelled');

      _google = googleUser;

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      return GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
    } catch (e) {
      throw LangameGoogleSignInException(
          'authentication failed ${e.toString()}');
    }
  }

  @override
  Future<UserCredential> loginWithFirebase(OAuthCredential credential) {
    try {
      return firebase.auth!.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw LangameFirebaseSignInException(
          cause: 'failed to signInWithCredential ${e.code}');
    } catch (e) {
      throw LangameFirebaseSignInException(
          cause: 'failed to signInWithCredential ${e.toString()}');
    }
  }

  @override
  Future<UserCredential> loginWithHack(String password) async {
    return firebase.auth!
        .signInWithEmailAndPassword(email: 'hack@langa.me', password: password);
  }

  /// Query Firestore with [uid] looking for a LangameUser
  /// Throw GetUserException if it does not exist
  /// TODO: might use a transaction?
  @override
  Stream<DocumentSnapshot<lg.User>> getLangameUser(String uid) {
    CollectionReference users =
        firebase.firestore!.collection(AppConst.firestoreUsersCollection);
    return users
        .doc(uid)
        .withConverter<lg.User>(
          fromFirestore: (snapshot, _) => UserExt.fromObject(snapshot.data()!),
          toFirestore: (user, _) => user.toMapStringDynamic(),
        )
        .snapshots();
  }

  @override
  Future<List<lg.User>> getLangameUsersStartingWithTag(
      String ignoreTag, String tag,
      {int limit = 5}) async {
    CollectionReference users =
        firebase.firestore!.collection(AppConst.firestoreUsersCollection);

    tag = tag.toLowerCase();

    // https://medium.com/@ken11zer01/firebase-firestore-text-search-and-pagination-91a0df8131ef
    /// Query users with tag starting with [tag]
    var doc = await users
        .where('tag', isNotEqualTo: ignoreTag)
        .where('tag', isGreaterThanOrEqualTo: tag)
        .where('tag', isLessThan: tag + 'z')
        .limit(limit)
        .withConverter<lg.User>(
          fromFirestore: (s, _) => UserExt.fromObject(s.data()!),
          toFirestore: (s, _) => s.toMapStringDynamic(),
        )
        .get();
    return doc.docs.map((e) => e.data()).toList();
  }

  @override
  Future<void> logout() async {
    if (_google != null) await firebase.googleSignIn!.signOut();
    // if (_apple != null) await SignInWithApple.
    await firebase.auth!.signOut();
    // TODO: Apple
  }

  @override
  Future<List<lg.User>> getUserRecommendations(lg.User user) async {
    // TODO: now reco is random
    var r = await firebase.firestore!
        .collection(AppConst.firestoreUsersCollection)
        .where('uid', isNotEqualTo: user.uid)
        .limit(5)
        .withConverter<lg.User>(
          fromFirestore: (snapshot, _) => UserExt.fromObject(snapshot.data()!),
          toFirestore: (user, _) => user.toMapStringDynamic(),
        )
        .get();

    return r.docs.map((e) => e.data()).toList();
  }

  @override
  Future<int?> getInteraction(String uid, String otherUid) async {
    var r = await firebase.firestore!
        .collection(AppConst.firestoreInteractionsCollection)
        .where('users', isEqualTo: '$uid,$otherUid')
        .get();
    if (!r.docs.any((e) => e.exists)) {
      r = await firebase.firestore!
          .collection(AppConst.firestoreInteractionsCollection)
          .where('users', isEqualTo: '$otherUid,$uid')
          .get();
    }
    // No interactions found
    if (!r.docs.any((e) => e.exists)) return null;
    var i = r.docs.first.data()['interactions'];
    if (i == null || !(i is int))
      throw LangameException('interactions_invalid_fields');
    return i;
  }

  @override
  Future<List<Tuple2<String, int>>> getInteractions(String uid,
      {int limit = 5}) async {
    var r = await firebase.firestore!
        .collection(AppConst.firestoreInteractionsCollection)
        .where('usersArray', arrayContains: uid)
        .limit(limit) // TODO: snapshots()
        .get();

    return r.docs
        .where((e) => e.exists && e.data()['interactions'] != null)
        .map((e) => Tuple2(
            (e.data()['usersArray'] as List).firstWhere((u) => u != uid)
                as String,
            e.data()['interactions'] as int))
        .toList();
  }

  @override
  Future<void> delete() => firebase.auth!.currentUser!.delete();

  @override
  Future<void> reAuthenticate(OAuthCredential credential) =>
      firebase.auth!.currentUser!.reauthenticateWithCredential(credential);
}
