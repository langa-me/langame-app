import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/channel.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/firebase_functions_protocol.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/services/http/firebase.dart';

import 'authentication_api.dart';

class ImplAuthenticationApi extends AuthenticationApi {
  GoogleSignInAccount? _google;

  // FacebookUser? _facebook;
  // AppleUser? _apple;
  late Stream<User?> _authStateChanges;

  @override
  Stream<User?> get userChanges => _authStateChanges;

  ImplAuthenticationApi(FirebaseApi firebase) : super(firebase) {
    _authStateChanges = firebase.auth!.userChanges();
  }

  @override
  Future<OAuthCredential> loginWithApple() async {
    throw UnimplementedError('nop');
  }

  @override
  Future<OAuthCredential> loginWithFacebook() async {
    // TODO: https://developers.facebook.com/docs/permissions/reference/user_friends
    throw UnimplementedError('nop');
  }

  @override
  Future<OAuthCredential> loginWithGoogle() async {
    // await googleSignIn.signOut();
    // await firebaseAuth.signOut();
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
  }

  @override
  Future<void> loginWithFirebase(OAuthCredential credential) async {
    try {
      await firebase.auth!.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw LangameFirebaseSignInException(
          cause: 'failed to signInWithCredential ${e.code}');
    } catch (e) {
      throw LangameFirebaseSignInException(
          cause: 'failed to signInWithCredential ${e.toString()}');
    }
  }

  /// Query Firestore with [uid] looking for a LangameUser
  /// Throw GetUserException if it does not exist
  /// TODO: might use a transaction?
  Future<lg.User?> getLangameUser(String uid) async {
    CollectionReference users =
        firebase.firestore!.collection(AppConst.firestoreUsersCollection);
    DocumentSnapshot doc = await users.doc(uid).get();
    if (!doc.exists) return null;
    var data = doc.data();
    if (data == null) return null;
    var u = userFromMap(data);
    firebase.crashlytics?.setUserIdentifier(u.uid);
    firebase.analytics?.setUserId(u.uid);
    return u;
  }

  Future<lg.User> addLangameUser(User user) async {
    CollectionReference users =
        firebase.firestore!.collection(AppConst.firestoreUsersCollection);
    lg.User langameUser = userFromFirebase(user);
    var t = await _generateTag(user);
    if (user.providerData.any((e) => e.providerId == 'google.com')) {
      langameUser.google = true;
    }
    langameUser.tag = t.toLowerCase();

    return users
        .doc(langameUser.uid)
        .set(langameUser.toProto3Json() as Map<String, dynamic>)
        .then((value) => langameUser)
        .catchError((err) => throw LangameAddUserException(err.toString()));
  }

  @override
  Future<List<lg.User>> getLangameUsersStartingWithTag(String tag) async {
    CollectionReference users =
        firebase.firestore!.collection(AppConst.firestoreUsersCollection);

    tag = tag.toLowerCase();

    /// Query users with tag starting with [tag]
    QuerySnapshot doc = await users
        .where('tag', isGreaterThanOrEqualTo: tag)
        .where('tag', isLessThan: tag + 'z')
        .get(); // TODO: ignore case
    return doc.docs.map((e) => lg.User.fromJson(e.data().toString())).toList();
  }

  @override
  Future<void> logout() async {
    if (_google != null) await firebase.googleSignIn!.signOut();
    await firebase.auth!.signOut();
    // TODO: Facebook, Apple
  }

