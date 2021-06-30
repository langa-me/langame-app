import 'dart:convert';

import 'package:http/http.dart';
import 'package:test/test.dart';

void main() {
  group('ImplAuthenticationApi', () {
    // TODO: PR MOCK REPO
    // package:firebase_auth/src/firebase_auth.dart 271:17               MockFirebaseAuth.userChanges
    // package:langame/services/http/impl_authentication_api.dart 31:39  new ImplAuthenticationApi
    // test/authentication/preference_api_mock_test.dart 32:13       main.<fn>.<fn>
    //
    // type 'Null' is not a subtype of type 'Stream<User?>'

    // late MockFirebaseMessaging messaging;
    // late MockFirebaseAuth auth;
    // late MockFirestoreInstance firestore;
    // late MockFirebaseFunctions functions;
    // late MockGoogleSignIn googleSignIn;
    // late FirebaseApi firebase;
    // late ImplAuthenticationApi api;
    // setUp(() {
    //   messaging = MockFirebaseMessaging();
    //   auth = MockFirebaseAuth(mockUser: getMockUser());
    //   firestore = MockFirestoreInstance();
    //   functions = MockFirebaseFunctions();
    //   googleSignIn = MockGoogleSignIn();
    //   firebase = FirebaseApi(
    //       messaging, firestore, auth, functions, googleSignIn,
    //       useEmulator: false);
    //   api = ImplAuthenticationApi(firebase);
    // });
    // test('Should properly authenticate Bob with Google', () async {
    //   var credential = await api.loginWithGoogle();
    //   await api.loginWithFirebase(credential);
    //   var user = await api.userChanges.first;
    //   expect(user!.displayName, getMockUser().displayName);
    // });

    // TODO: (would need to mock, apple ...)
    // test('Should properly authenticate Bob with Apple', () async {
    //   var credential = await api.loginWithApple();
    //   var stream = await api.loginWithFirebase(credential);
    //   var user = await stream.first;
    //   expect(user!.displayName, mockUser.displayName);
    // });
    //


    // MockUser doesn't properly latest version of firebase auth, skipped (emailVerified)
    // test('Should properly add LangameUser', () async {
    //   var user = await api.addLangameUser(getMockUser());
    //   expect(user.displayName, getMockUser().displayName);
    // });
    //
    // test('Should properly get LangameUser', () async {
    //   var uid = 'bar';
    //   await firestore
    //       .collection('users')
    //       .doc(uid)
    //       .set(LangameUser(uid: uid).toJson());
    //   var user = await api.getLangameUser(uid);
    //   expect(user, isNotNull);
    //   expect(user!.uid, uid);
    // });
    //
    // test('getLangameUser should return null', () async {
    //   var uid = 'bar';
    //   await firestore
    //       .collection('users')
    //       .doc(uid)
    //       .set(LangameUser(uid: uid).toJson());
    //   var user = await api.getLangameUser('foo');
    //   expect(user, isNull);
    // });
    //
    // test('getLangameUsersStartingWithTag should return one element', () async {
    //   var tag = 'bar';
    //   await firestore
    //       .collection('users')
    //       .doc('baz')
    //       .set(LangameUser(tag: tag).toJson());
    //   var user = await api.getLangameUsersStartingWithTag(tag);
    //   expect(user.length, 1);
    //   expect(user[0].tag, tag);
    //   user = await api.getLangameUsersStartingWithTag(tag[0]);
    //   expect(user.length, 1);
    //   expect(user[0].tag, tag);
    //   user = await api.getLangameUsersStartingWithTag(tag.substring(0, 1));
    //   expect(user.length, 1);
    //   expect(user[0].tag, tag);
    // });
    //
    // test('getLangameUsersStartingWithTag should return none', () async {
    //   var tag = 'bar';
    //   await firestore
    //       .collection('users')
    //       .doc('baz')
    //       .set(LangameUser(tag: tag).toJson());
    //   var user = await api.getLangameUsersStartingWithTag('ar');
    //   expect(user.length, 0);
    // });

    // TODO: api.getRelations, need to mock Google, Apple,  api :)
    // test('getRelations', () async {
    // });

    test('tag api', () async {
      var r = await post(
        Uri.parse('https://uzby.com/api.php'),
        body: 'min=4&max=6',
        encoding: Encoding.getByName('utf-8'),
        headers: {
          'content-type': 'application/x-www-form-urlencoded; charset=UTF-8'
        },
      );
      expect(r.body, isNotEmpty);
    });
  });
}
