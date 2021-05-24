// import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
// import 'package:flutter/foundation.dart';
// import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
// import 'package:langame/helpers/constants.dart';
// import 'package:langame/helpers/fake.dart';
// import 'package:langame/services/http/firebase.dart';
// import 'package:langame/services/http/preference/impl_preference_service.dart';
// import 'package:langame/services/http/preference/preference_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:test/expect.dart';
// import 'package:test/test.dart';

// void main() {
//   group('Preference API', () {
//     late MockFirebaseAuth auth;
//     late MockFirestoreInstance firestore;
//     late MockGoogleSignIn googleSignIn;
//     late FirebaseApi firebase;
//     late ImplPreferenceService preferenceService;
//     late MockUser mockUser;

//     Future<void> authUser(MockUser u) async {
//       auth = MockFirebaseAuth(mockUser: u);
//       final signInAccount = await googleSignIn.signIn();
//       expect(signInAccount, isNotNull);
//       final googleAuth = await signInAccount!.authentication;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       final result = await auth.signInWithCredential(credential);
//       final user = result.user;
//       debugPrint('${user!.displayName} is authenticated');
//     }

//     setUp(() async {
//       mockUser = getMockUser();
//       googleSignIn = MockGoogleSignIn();
//       firestore = MockFirestoreInstance();
//       await authUser(mockUser);

//       firebase = FirebaseApi(
//         firestore: firestore,
//         auth: auth,
//         googleSignIn: googleSignIn,
//         useEmulator: false,
//       );
//       preferenceService = ImplPreferenceService(firebase);
//     });

//     tearDown(() async {
//       var i = await SharedPreferences.getInstance();
//       i.clear();
//     });

//     test('Should properly save and fetch from local storage', () async {
//       var p = PreferenceService.defaultPreference;
//       SharedPreferences.setMockInitialValues(
//           {PreferenceService.sharedPrefPrefKey: p.writeToJson()});
//       debugPrint('p $p');
//       await preferenceService.savePreference(mockUser.uid, p);
//       var fetchedP = await preferenceService.tryFetchFromLocalStorage();
//       debugPrint('fetched $fetchedP');
//       expect(fetchedP, isNotNull);
//       expect(fetchedP!.unknownPeopleRecommendations,
//           equals(p.unknownPeopleRecommendations));
//       expect(fetchedP.themeIndex, equals(p.themeIndex));
//       expect(fetchedP.hasDoneOnBoarding, equals(p.hasDoneOnBoarding));
//       expect(fetchedP.shakeToFeedback, equals(p.shakeToFeedback));
//       expect(fetchedP.userId, equals(mockUser.uid));
//     });

//     test('Should properly save on the cloud', () async {
//       var p = PreferenceService.defaultPreference;
//       SharedPreferences.setMockInitialValues(
//           {PreferenceService.sharedPrefPrefKey: p.writeToJson()});
//       debugPrint('p $p');
//       await preferenceService.savePreference(mockUser.uid, p);
//       var qs = await firestore
//           .collection(AppConst.firestorePreferencesCollection)
//           .where('userId', isEqualTo: mockUser.uid)
//           .get();
//       var fetchedP = qs.docs.first;
//       debugPrint('fetched ${fetchedP.data()}');
//       expect(fetchedP.exists, isTrue);
//       expect(fetchedP.data(), isNotNull);
//       expect(fetchedP.data()['unknownPeopleRecommendations'],
//           equals(p.unknownPeopleRecommendations));
//       expect(fetchedP.data()['themeIndex'], equals(p.themeIndex));
//       expect(fetchedP.data()['hasDoneOnBoarding'], equals(p.hasDoneOnBoarding));
//       expect(fetchedP.data()['shakeToFeedback'], equals(p.shakeToFeedback));
//       expect(fetchedP.data()['userId'], equals(mockUser.uid));
//     });

//     test('Should properly stream preferences', () async {
//       var p = PreferenceService.defaultPreference;
//       SharedPreferences.setMockInitialValues(
//           {PreferenceService.sharedPrefPrefKey: p.writeToJson()});
//       debugPrint('p $p');

//       var s = preferenceService.streamPreference(mockUser);
//       var i = 0;
//       s.forEach((e) {
//         // Last-in first-out
//         debugPrint('e $e');
//         expect(e, isNotNull);
//         expect(e.unknownPeopleRecommendations,
//             equals(p.unknownPeopleRecommendations));
//         expect(e.themeIndex, equals(p.themeIndex));
//         expect(e.hasDoneOnBoarding, equals(p.hasDoneOnBoarding));
//         expect(e.shakeToFeedback,
//             equals(i == 0 ? !p.shakeToFeedback : p.shakeToFeedback));
//         expect(e.userId, equals(mockUser.uid));

//         i++;
//       });
//       await preferenceService.savePreference(mockUser.uid, p);

//       p.shakeToFeedback = !p.shakeToFeedback;
//       debugPrint('p $p');

//       await preferenceService.savePreference(mockUser.uid, p);
//     });

//     test('Should properly reset stream when calling again', () async {
//       var p = PreferenceService.defaultPreference;
//       SharedPreferences.setMockInitialValues(
//           {PreferenceService.sharedPrefPrefKey: p.writeToJson()});
//       debugPrint('p $p');
//       await preferenceService.savePreference(mockUser.uid, p);

//       var s = preferenceService.streamPreference(mockUser);
//       expect((await s.first).userId, equals(mockUser.uid));
//       var mu = MockUser(displayName: 'foo', uid: 'bar');
//       await authUser(mu);

//       await preferenceService.savePreference(mu.uid, p);
// // 
//       var s2 = preferenceService.streamPreference(mu);
//       expect((await s2.first).userId, equals(mu.uid));
//     });
//   });
// }
