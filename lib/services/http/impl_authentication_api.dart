import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/firebase_functions_protocol.dart';
import 'package:langame/models/relation.dart';
import 'package:langame/models/user.dart';
import 'package:langame/services/http/firebase.dart';

import 'authentication_api.dart';

// TODO: ABSOLUTELY TEST
class ImplAuthenticationApi extends AuthenticationApi {
  GoogleSignInAccount? _google;

  // FacebookUser? _facebook;
  // AppleUser? _apple;
  late Stream<User?> _authStateChanges;

  @override
  Stream<User?> get userChanges => _authStateChanges;

  String kFirestoreUsersCollection = 'users';

  ImplAuthenticationApi(FirebaseApi firebase) : super(firebase) {
    _authStateChanges = firebase.auth.userChanges();
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
        await firebase.googleSignIn.signIn();

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
      await firebase.auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw LangameFirebaseSignInException(
          cause: 'failed to signInWithCredential ${e.code}');
    } catch (e) {
      throw LangameFirebaseSignInException(
          cause: 'failed to signInWithCredential ${e.toString()}');
    }
  }

  @override
  Future<LangameUserRelations> getRelations(LangameUser user) async {
    // TODO: for now it get EXTERNAL relations, need to merge with langame relations? (i.e. firestore)
    // var appleRelations =
    //     _apple != null ? await _getAppleRelations(_apple!) : <Relation>[];
    // var facebookRelations = _facebook != null
    //     ? await _getFacebookRelations(_facebook!)
    //     : <Relation>[];
    // TODO: merge somehow the three
    var googleRelations =
        _google != null ? await _getGoogleRelations(_google!) : <Relation>[];
    return LangameUserRelations(user, googleRelations);
  }

  // /// Retrieve EXTERNAL contacts from Apple API
  // Future<List<Relation>> _getAppleRelations(AppleUser user) async {
  //   throw UnimplementedError();
  // }
  // /// Retrieve EXTERNAL contacts from Facebook API
  // Future<List<Relation>> _getFacebookRelations(FacebookUser user) async {
  //   throw UnimplementedError();
  // }

  /// Retrieve EXTERNAL contacts from Google People API
  Future<List<Relation>> _getGoogleRelations(GoogleSignInAccount user) async {
    var result = <Relation>[];
    Response response;
    response = await get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names,person.emailAddresses'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      print('People API ${response.statusCode} response: ${response.body}');
      return result;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic>? connections = data['connections'];
    if (connections == null) return result;
    var contacts = connections.where((c) => c['names'] != null);
    // TODO: check if contact already has an account on the app (firestore) somehow
    // https://developers.google.com/people/api/rest/v1/people/listDirectoryPeople
    result.addAll(contacts
        .map((c) => [
              c['names'][0]['displayName'],
              c['emailAddresses'] != null
                  ? c['emailAddresses'][0]['value']
                  : null
            ])
        .map((c) => Relation(LangameUser(displayName: c[0], email: c[1]))));
    return result;
  }

  /// Query Firestore with [uid] looking for a LangameUser
  /// Throw GetUserException if it does not exist
  /// TODO: might use a transaction?
  Future<LangameUser?> getLangameUser(String uid) async {
    CollectionReference users =
        firebase.firestore.collection(kFirestoreUsersCollection);
    DocumentSnapshot doc = await users.doc(uid).get();
    if (!doc.exists) return null;
    var data = doc.data();
    if (data == null) return null;
    var u = LangameUser.fromJson(data);
    firebase.crashlytics.setUserIdentifier(u.uid!);
    firebase.analytics.setUserId(u.uid!);
    return u;
  }

  Future<LangameUser> addLangameUser(User user) async {
    CollectionReference users =
        firebase.firestore.collection(kFirestoreUsersCollection);
    LangameUser langameUser = LangameUser.fromFirebaseUser(user);
    var t = await _generateTag(user);
    if (user.providerData.any((e) => e.providerId == 'google.com')) {
      if (!kReleaseMode)
        debugPrint('${user.displayName} is authenticated with google.com');
      langameUser.google = true;
    }
    langameUser.tag = t;
    if (!kReleaseMode) debugPrint('add $t');
    return users
        .doc(langameUser.uid)
        .set(langameUser.toJson())
        .then((value) => langameUser)
        .catchError((err) => throw LangameAddUserException(err.toString()));
  }

  @override
  Future<List<LangameUser>> getLangameUsersStartingWithTag(String tag) async {
    CollectionReference users =
        firebase.firestore.collection(kFirestoreUsersCollection);

    /// Query users with tag starting with [tag]
    QuerySnapshot doc = await users
        .where('tag', isGreaterThanOrEqualTo: tag)
        .where('tag', isLessThan: tag + 'z')
        .get();
    return doc.docs
        .where((e) => e.data() != null)
        .map((e) => LangameUser.fromJson(e.data()!))
        .toList();
  }

  @override
  Future<void> logout() async {
    if (_google != null) await firebase.googleSignIn.signOut();
    await firebase.auth.signOut();
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
    if (firebase.auth.currentUser == null)
      throw LangameUpdateProfileException(cause: kNotAuthenticated);
    await firebase.auth.currentUser!
        .updateProfile(displayName: displayName, photoURL: photoURL);
    if (newEmail != null)
      await firebase.auth.currentUser!.updateEmail(newEmail);
    HttpsCallable callable = firebase.functions.httpsCallable(
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
}
