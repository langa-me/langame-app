import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/firestore_provider.dart';
import 'package:langame/providers/profile_provider.dart';
import 'package:langame/providers/setting_provider.dart';
import 'package:langame/providers/topic_provider.dart';
import 'package:langame/views/login.dart';
import 'package:provider/provider.dart';

import 'services/http/firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseApi firebase = FirebaseApi(
    FirebaseMessaging.instance,
    FirebaseFirestore.instance,
    FirebaseAuth.instance,
    FirebaseFunctions.instance,
    GoogleSignIn(scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly'
    ]),
    useEmulator: false,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingProvider()),
        ChangeNotifierProvider(create: (context) => TopicProvider()),
        ChangeNotifierProvider(
          create: (context) => AuthenticationProvider(firebase, fake: false),
        ),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(
            create: (context) => FirestoreProvider(firebase.firestore)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

// TODO: https://github.com/rydmike/flex_color_scheme/blob/master/example/lib/example5/main.dart
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Provider.of<SettingProvider>(context, listen: false).load();
    return Consumer<SettingProvider>(builder: (context, s, child) {
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
