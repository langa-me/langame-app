import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:langame/models/type_login.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/views/random_temporary.dart';
import 'package:langame/views/setup.dart';
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
            if (await provider.loginWithFacebook()) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => RandomTemporary()),
              );
            } else {
              final snackBar = SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text('failed to login to Facebook'),
                action: SnackBarAction(
                  label: 'dismiss',
                  onPressed: () {},
                ),
              );

              // Find the Scaffold in the widget tree and use
              // it to show a SnackBar.
              Scaffold.of(context).showSnackBar(snackBar);
            }
          },
          padding: EdgeInsets.all(0.0),
          child: Image.asset(TypeLogo.facebook, height: loginButtonHeight),
          height: loginButtonHeight)
    ];
    if (Platform.isAndroid) {
      // Android-specific code
      logins.add(FlatButton(
          onPressed: () async {
            if (await provider.loginWithGoogle()) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => RandomTemporary()),
              );
            } else {
              final snackBar = SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text('failed to login to Google'),
                action: SnackBarAction(
                  label: 'dismiss',
                  onPressed: () {},
                ),
              );

              // Find the Scaffold in the widget tree and use
              // it to show a SnackBar.
              Scaffold.of(context).showSnackBar(snackBar);
            }
          },
          padding: EdgeInsets.all(0.0),
          child: Image.asset(TypeLogo.google, height: loginButtonHeight),
          height: loginButtonHeight));
    } else if (Platform.isIOS) {
      // iOS-specific code
      logins.add(FlatButton(
          onPressed: () async {
            if (await provider.loginWithApple()) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => RandomTemporary()),
              );
            } else {
              final snackBar = SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text('failed to login to Apple'),
                action: SnackBarAction(
                  label: 'dismiss',
                  onPressed: () {},
                ),
              );

              // Find the Scaffold in the widget tree and use
              // it to show a SnackBar.
              Scaffold.of(context).showSnackBar(snackBar);
            }
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
        body: FutureBuilder<FirebaseApp>(
            future: Firebase.initializeApp(),
            builder:
                (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Center(
                        child: Container(
                            width: 200,
                            height: 150,
                            child: SvgPicture.asset('images/chat-flat.svg')),
                      ),
                    ),
                    Row(
                        children: logins,
                        mainAxisAlignment: MainAxisAlignment.center),
                    kReleaseMode
                        ? Scaffold()
                        : Column(children: [
                            ElevatedButton(
                              child: Text('Setup', style: ts),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Setup()),
                                );
                              },
                            ),
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
                );
              } else if (snapshot.hasError) {
                children = <Widget>[
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ];
              } else {
                children = <Widget>[
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  )
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: children,
                ),
              );
            }));
    // body: Column(
    //   children: <Widget>[
    //     Padding(
    //       padding: const EdgeInsets.only(top: 60.0),
    //       child: Center(
    //         child: Container(
    //             width: 200,
    //             height: 150,
    //             child: SvgPicture.asset('images/chat-flat.svg')),
    //       ),
    //     ),
    //     Row(children: logins, mainAxisAlignment: MainAxisAlignment.center),
    //     AppConst.debug
    //         ? IconButton(
    //             icon: Icon(Icons.android),
    //             onPressed: () {
    //               Navigator.pushReplacement(
    //                 context,
    //                 MaterialPageRoute(
    //                     builder: (context) => RandomTemporary()),
    //               );
    //             },
    //           )
    //         : null,
    //   ],
    // ),
    // );
  }
}
