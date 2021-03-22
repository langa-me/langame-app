import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/firestore_provider.dart';
import 'package:langame/providers/profile_provider.dart';
import 'package:langame/providers/setting_provider.dart';
import 'package:langame/providers/topic_provider.dart';
import 'package:langame/views/setting_loader.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingProvider()),
        ChangeNotifierProvider(create: (context) => TopicProvider()),
        ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => FirestoreProvider()),
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
                background: Colors.transparent)
            .toTheme,
        darkTheme: FlexColorScheme.dark(
                scheme: FlexScheme.ebonyClay,
                fontFamily: AppFont.mainFont,
                visualDensity: FlexColorScheme.comfortablePlatformDensity,
                background: Colors.transparent)
            .toTheme,
        home: SettingLoader(),
      );
    });
  }
}
