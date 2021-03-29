import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/firestore_provider.dart';
import 'package:langame/views/buttons/facebook.dart';
import 'package:langame/views/buttons/google.dart';
import 'package:langame/views/setup.dart';
import 'package:provider/provider.dart';

import 'buttons/apple.dart';
import 'loaders/loader_circular.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _feedbackFormKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    AppSize(context);

    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    // print(provider.user);
    // print(FirebaseAuth.instance.currentUser?.displayName);
    var logins = <Widget>[
      FacebookSignInButton(
          onPressed: () async {
            await _handleOnPressedLogin(provider.loginWithFacebook, 'Facebook');
          },
          splashColor: Colors.green),
      GoogleSignInButton(
          onPressed: () async {
            await _handleOnPressedLogin(provider.loginWithGoogle, 'Google');
          },
          splashColor: Colors.green),
      AppleSignInButton(
          onPressed: () async {
            await _handleOnPressedLogin(provider.loginWithApple, 'Apple');
          },
          splashColor: Colors.green)
    ];
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Center(
              child: Container(
                  width: 200,
                  height: 150,
                  child: Image.asset('images/logo.png')),
            ),
          ),
          SizedBox(height: 100),
          Column(children: logins, mainAxisAlignment: MainAxisAlignment.center),
          Spacer(),
          Expanded(
            flex: 1,
            child: OutlinedButton.icon(
              style: theme.textButtonTheme.style,
              onPressed: () {
                _feedbackDialog(context, theme);
              },
              icon: Icon(Icons.favorite_border_outlined,
                  size: 24, color: theme.colorScheme.secondary),
              label: Text('Help us, send a feedback',
                  style: theme.textTheme.button),
            ),
          ),
        ],
      ),
    );
  }

  void _feedbackDialog(BuildContext context, ThemeData theme) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(children: <Widget>[
          Text('Thank you a lot!', style: theme.primaryTextTheme.headline6),
          Spacer(),
          Icon(Icons.favorite_border_outlined),
        ]),
        content: Form(
          key: _feedbackFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: _feedbackController,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              OutlinedButton.icon(
                style: theme.textButtonTheme.style,
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_feedbackFormKey.currentState != null &&
                      _feedbackFormKey.currentState!.validate()) {
                    final p =
                        Provider.of<FirestoreProvider>(context, listen: false);
                    var f = p.sendFeedback(_feedbackController.text);
                    // Quit the window without waiting for api, don't block user...
                    Navigator.of(context).pop();

                    f.then((value) {
                      // If the form is valid, display a Snackbar.
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Thank you!')));
                    }).catchError((err) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Failed to send feedback, $err')));
                    });
                  }
                },
                icon: Icon(Icons.send_outlined,
                    size: 18, color: theme.colorScheme.secondary),
                label: Text('Send', style: theme.textTheme.button),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _handleOnPressedLogin(
      Future<LangameResponse> Function() fn, String entity) async {
    var f = fn();
    Dialogs.showLoadingDialog(context, _keyLoader);
    f.then((res) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      res.handle(
        context,
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Setup()),
        ),
        'failed to login to $entity, ${res.errorMessage}',
      );
    }).timeout(const Duration(seconds: 5));
  }
}
