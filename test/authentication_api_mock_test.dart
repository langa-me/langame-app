import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:langame/models/user.dart';
import 'package:langame/services/http/impl_authentication_api.dart';

import 'helpers.dart';

void main() {
  group('ImplAuthenticationApi', () {
    late MockFirebaseAuth auth;
    late MockFirestoreInstance firestore;
    late MockFirebaseFunctions functions;
    late MockGoogleSignIn googleSignIn;
    late ImplAuthenticationApi api;
    setUp(() {
      auth = MockFirebaseAuth(mockUser: getMockUser());
      firestore = MockFirestoreInstance();
      functions = MockFirebaseFunctions();
      googleSignIn = MockGoogleSignIn();
      api = ImplAuthenticationApi(auth, functions, firestore, googleSignIn);
    });
    test('Should properly authenticate Bob with Google', () async {
      var credential = await api.loginWithGoogle();
      var stream = await api.loginWithFirebase(credential);
      var user = await stream.first;
      expect(user!.displayName, getMockUser().displayName);
    });

    // TODO: (would need to mock facebook, apple ...)
    // test('Should properly authenticate Bob with Apple', () async {
    //   var credential = await api.loginWithApple();
    //   var stream = await api.loginWithFirebase(credential);
    //   var user = await stream.first;
    //   expect(user!.displayName, mockUser.displayName);
    // });
    //
    // test('Should properly authenticate Bob with Facebook', () async {
    //   var credential = await api.loginWithFacebook();
    //   var stream = await api.loginWithFirebase(credential);
    //   var user = await stream.first;
    //   expect(user!.displayName, mockUser.displayName);
    // });

    // MockUser doesn't properly latest version of firebase auth, skipped (emailVerified)
    test('Should properly add LangameUser', () async {
      var user = await api.addLangameUser(getMockUser());
      expect(user.displayName, getMockUser().displayName);
    });

    test('Should properly get LangameUser', () async {
      var uid = 'bar';
      await firestore
          .collection('users')
          .doc(uid)
          .set(LangameUser(uid: uid).toJson());
      var user = await api.getLangameUser(uid);
      expect(user, isNotNull);
      expect(user!.uid, uid);
    });

    test('getLangameUser should return null', () async {
      var uid = 'bar';
      await firestore
          .collection('users')
          .doc(uid)
          .set(LangameUser(uid: uid).toJson());
      var user = await api.getLangameUser('foo');
      expect(user, isNull);
    });

    test('getLangameUsersStartingWithTag should return one element', () async {
      var tag = 'bar';
      await firestore
          .collection('users')
          .doc('baz')
          .set(LangameUser(tag: tag).toJson());
      var user = await api.getLangameUsersStartingWithTag(tag);
      expect(user.length, 1);
      expect(user[0].tag, tag);
      user = await api.getLangameUsersStartingWithTag(tag[0]);
      expect(user.length, 1);
      expect(user[0].tag, tag);
      user = await api.getLangameUsersStartingWithTag(tag.substring(0, 1));
      expect(user.length, 1);
      expect(user[0].tag, tag);
    });

    test('getLangameUsersStartingWithTag should return none', () async {
      var tag = 'bar';
      await firestore
          .collection('users')
          .doc('baz')
          .set(LangameUser(tag: tag).toJson());
      var user = await api.getLangameUsersStartingWithTag('ar');
      expect(user.length, 0);
    });

    // TODO: api.getRelations, need to mock Google, Apple, Facebook api :)
    // test('getRelations', () async {
    // });
  });
}
