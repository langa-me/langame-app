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

  // FacebookUser? _facebook;
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
  Future<OAuthCredential> loginWithFacebook() async {
    // TODO: https://developers.facebook.com/docs/permissions/reference/user_friends
    throw UnimplementedError('nop');
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
          fromFirestore: (snapshot, _) => UserExt.fromObject(snapshot.data()!),
          toFirestore: (user, _) => user.toMapStringDynamic(),
        )
        .get();
    return doc.docs.map((e) => e.data()).toList();
  }

  @override
  Future<void> logout() async {
    if (_google != null) await firebase.googleSignIn!.signOut();
    // if (_apple != null) await SignInWithApple.
    await firebase.auth!.signOut();
    // TODO: Facebook, Apple
  }

  @override
  Future<void> updateProfile({
    String? displayName,
    String? photoURL,
    String? newEmail,
    String? newPhoneNumber,
    String? tag,
    List<String>? topics,
    bool google = false,
    bool apple = false,
  }) async {
    Map<String, dynamic> data = {};
    if (displayName != null) data['displayName'] = displayName;
    if (photoURL != null) data['photoUrl'] = photoURL;
    if (newEmail != null)
      throw LangameUpdateProfileException(cause: 'email_not_implemented');
    if (newPhoneNumber != null)
      throw LangameUpdateProfileException(
          cause: 'phone_number_not_implemented');
    if (tag != null) data['tag'] = tag;
    if (topics != null) data['favouriteTopics'] = topics;
    if (google) data['google'] = google;
    if (apple) data['apple'] = apple;

    if (firebase.auth!.currentUser == null)
      throw LangameUpdateProfileException(cause: kNotAuthenticated);
    // If the user want to change tag and someone already has this tag, fail
    if (tag != null &&
        (await getLangameUsersStartingWithTag('', tag)).any(
            (e) => firebase.auth!.currentUser!.uid != e.uid && e.tag == tag))
      throw LangameUpdateProfileException(cause: 'tag_already_existing');

    data['uid'] = firebase.auth!.currentUser!.uid;
    var f = firebase.firestore!
        .collection(AppConst.firestoreUsersCollection)
        .doc(firebase.auth!.currentUser!.uid)
        .update(data);

    return f.then((_) async {
      await firebase.auth!.currentUser!
          .updateProfile(displayName: displayName, photoURL: photoURL);
      if (newEmail != null)
        await firebase.auth!.currentUser!.updateEmail(newEmail);

      // TODO: phone
      // firebase.auth.verifyPhoneNumber(phoneNumber: phoneNumber,
      //     verificationCompleted: verificationCompleted,
      //     verificationFailed: verificationFailed,
      //     codeSent: codeSent,
      //     codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
      // firebase.auth.currentUser.updatePhoneNumber()
    });
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
