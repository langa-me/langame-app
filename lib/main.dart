import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
import 'package:langame/views/setting_loader.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingProvider()),
        ChangeNotifierProvider(create: (context) => TopicProvider()),
        ChangeNotifierProvider(
            create: (context) => AuthenticationProvider(
                FirebaseAuth.instance,
                FirebaseFunctions.instance,
                FirebaseFirestore.instance,
                GoogleSignIn(scopes: <String>[
                  'email',
                  'https://www.googleapis.com/auth/contacts.readonly'
                ]))),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(
            create: (context) => FirestoreProvider(FirebaseFirestore.instance)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
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
              elevatedButtonTheme: ElevatedButtonThemeData(
                  // style: ButtonStyle(
                  //     backgroundColor: MaterialStateProperty.all(Colors.red)),
                  ),
            ),
        darkTheme: FlexColorScheme.dark(
          scheme: FlexScheme.ebonyClay,
          fontFamily: AppFont.mainFont,
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          background: Colors.transparent,
        ).toTheme.copyWith(
              elevatedButtonTheme: ElevatedButtonThemeData(
                  // style: ButtonStyle(
                  //     backgroundColor: MaterialStateProperty.all(Colors.red)),
                  ),
            ),
        home: SettingLoader(),
      );
    });
  }

  @override
  void dispose() {
    Provider.of<AuthenticationProvider>(context).stopNotifications();
    super.dispose();
  }
}
