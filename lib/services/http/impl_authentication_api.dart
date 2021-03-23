import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/user.dart';

import 'authentication_api.dart';

// TODO: ABSOLUTELY TEST
class ImplAuthenticationApi implements AuthenticationApi {
  GoogleSignInAccount? _google;
  // FacebookUser? _facebook;
  // AppleUser? _apple;
  String kFirestoreUsersCollection = 'users';

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
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly'
    ]).signIn();

    // If Google Auth cancelled
    if (googleUser == null)
      throw GoogleSignInException('authentication likely have been cancelled');

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
  Future<Stream<User?>> loginWithFirebase(OAuthCredential credential) async {
    var f = Future.value(FirebaseAuth.instance.authStateChanges());
    f.then((value) {
      FirebaseAuth.instance.signInWithCredential(credential);
    });
    return f;
  }

  @override
  Future<LangameUserRelations> getRelations(LangameUser user) async {
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

  // Future<List<Relation>> _getAppleRelations(AppleUser user) async {
  //   throw UnimplementedError();
  // }
  //
  // Future<List<Relation>> _getFacebookRelations(FacebookUser user) async {
  //   throw UnimplementedError();
  // }

  Future<List<Relation>> _getGoogleRelations(GoogleSignInAccount user) async {
    var result = <Relation>[];
    final Response response = await get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
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
    // TODO: check if contact already has an account on the app (firestore) using email
    result.addAll(contacts
        .where((c) => c['displayName'] != null)
        .map((c) => Relation(LangameUser(displayName: c))));
    return result;
  }

  /// Query Firestore with [uid] looking for a LangameUser
  /// Throw GetUserException if it does not exist
  /// TODO: might use a transaction?
  Future<LangameUser?> getLangameUser(String uid) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection(kFirestoreUsersCollection);
    DocumentSnapshot doc = await users.doc(uid).get();
    if (!doc.exists) return null;
    var data = doc.data();
    if (data == null) return null;
    return LangameUser.fromJson(data);
  }

  Future<LangameUser> addLangameUser(User user) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection(kFirestoreUsersCollection);
    LangameUser langameUser = LangameUser.fromFirebaseUser(user);
    return users
        .add(langameUser.toJson())
        .then((value) => langameUser)
        .catchError((err) => throw AddUserException(err.toString()));
  }
}
