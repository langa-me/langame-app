void main() {}
// import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
// import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
// import 'package:langame/providers/authentication_provider.dart';
// import 'package:langame/providers/firestore_provider.dart';
// import 'package:langame/providers/profile_provider.dart';
// import 'package:langame/providers/setting_provider.dart';
// import 'package:langame/providers/topic_provider.dart';
// import 'package:langame/views/buttons/google.dart';
// import 'package:langame/views/login.dart';
// import 'package:provider/provider.dart';
//
// import 'helpers.dart';
//
// const uid = 'abc';
// void main() async {
//   TestWidgetsFlutterBinding.ensureInitialized();
//   WidgetsFlutterBinding.ensureInitialized();
//   var auth = MockFirebaseAuth();
//   var firestore = MockFirestoreInstance();
//   var functions = MockFirebaseFunctions();
//   final googleSignIn = MockGoogleSignIn();
//   // await Firebase.initializeApp();
//   testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
//     var a = AuthenticationProvider(auth, functions, firestore, googleSignIn,
//         emulator: false);
//     Widget testWidget = new MediaQuery(
//         data: new MediaQueryData(),
//         child: new MaterialApp(
//             home: MultiProvider(
//           providers: [
//             ChangeNotifierProvider(create: (context) => SettingProvider()),
//             ChangeNotifierProvider(create: (context) => TopicProvider()),
//             ChangeNotifierProvider(create: (context) => a),
//             ChangeNotifierProvider(create: (context) => ProfileProvider()),
//             ChangeNotifierProvider(
//                 create: (context) => FirestoreProvider(firestore)),
//           ],
//           child: Login(),
//         )));
//
//     // Create the widget by telling the tester to build it.
//     await tester.pumpWidget(testWidget);
//     var googleButton = find.byType(GoogleSignInButton);
//     await tester.tap(googleButton);
//     find.text('Choose an account');
//
//     // TODO: grab google widget and tap the account to connect ...
//     a.stopNotifications();
//   }, initialTimeout: Duration(seconds: 5));
// }
