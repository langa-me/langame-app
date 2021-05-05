// import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
// import 'package:langame/helpers/constants.dart';
// import 'package:langame/helpers/fake.dart';
// import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
// import 'package:langame/providers/authentication_provider.dart';
// import 'package:langame/providers/crash_analytics_provider.dart';
// import 'package:langame/providers/relation_provider.dart';
// import 'package:langame/services/http/firebase.dart';
// import 'package:langame/services/http/impl_authentication_api.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../mock_firebase_analytics.dart';
// import '../mock_firebase_crashlytics.dart';
// import '../mock_firebase_functions.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Relation Provider', () {
    // late MockFirebaseAuth auth;
    // late MockFirestoreInstance firestore;
    // late MockGoogleSignIn googleSignIn;
    // late MockFirebaseCrashlytics crashlytics;
    // late MockFirebaseAnalytics analytics;
    // late MockFirebaseFunctions functions;
    // late FirebaseApi firebase;
    // late CrashAnalyticsProvider crashAnalyticsProvider;
    // late RelationProvider relationProvider;
    // late MockUser mockUser;
    //
    // Future<void> authUser(MockUser u) async {
    //   auth = MockFirebaseAuth(mockUser: u);
    //   final signInAccount = await googleSignIn.signIn();
    //   expect(signInAccount, isNotNull);
    //   final googleAuth = await signInAccount!.authentication;
    //   final AuthCredential credential = GoogleAuthProvider.credential(
    //     accessToken: googleAuth.accessToken,
    //     idToken: googleAuth.idToken,
    //   );
    //
    //   final result = await auth.signInWithCredential(credential);
    //   final user = result.user;
    //   debugPrint('${user!.displayName} is authenticated');
    // }
    //
    // setUp(() async {
    //   mockUser = getMockUser();
    //   googleSignIn = MockGoogleSignIn();
    //   firestore = MockFirestoreInstance();
    //   crashlytics = MockFirebaseCrashlytics();
    //   analytics = MockFirebaseAnalytics();
    //   functions = MockFirebaseFunctions();
    //   await authUser(mockUser);
    //
    //   firebase = FirebaseApi(
    //     firestore: firestore,
    //     auth: auth,
    //     googleSignIn: googleSignIn,
    //     analytics: analytics,
    //     crashlytics: crashlytics,
    //     functions: functions,
    //     useEmulator: false,
    //   );
    //   var authApi = ImplAuthenticationApi(firebase);
    //   crashAnalyticsProvider = CrashAnalyticsProvider(crashlytics, analytics);
    //   relationProvider = RelationProvider(authApi, crashAnalyticsProvider,
    //       AuthenticationProvider(firebase, authApi, crashAnalyticsProvider));
    // });
    //
    // tearDown(() async {
    //   var i = await SharedPreferences.getInstance();
    //   i.clear();
    // });
    //
    // test('should have some recommended users', () async {
    //   SharedPreferences.setMockInitialValues({});
    //   await firestore.collection(AppConst.firestoreUsersCollection).add(
    //       lg.User(uid: 'foo', displayName: 'bar').toProto3Json()
    //           as Map<String, dynamic>);
    //   await relationProvider.getUserRecommendations();
    //   var r = relationProvider.userRecommendations;
    //   print('r $r');
    //   expect(r.length, greaterThan(0));
    //   expect(r.length, equals(1));
    //   expect(r.first.uid, equals('foo'));
    //   expect(r.first.displayName, equals('bar'));
    // });
  });
}
