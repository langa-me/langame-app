import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/interest_provider.dart';
import 'package:langame/providers/setting_provider.dart';
import 'package:langame/views/setting_loader.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingProvider()),
        ChangeNotifierProvider(create: (context) => InterestProvider()),
        ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
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
                visualDensity: FlexColorScheme.comfortablePlatformDensity)
            .toTheme,
        darkTheme: FlexColorScheme.dark(
                scheme: FlexScheme.ebonyClay,
                fontFamily: AppFont.mainFont,
                visualDensity: FlexColorScheme.comfortablePlatformDensity)
            .toTheme,
        home: SettingLoader(),
        builder: EasyLoading.init(),
      );
    });
  }
}
