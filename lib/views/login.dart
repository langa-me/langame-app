import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/models/type_login.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/views/random_temporary.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    const loginButtonHeight = 50.0;
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var logins = <Widget>[
      FlatButton(
          onPressed: () async {
            await handleOnPressedLogin(provider.loginWithFacebook, 'Facebook');
          },
          padding: EdgeInsets.all(0.0),
          child: Image.asset(TypeLogo.facebook, height: loginButtonHeight),
          height: loginButtonHeight)
    ];
    if (Platform.isAndroid) {
      // Android-specific code
      logins.add(FlatButton(
          onPressed: () async {
            await handleOnPressedLogin(provider.loginWithGoogle, 'Google');
          },
          padding: EdgeInsets.all(0.0),
          child: Image.asset(TypeLogo.google, height: loginButtonHeight),
          height: loginButtonHeight));
    } else if (Platform.isIOS) {
      // iOS-specific code
      logins.add(FlatButton(
          onPressed: () async {
            await handleOnPressedLogin(provider.loginWithGoogle, 'Google');
          },
          padding: EdgeInsets.all(0.0),
          child: Image.asset(TypeLogo.apple, height: loginButtonHeight),
          height: loginButtonHeight));
    }
    final ThemeData theme = Theme.of(context);
    final ts = TextStyle(
        color: ThemeData.estimateBrightnessForColor(theme.primaryColorLight) ==
                Brightness.dark
            ? Colors.white
            : Colors.black);
    return Scaffold(
        body: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: Center(
            child: Container(
                width: 200, height: 150, child: Image.asset('images/logo.png')),
          ),
        ),
        Row(children: logins, mainAxisAlignment: MainAxisAlignment.center),
        kReleaseMode
            ? Scaffold()
            : Column(children: [
                // ElevatedButton(
                //   child: Text('Setup', style: ts),
                //   onPressed: () {
                //     Navigator.pushReplacement(
                //       context,
                //       MaterialPageRoute(builder: (context) => Setup()),
                //     );
                //   },
                // ),
                ElevatedButton(
                  child: Text('RandomTemporary', style: ts),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RandomTemporary()),
                    );
                  },
                ),
              ]),
      ],
    ));
  }

  Future handleOnPressedLogin(
      Future<LoginResponse> Function() fn, String entity) async {
    var res = await fn();
    print('${res.status} ${res.errorMessage}');

    switch (res.status) {
      case LoginStatus.cancelled:
        break;
      case LoginStatus.failed:
        final msg = 'failed to login to $entity, ${res.errorMessage}';
        print(msg);
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(msg),
          action: SnackBarAction(
            label: 'dismiss',
            onPressed: () {},
          ),
        );

        // Find the Scaffold in the widget tree and use
        // it to show a SnackBar.
        Scaffold.of(context).showSnackBar(snackBar);
        break;
      case LoginStatus.succeed:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RandomTemporary()),
        );
        break;
    }
  }
}
