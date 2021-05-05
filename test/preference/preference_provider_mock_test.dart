// import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

// import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
// import 'package:langame/helpers/fake.dart';
// import 'package:langame/providers/crash_analytics_provider.dart';
// import 'package:langame/providers/preference_provider.dart';
// import 'package:langame/services/http/firebase.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../mock_firebase_analytics.dart';
// import '../mock_firebase_crashlytics.dart';
//
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Preference Provider', () {
//     late MockFirebaseAuth auth;
//     late MockFirestoreInstance firestore;
//     late MockGoogleSignIn googleSignIn;
//     late MockFirebaseCrashlytics crashlytics;
//     late MockFirebaseAnalytics analytics;
//     late FirebaseApi firebase;
//     late CrashAnalyticsProvider crashAnalyticsProvider;
//     late PreferenceProvider preferenceProvider;
//     late MockUser mockUser;
//
//     Future<void> authUser(MockUser u) async {
//       auth = MockFirebaseAuth(mockUser: u);
//       final signInAccount = await googleSignIn.signIn();
//       expect(signInAccount, isNotNull);
//       final googleAuth = await signInAccount!.authentication;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       final result = await auth.signInWithCredential(credential);
//       final user = result.user;
//       debugPrint('${user!.displayName} is authenticated');
//     }
//
//     setUp(() async {
//       mockUser = getMockUser();
//       googleSignIn = MockGoogleSignIn();
//       firestore = MockFirestoreInstance();
//       crashlytics = MockFirebaseCrashlytics();
//       analytics = MockFirebaseAnalytics();
//       await authUser(mockUser);
//
//       firebase = FirebaseApi(
//         firestore: firestore,
//         auth: auth,
//         googleSignIn: googleSignIn,
//         analytics: analytics,
//         crashlytics: crashlytics,
//         useEmulator: false,
//       );
//       crashAnalyticsProvider = CrashAnalyticsProvider(crashlytics, analytics);
//       preferenceProvider = PreferenceProvider(firebase, crashAnalyticsProvider);
//     });
//
//     tearDown(() async {
//       var i = await SharedPreferences.getInstance();
//       i.clear();
//     });
//
//     test('', () async {
//       SharedPreferences.setMockInitialValues({});
//       var p = preferenceProvider.preference;
//       print('p $p');
//     });
  });
}
