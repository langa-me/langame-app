import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:langame/helpers/fake.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:langame/services/http/impl_message_api.dart';

import '../mock_firebase_functions.dart';
import '../mock_firebase_messaging.dart';

void main() {
  group('ImplMessageApi', () {
    late MockFirebaseAuth auth;
    late MockFirestoreInstance firestore;
    late MockFirebaseFunctions functions;
    late MockGoogleSignIn googleSignIn;
    late MockFirebaseMessaging messaging;
    late FirebaseApi firebase;
    late ImplMessageApi api;
    setUp(() {
      auth = MockFirebaseAuth(mockUser: getMockUser());
      firestore = MockFirestoreInstance();
      functions = MockFirebaseFunctions();
      googleSignIn = MockGoogleSignIn();
      messaging = MockFirebaseMessaging();
      firebase = FirebaseApi(
          messaging, firestore, auth, functions, googleSignIn,
          useEmulator: false);
      api = ImplMessageApi(firebase, (n) {});
    });
    test('Should properly authenticate Bob with Google', () async {
      // await api.send('bar', '666');
    });
  });
}
