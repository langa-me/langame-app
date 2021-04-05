import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/firestore_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/providers/local_storage_provider.dart';
import 'package:langame/providers/profile_provider.dart';
import 'package:langame/providers/topic_provider.dart';
import 'package:langame/views/login.dart';
import 'package:provider/provider.dart';

import 'services/http/firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  await Firebase.initializeApp();
  var analytics = FirebaseAnalytics();
  FirebaseApi firebase = FirebaseApi(
    FirebaseMessaging.instance,
    FirebaseFirestore.instance,
    FirebaseAuth.instance,
    FirebaseFunctions.instance,
    GoogleSignIn(scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly'
    ]),
    FirebaseCrashlytics.instance,
    analytics,
    useEmulator: false,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocalStorageProvider(firebase)),
        ChangeNotifierProvider(create: (_) => TopicProvider()),
        ChangeNotifierProvider(
          create: (_) => AuthenticationProvider(firebase, fake: false),
        ),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(
            create: (context) => FirestoreProvider(firebase.firestore)),
        ChangeNotifierProvider(create: (_) => FunnyProvider()),
      ],
      child: MyApp(analytics),
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
  Widget build(BuildContext context) {
    Provider.of<LocalStorageProvider>(context, listen: false).load();
    return Consumer<LocalStorageProvider>(builder: (context, s, child) {
      return MaterialApp(
        title: 'Langame',
        themeMode: s.theme,
        theme: FlexColorScheme.light(
          scheme: FlexScheme.ebonyClay,
          fontFamily: AppFont.mainFont,
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          background: Colors.transparent,
        ).toTheme.copyWith(
            // elevatedButtonTheme: ElevatedButtonThemeData(
            //     // style: ButtonStyle(
            //     //     backgroundColor: MaterialStateProperty.all(Colors.red)),
            //     ),
            ),
        darkTheme: FlexColorScheme.dark(
          scheme: FlexScheme.ebonyClay,
          fontFamily: AppFont.mainFont,
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          background: Colors.transparent,
        ).toTheme.copyWith(
            // elevatedButtonTheme: ElevatedButtonThemeData(
            //     // style: ButtonStyle(
            //     //     backgroundColor: MaterialStateProperty.all(Colors.red)),
            //     ),
            ),
        // home: Scaffold(),
        home: Login(),
        navigatorKey: AppConst.navKey,
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
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
