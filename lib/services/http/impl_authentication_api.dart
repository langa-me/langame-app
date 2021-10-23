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
import 'package:universal_platform/universal_platform.dart';

import 'authentication_api.dart';

class ImplAuthenticationApi extends AuthenticationApi {
  GoogleSignInAccount? _google;
  AuthorizationCredentialAppleID? _apple;
  String? _email;
  String? _password;

  late Stream<User?> _authStateChanges;

  @override
  Stream<User?> get userChanges => _authStateChanges;

  ImplAuthenticationApi(FirebaseApi firebase) : super(firebase) {
    _authStateChanges = firebase.auth!.userChanges();
  }

  @override
  Future<Credential> loginWithApple() async {
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
      return Credential(
          OAuthProvider('apple.com').credential(
            idToken: _apple!.identityToken,
            rawNonce: rawNonce,
          ),
          null);
    } catch (e) {
      throw LangameAppleSignInException(
          'authentication failed ${e.toString()}');
    }
  }

  @override
  Future<Credential> loginWithGoogle() async {
    try {
      if (UniversalPlatform.isWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

        await firebase.auth!.signInWithRedirect(googleProvider);
        // Once signed in, return the UserCredential
        return Credential(
          null,
          await firebase.auth!.getRedirectResult(),
        );
      }
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
      return Credential(
          GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          ),
          null);
    } catch (e) {
      throw LangameGoogleSignInException(
          'authentication failed ${e.toString()}');
    }
  }

  @override
  Future<Credential> loginWithEmail(
    String? email,
    String? password,
  ) async {
    return Credential(
        null,
        await firebase.auth!
            .signInWithEmailAndPassword(
                email: email != null
                    ? email
                    : _email != null
                        ? _email!
                        : '',
                password: password != null
                    ? password
                    : _password != null
                        ? _password!
                        : '')
            .then((value) {
          if (value.user != null) {
            _password = password;
            _email = email;
          }
          return value;
        }));
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
  Future<void> logout() async {
    if (_google != null) await firebase.googleSignIn!.signOut();
    // if (_apple != null) await SignInWithApple.
    await firebase.auth!.signOut();
    _google = null;
    _apple = null;
    _email = null;
    _password = null;
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
      
}
