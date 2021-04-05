const uid = 'abc';
void main() async {
  // TestWidgetsFlutterBinding.ensureInitialized();
  // WidgetsFlutterBinding.ensureInitialized();
  // var auth = MockFirebaseAuth(mockUser: getMockUser());
  // var firestore = MockFirestoreInstance();
  // var functions = MockFirebaseFunctions();
  // final googleSignIn = MockGoogleSignIn();
  // final FirebaseApi firebase = FirebaseApi(
  //     null, firestore, auth, functions, googleSignIn,
  //     useEmulator: false);
  //
  // // await Firebase.initializeApp();
  // testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
  //   var a = AuthenticationProvider(firebase);
  //   Widget testWidget = new MediaQuery(
  //       data: new MediaQueryData(),
  //       child: new MaterialApp(
  //           home: MultiProvider(
  //         providers: [
  //           ChangeNotifierProvider(create: (context) => SettingProvider()),
  //           ChangeNotifierProvider(create: (context) => TopicProvider()),
  //           ChangeNotifierProvider(create: (context) => a),
  //           ChangeNotifierProvider(create: (context) => ProfileProvider()),
  //           ChangeNotifierProvider(
  //               create: (context) => FirestoreProvider(firestore)),
  //         ],
  //         child: Login(),
  //       )));
  //
  //   // Create the widget by telling the tester to build it.
  //   await tester.pumpWidget(testWidget);
  //   var googleButton = find.byType(GoogleSignInButton);
  //   await tester.tap(googleButton);
  //   find.text('Choose an account');
  //
  //   print(a.user);
  //   // TODO: grab google widget and tap the account to connect ...
  //   a.stopNotifications();
  // }, initialTimeout: Duration(seconds: 5));
}
