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
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/feedback_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/providers/langame_provider.dart';
import 'package:langame/providers/local_storage_provider.dart';
import 'package:langame/providers/topic_provider.dart';
import 'package:langame/views/login.dart';
import 'package:provider/provider.dart';

import 'services/http/firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  await Firebase.initializeApp();
  var crashlytics = FirebaseCrashlytics.instance;
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
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (_) => runApp(
      BetterFeedback(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (_) => LocalStorageProvider(firebase)),
            ChangeNotifierProvider(create: (_) => TopicProvider(firebase)),
            ChangeNotifierProvider(
              create: (_) => AuthenticationProvider(firebase, fake: false),
            ),
            ChangeNotifierProvider(create: (_) => FunnyProvider()),
            ChangeNotifierProvider(create: (_) => LangameProvider()),
            ChangeNotifierProvider(
                create: (_) => CrashAnalyticsProvider(
                    firebase.crashlytics!, firebase.analytics!)),
            ChangeNotifierProvider(create: (_) => AudioProvider(firebase)),
            StreamProvider<ConnectivityResult>.value(
                value: Connectivity().onConnectivityChanged,
                initialData: ConnectivityResult.wifi),
            ChangeNotifierProvider(
              create: (_) => FeedbackProvider(firebase),
            ),
          ],
          child: MyApp(analytics),
        ),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final FirebaseAnalytics analytics;
  MyApp(this.analytics);

  @override
  _MyAppState createState() => _MyAppState(this.analytics);
}

// TODO: https://github.com/rydmike/flex_color_scheme/blob/master/example/lib/example5/main.dart
class _MyAppState extends State<MyApp> {
  final FirebaseAnalytics analytics;
  _MyAppState(this.analytics);

  @override
  initState() {
    super.initState();
    analytics.logAppOpen();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<LocalStorageProvider>(context, listen: false).load();
    FlexScheme scheme = FlexScheme.bigStone;
    return Consumer<LocalStorageProvider>(builder: (context, s, child) {
      return MaterialApp(
        title: 'Langame',
        themeMode: s.theme,
        theme: FlexColorScheme.light(
          scheme: scheme,
          fontFamily: AppFont.mainFont,
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          background: Colors.transparent,
        ).toTheme.copyWith(
            // elevatedButtonTheme: ElevatedButtonThemeData(
            //   style: ButtonStyle(
            //       backgroundColor: MaterialStateProperty.all(
            //           ThemeData.),
            //       textStyle: MaterialStateProperty.all(
            //           Theme.of(context).textTheme.headline6)),
            // ),
            ),
        darkTheme: FlexColorScheme.dark(
          scheme: scheme,
          fontFamily: AppFont.mainFont,
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          background: Colors.transparent,
        ).toTheme.copyWith(
            // elevatedButtonTheme: ElevatedButtonThemeData(
            //   style: ButtonStyle(
            //       backgroundColor: MaterialStateProperty.all(
            //           Theme.of(context).colorScheme.primary),
            //       textStyle: MaterialStateProperty.all(
            //           Theme.of(context).textTheme.headline6)),
            // ),
            ),
        home: Login(),
        navigatorKey: AppConst.navKey,
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
        debugShowCheckedModeBanner: false,
      );
    });
  }

  @override
  void dispose() {
    // Provider.of<AuthenticationProvider>(context, listen: false)
    //     .stopNotifications();
    super.dispose();
  }
}
