import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:connectivity/connectivity.dart';
import 'package:feedback/feedback.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/audio_provider.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/feedback_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/providers/langame_provider.dart';
import 'package:langame/providers/message_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/providers/topic_provider.dart';
import 'package:langame/services/http/impl_authentication_api.dart';
import 'package:langame/services/http/impl_message_api.dart';
import 'package:langame/views/langame.dart';
import 'package:langame/views/login.dart';
import 'package:provider/provider.dart';

import 'providers/relation_provider.dart';
import 'services/http/firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var crashlytics = FirebaseCrashlytics.instance;
  await crashlytics.setCrashlyticsCollectionEnabled(true);
  var analytics = FirebaseAnalytics();
  FirebaseApi firebase = FirebaseApi(
    messaging: FirebaseMessaging.instance,
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
    functions: FirebaseFunctions.instance,
    googleSignIn: GoogleSignIn(scopes: <String>[
      'email',
    ]),
    crashlytics: crashlytics,
    analytics: analytics,
    storage: FirebaseStorage.instance,
    useEmulator: false,
  );
  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = crashlytics.recordFlutterError;
  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair;
    await crashlytics.recordError(
      errorAndStacktrace.first,
      errorAndStacktrace.last,
    );
  }).sendPort);
  var navigationKey = GlobalKey<NavigatorState>(debugLabel: 'navKey');
  var scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>(debugLabel: 'scaffoldKey');
  var contextProvider = ContextProvider(navigationKey, scaffoldMessengerKey);
  var crashAnalyticsProvider =
      CrashAnalyticsProvider(firebase.crashlytics!, firebase.analytics!);
  var authenticationApi = ImplAuthenticationApi(firebase);
  var authenticationProvider = AuthenticationProvider(
      firebase, authenticationApi, crashAnalyticsProvider);
  var messageApi = ImplMessageApi(firebase, (n) {
    if (n?.channelName != null) {
      navigationKey.currentState?.pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              LangameView(n!.channelName!, n.ready == null || !n.ready!),
        ),
      );
    }
  });
  var messageProvider = MessageProvider(firebase, messageApi, authenticationApi,
      crashAnalyticsProvider, authenticationProvider);
  var relationProvider = RelationProvider(
      authenticationApi, crashAnalyticsProvider, authenticationProvider);
  var preferenceProvider = PreferenceProvider(firebase, crashAnalyticsProvider);

  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (_) => runApp(
      BetterFeedback(
        child: MultiProvider(
          providers: [
            ///////////////////////////////////////////
            ////////// Independent providers //////////
            ///////////////////////////////////////////

            ChangeNotifierProvider(create: (_) => crashAnalyticsProvider),
            ChangeNotifierProvider(create: (_) => preferenceProvider),
            // TODO: might be injected in all providers?
            StreamProvider<ConnectivityResult>.value(
                value: Connectivity().onConnectivityChanged,
                initialData: ConnectivityResult.wifi),
            ChangeNotifierProvider(
              create: (_) => contextProvider,
            ),
            ChangeNotifierProvider(create: (_) => TopicProvider(firebase)),
            ChangeNotifierProvider(create: (_) => FunnyProvider()),
            ChangeNotifierProvider(create: (_) => LangameProvider()),

            ///////////////////////////////////////////
            ////////// Dependent providers ////////////
            ///////////////////////////////////////////

            ChangeNotifierProxyProvider<CrashAnalyticsProvider,
                AuthenticationProvider>(
              update: (_, cap, ap) =>
                  AuthenticationProvider(firebase, authenticationApi, cap),
              create: (_) => authenticationProvider,
            ),
            ChangeNotifierProxyProvider<CrashAnalyticsProvider,
                PreferenceProvider>(
              update: (_, cap, ap) => PreferenceProvider(firebase, cap),
              create: (_) => preferenceProvider,
            ),
            ChangeNotifierProxyProvider<CrashAnalyticsProvider, AudioProvider>(
              update: (_, cap, ap) => AudioProvider(firebase, cap),
              create: (_) => AudioProvider(firebase, crashAnalyticsProvider),
            ),
            ChangeNotifierProxyProvider2<CrashAnalyticsProvider,
                AuthenticationProvider, MessageProvider>(
              update: (_, cap, ap, mp) => MessageProvider(
                  // TODO: might not necessarily rebuild every time
                  firebase,
                  messageApi,
                  authenticationApi,
                  cap,
                  ap),
              create: (_) => messageProvider,
            ),
            ChangeNotifierProxyProvider2<CrashAnalyticsProvider,
                AuthenticationProvider, RelationProvider>(
              update: (_, cap, ap, rp) => RelationProvider(
                  // TODO: might not necessarily rebuild every time
                  authenticationApi,
                  cap,
                  ap),
              create: (_) => relationProvider,
            ),
            ChangeNotifierProxyProvider3<CrashAnalyticsProvider,
                ContextProvider, PreferenceProvider, FeedbackProvider>(
              update: (_, cap, cp, pp, fp) =>
                  FeedbackProvider(firebase, cap, cp, pp),
              create: (_) => FeedbackProvider(firebase, crashAnalyticsProvider,
                  contextProvider, preferenceProvider),
            ),
          ],
          child: MyApp(analytics, navigationKey, scaffoldMessengerKey),
        ),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final GlobalKey<NavigatorState> navigationKey;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  MyApp(this.analytics, this.navigationKey, this.scaffoldMessengerKey);

  @override
  _MyAppState createState() => _MyAppState(
      this.analytics, this.navigationKey, this.scaffoldMessengerKey);
}

// TODO: https://github.com/rydmike/flex_color_scheme/blob/master/example/lib/example5/main.dart
class _MyAppState extends State<MyApp> {
  final FirebaseAnalytics analytics;
  final GlobalKey<NavigatorState> navigationKey;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  _MyAppState(this.analytics, this.navigationKey, this.scaffoldMessengerKey);

  @override
  initState() {
    super.initState();
    analytics.logAppOpen();
  }

  @override
  Widget build(BuildContext context) {
    FlexScheme scheme = FlexScheme.bigStone;
    return Consumer<PreferenceProvider>(builder: (context, s, child) {
      return MaterialApp(
        title: 'Langame',
        themeMode: ThemeMode.values[s.preference.themeIndex],
        theme: FlexColorScheme.light(
          scheme: scheme,
          fontFamily: AppFont.mainFont,
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          background: Colors.transparent,
        ).toTheme,
        darkTheme: FlexColorScheme.dark(
          scheme: scheme,
          fontFamily: AppFont.mainFont,
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          background: Colors.transparent,
        ).toTheme,
        home: Login(),
        navigatorKey: navigationKey,
        scaffoldMessengerKey: scaffoldMessengerKey,
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
