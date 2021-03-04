import 'dart:async';
import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:langame/providers/setting_provider.dart';
import 'package:langame/services/http/authentication.dart';

import 'getit.dart';
import 'models/sign_up_model.dart';
import 'models/type_login.dart';
import 'views/footer_login.dart';
import 'views/login_fresh.dart';
import 'views/login_fresh_reset_password.dart';
import 'views/login_fresh_sign_up.dart';
import 'views/login_user_password.dart';

void main() {
  setup();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final provider = getIt<SettingProvider>();

  @override
  Widget build(BuildContext context) {
    // Define which predefined FlexScheme to use.
    // Go ahead and try some other ones too.
    const FlexScheme usedFlexScheme = FlexScheme.mandyRed;
    return MaterialApp(
        title: 'Langame',
        theme: FlexColorScheme.light(
          scheme: usedFlexScheme,
          // Use comfortable on desktops instead of compact, devices use default.
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
        ).toTheme,
        darkTheme: FlexColorScheme.dark(
          scheme: usedFlexScheme,
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
        ).toTheme,
        // Use the above dark or light theme, based on active themeMode
        // value light/dark/system.
        themeMode: provider.theme,
        home: Scaffold(body: buildLoginFresh()),
        builder: EasyLoading.init());
  }

  LoginFresh buildLoginFresh() {
    List<LoginFreshTypeLoginModel> listLogin = [
      LoginFreshTypeLoginModel(
          callFunction: (BuildContext _buildContext) async {
            final result = await signInWithFacebook();
            print(result);
            // develop what they want the facebook to do when the user clicks
          },
          logo: TypeLogo.facebook),
      LoginFreshTypeLoginModel(
          callFunction: (BuildContext _buildContext) {
            Navigator.of(_buildContext).push(MaterialPageRoute(
              builder: (_buildContext) => widgetLoginFreshUserAndPassword(),
            ));
          },
          logo: TypeLogo.userPassword),
    ];

    // Apple sign in off on Android https://firebase.flutter.dev/docs/auth/social#apple
    // Google sign in off on Apple (use js client, need setup apple sign in mess)
    // https://pub.dev/packages/google_sign_in#ios-integration
    if (Platform.isAndroid) {
      listLogin.insert(
          1,
          LoginFreshTypeLoginModel(
              callFunction: (BuildContext _buildContext) {
                print("cat grid");

                // signInWithGoogle();
                // develop what they want the Google to do when the user clicks
              },
              logo: TypeLogo.google));
    } else if (Platform.isIOS) {
      listLogin.insert(
          1,
          LoginFreshTypeLoginModel(
              callFunction: (BuildContext _buildContext) {
                signInWithApple();
                // develop what they want the Apple to do when the user clicks
              },
              logo: TypeLogo.apple));
    }

    return LoginFresh(
        pathLogo: 'images/chat-flat.svg',
        isExploreApp: true,
        functionExploreApp: () {
          // develop what they want the ExploreApp to do when the user clicks
        },
        isFooter: true,
        widgetFooter: this.widgetFooter(),
        typeLoginModel: listLogin,
        isSignUp: true,
        widgetSignUp: this.widgetLoginFreshSignUp());
  }

  Widget widgetLoginFreshUserAndPassword() {
    return LoginFreshUserAndPassword(
      callLogin: (BuildContext _context, Function isRequest, String user,
          String password) {
        isRequest(true);

        Future.delayed(Duration(seconds: 2), () {
          isRequest(false);
        });
      },
      logo: './images/logo_head.png',
      isFooter: true,
      widgetFooter: this.widgetFooter(),
      isResetPassword: true,
      widgetResetPassword: this.widgetResetPassword(),
      isSignUp: true,
      signUp: this.widgetLoginFreshSignUp(),
    );
  }

  Widget widgetResetPassword() {
    return LoginFreshResetPassword(
      logo: 'images/logo_head.png',
      funResetPassword:
          (BuildContext _context, Function isRequest, String email) {
        isRequest(true);

        Future.delayed(Duration(seconds: 2), () {
          print('-------------- function call----------------');
          print(email);
          print('--------------   end call   ----------------');
          isRequest(false);
        });
      },
      isFooter: true,
      widgetFooter: this.widgetFooter(),
    );
  }

  Widget widgetFooter() {
    return LoginFreshFooter(
      logo: 'images/logo_footer.png',
      text: 'Power by',
      funFooterLogin: () {
        // develop what they want the footer to do when the user clicks
      },
    );
  }

  Widget widgetLoginFreshSignUp() {
    return LoginFreshSignUp(
        isFooter: true,
        widgetFooter: this.widgetFooter(),
        logo: 'images/logo_head.png',
        funSignUp: (BuildContext _context, Function isRequest,
            SignUpModel signUpModel) {
          isRequest(true);

          print(signUpModel.email);
          print(signUpModel.password);
          print(signUpModel.repeatPassword);
          print(signUpModel.surname);
          print(signUpModel.name);

          isRequest(false);
        });
  }
}
