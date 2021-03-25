import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/user.dart';

import 'authentication_api.dart';

// TODO: ABSOLUTELY TEST
class ImplAuthenticationApi extends AuthenticationApi {
  GoogleSignInAccount? _google;
  // FacebookUser? _facebook;
  // AppleUser? _apple;
  String kFirestoreUsersCollection = 'users';

  ImplAuthenticationApi(
      FirebaseAuth firebaseAuth,
      FirebaseFunctions firebaseFunctions,
      FirebaseFirestore firebaseFirestore,
      GoogleSignIn googleSignIn)
      : super(firebaseAuth, firebaseFunctions, firebaseFirestore, googleSignIn);

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
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

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
    var f = Future.value(firebaseAuth.authStateChanges());
    f.then((value) {
      firebaseAuth.signInWithCredential(credential);
    });
    return f;
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
        firebaseFirestore.collection(kFirestoreUsersCollection);
    DocumentSnapshot doc = await users.doc(uid).get();
    if (!doc.exists) return null;
    var data = doc.data();
    if (data == null) return null;
    return LangameUser.fromJson(data);
  }

  Future<LangameUser> addLangameUser(User user) async {
    CollectionReference users =
        firebaseFirestore.collection(kFirestoreUsersCollection);
    LangameUser langameUser = LangameUser.fromFirebaseUser(user);
    return users
        .doc(langameUser.uid)
        .set(langameUser.toJson())
        .then((value) => langameUser)
        .catchError((err) => throw AddUserException(err.toString()));
  }

  @override
  Future<List<LangameUser>> getLangameUsersStartingWithTag(String tag) async {
    CollectionReference users =
        firebaseFirestore.collection(kFirestoreUsersCollection);

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
}
