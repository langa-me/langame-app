void main() {
  // TODO: fix
  // group('AuthenticationProvider', () {
  //   late MockFirebaseMessaging messaging;
  //   late MockFirebaseAuth auth;
  //   late MockFirestoreInstance firestore;
  //   late MockFirebaseFunctions functions;
  //   late MockGoogleSignIn googleSignIn;
  //   late MockFirebaseCrashlytics crashlytics;
  //   late FirebaseApi firebase;
  //   late AuthenticationProvider provider;
  //   setUp(() async {
  //     messaging = MockFirebaseMessaging();
  //     auth = MockFirebaseAuth(mockUser: getMockUser());
  //     firestore = MockFirestoreInstance();
  //     functions = MockFirebaseFunctions();
  //     googleSignIn = MockGoogleSignIn();
  //     crashlytics = MockFirebaseCrashlytics();
  //     firebase = FirebaseApi(
  //         messaging, firestore, auth, functions, googleSignIn, crashlytics,
  //         useEmulator: false);
  //     provider = AuthenticationProvider(firebase);
  //   });
  //   test('getLangameUsersStartingWithTag should properly find people',
  //       () async {
  //     faang.forEach(
  //         (e) async => await firestore.collection('users').add(e.toJson()));
  //     var r = await provider.getLangameUsersStartingWithTag('mark');
  //     expect(r.first.displayName, getMarkZuckerberg().displayName);
  //     r = await provider.getLangameUsersStartingWithTag('larry');
  //     expect(r.first.displayName, getLarryPage().displayName);
  //     r = await provider.getLangameUsersStartingWithTag('steve');
  //     expect(r.first.displayName, getSteveJobs().displayName);
  //   });
  //
  //   test(
  //       'loginWithGoogle should properly login the user to Google and Firebase',
  //       () async {
  //     var r = await provider.loginWithGoogle();
  //     expect(r.status, LangameStatus.succeed);
  //     expect(r.error, isNull);
  //     var u = await provider.userStream.first;
  //     expect(u?.displayName, getMockUser().displayName);
  //   });
  // });
}