  @override
  Future<void> updateProfile(
      // TODO: use firebase rules instead of functions?
      {String? displayName,
      String? photoURL,
      String? newEmail,
      String? tag,
      List<String>? topics}) async {
    if (firebase.auth!.currentUser == null)
      throw LangameUpdateProfileException(cause: kNotAuthenticated);
    await firebase.auth!.currentUser!
        .updateProfile(displayName: displayName, photoURL: photoURL);
    if (newEmail != null)
      await firebase.auth!.currentUser!.updateEmail(newEmail);
    HttpsCallable callable = firebase.functions!.httpsCallable(
        AppConst.updateProfileFunction,
        options: HttpsCallableOptions(timeout: Duration(seconds: 10)));

    try {
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{
          'displayName': displayName,
          'photoUrl': photoURL,
          'email': newEmail,
          'tag': tag,
          'topics': topics,
        },
      );
      FirebaseFunctionsResponse response = FirebaseFunctionsResponse.fromJson(
          Map<String, dynamic>.from(result.data));
      switch (response.statusCode) {
        case FirebaseFunctionsResponseStatusCode.OK:
          break;
        case FirebaseFunctionsResponseStatusCode.BAD_REQUEST:
          LangameUpdateProfileException(
              cause: response.errorMessage ??
                  FirebaseFunctionsResponseStatusCode.BAD_REQUEST.toString());
          break;
        case FirebaseFunctionsResponseStatusCode.UNAUTHORIZED:
          LangameUpdateProfileException(
              cause: response.errorMessage ??
                  FirebaseFunctionsResponseStatusCode.UNAUTHORIZED.toString());
          break;
        case FirebaseFunctionsResponseStatusCode.INTERNAL:
          LangameUpdateProfileException(
              cause: response.errorMessage ??
                  FirebaseFunctionsResponseStatusCode.INTERNAL.toString());
          break;
      }
      // return response.result;
    } catch (e) {
      throw LangameUpdateProfileException(cause: e.toString());
    }
    // TODO: phone
    // firebase.auth.verifyPhoneNumber(phoneNumber: phoneNumber,
    //     verificationCompleted: verificationCompleted,
    //     verificationFailed: verificationFailed,
    //     codeSent: codeSent,
    //     codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
    // firebase.auth.currentUser.updatePhoneNumber()
  }

  Future<String> _generateTag(User user) async {
    if (user.displayName == null)
      throw LangameAuthException('The user has no displayName');
    String tag = user.displayName!;
    int tries = 0;
    int maxTries = 5;
    while ((await getLangameUsersStartingWithTag(tag)).isNotEmpty) {
      var r = await post(
        Uri.parse('https://uzby.com/api.php'),
        body: 'min=4&max=6',
        encoding: Encoding.getByName('utf-8'),
        headers: {
          'content-type': 'application/x-www-form-urlencoded; charset=UTF-8'
        },
      );
      if (r.statusCode != 200)
        throw LangameAuthException(
            'Could not generate a tag for ${user.displayName}, ${r.statusCode}:${r.body}');
      if (r.body == '') continue;
      tag = '${user.displayName!}-${r.body}';
      tries++;
      if (tries > maxTries)
        throw LangameAuthException(
            'Could not generate a tag for ${user.displayName}');
    }
    return tag;
  }

  @override
  Future<String> getChannelToken(String channelName) async {
    HttpsCallable callable = firebase.functions!.httpsCallable(
        AppConst.getChannelTokenFunction,
        options: HttpsCallableOptions(timeout: Duration(seconds: 10)));

    try {
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{
          'channelName': channelName,
        },
      );
      FirebaseFunctionsResponse response = FirebaseFunctionsResponse.fromJson(
        Map<String, dynamic>.from(result.data),
      );
      switch (response.statusCode) {
        case FirebaseFunctionsResponseStatusCode.OK:
          return response.result!['channelToken'];
        case FirebaseFunctionsResponseStatusCode.BAD_REQUEST:
          throw LangameGetAudioTokenException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.BAD_REQUEST.toString());
        case FirebaseFunctionsResponseStatusCode.UNAUTHORIZED:
          throw LangameGetAudioTokenException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.UNAUTHORIZED.toString());
        case FirebaseFunctionsResponseStatusCode.INTERNAL:
          throw LangameGetAudioTokenException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.INTERNAL.toString());
      }
    } catch (e) {
      throw LangameGetAudioTokenException(e.toString());
    }
  }

  @override
  Future<LangameChannel> getChannel(String channelName) async {
    var r = await firebase.firestore!
        .collection(AppConst.firestoreLangamesCollection)
        .where('channelName', isEqualTo: channelName)
        .get();

    Map<String, dynamic> first = r.docs.first.data();
    return LangameChannel.fromJson(first);
  }

  @override
  Future<List<lg.User>> getUserRecommendations(lg.User user) async {
    // TODO: now reco is random
    var r = await firebase.firestore!
        .collection(AppConst.firestoreUsersCollection)
        .where('uid', isNotEqualTo: user.uid)
        .limit(5)
        .get();

    return r.docs.map((e) => userFromMap(e.data())).toList();
  }

  @override
  Future<void> sendLangameEnd(String channelName) async {
    HttpsCallable callable = firebase.functions!.httpsCallable(
        AppConst.sendLangameEndFunction,
        options: HttpsCallableOptions(timeout: Duration(seconds: 10)));

    try {
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{
          'channelName': channelName,
        },
      );
      FirebaseFunctionsResponse response = FirebaseFunctionsResponse.fromJson(
        Map<String, dynamic>.from(result.data),
      );
      switch (response.statusCode) {
        case FirebaseFunctionsResponseStatusCode.OK:
          break;
        case FirebaseFunctionsResponseStatusCode.BAD_REQUEST:
          throw LangameSendEndException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.BAD_REQUEST.toString());
        case FirebaseFunctionsResponseStatusCode.UNAUTHORIZED:
          throw LangameSendEndException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.UNAUTHORIZED.toString());
        case FirebaseFunctionsResponseStatusCode.INTERNAL:
          throw LangameSendEndException(response.errorMessage ??
              FirebaseFunctionsResponseStatusCode.INTERNAL.toString());
      }
    } catch (e) {
      throw LangameSendEndException(e.toString());
    }
  }

  @override
  Future<int?> getInteraction(String uid, String otherUid) async {
    var r = await firebase.firestore!
        .collection(AppConst.firestoreInteractionsCollection)
        .where('$uid,$otherUid', isEqualTo: 1)
        .get();
    if (!r.docs.any((e) => e.exists)) {
      r = await firebase.firestore!
          .collection(AppConst.firestoreInteractionsCollection)
          .where('$otherUid,$uid', isEqualTo: 1)
          .get();
    }
    // No interactions found
    if (!r.docs.any((e) => e.exists)) return null;
    var i = r.docs.first.data()['interactions'];
    if (i == null || !(i is int))
      throw LangameException('interactions_invalid_fields');
    return i;
  }
}
