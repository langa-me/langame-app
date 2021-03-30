import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:langame/helpers/fake.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/services/http/firebase.dart';

import '../mock_firebase_functions.dart';
import '../mock_firebase_messaging.dart';

void main() {
  group('AuthenticationProvider', () {
    late MockFirebaseMessaging messaging;
    late MockFirebaseAuth auth;
    late MockFirestoreInstance firestore;
    late MockFirebaseFunctions functions;
    late MockGoogleSignIn googleSignIn;
    late FirebaseApi firebase;
    late AuthenticationProvider provider;
    setUp(() async {
      messaging = MockFirebaseMessaging();
      auth = MockFirebaseAuth(mockUser: getMockUser());
      firestore = MockFirestoreInstance();
      functions = MockFirebaseFunctions();
      googleSignIn = MockGoogleSignIn();
      firebase = FirebaseApi(
          messaging, firestore, auth, functions, googleSignIn,
          useEmulator: false);
      provider = AuthenticationProvider(firebase);
    });
    test('getLangameUsersStartingWithTag should properly find people',
        () async {
      faang.forEach(
          (e) async => await firestore.collection('users').add(e.toJson()));
      var r = await provider.getLangameUsersStartingWithTag('mark');
      expect(r.first.displayName, getMarkZuckerberg().displayName);
      r = await provider.getLangameUsersStartingWithTag('larry');
      expect(r.first.displayName, getLarryPage().displayName);
      r = await provider.getLangameUsersStartingWithTag('steve');
      expect(r.first.displayName, getSteveJobs().displayName);
    });

    test(
        'loginWithGoogle should properly login the user to Google and Firebase',
        () async {
      var r = await provider.loginWithGoogle();
      expect(r.status, LangameStatus.succeed);
      expect(r.error, isNull);
      var u = await provider.userStream.first;
      expect(u?.displayName, getMockUser().displayName);
    });
  });
}
