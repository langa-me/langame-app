import 'package:flutter/material.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/firestore_provider.dart';
import 'package:langame/views/buttons/facebook.dart';
import 'package:langame/views/buttons/google.dart';
import 'package:provider/provider.dart';

import 'buttons/apple.dart';
import 'friends.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _feedbackFormKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
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
                    p.sendFeedback(_feedbackController.text).then((value) {
                      Navigator.of(context).pop();
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
      Future<LoginResponse> Function() fn, String entity) async {
    var res = await fn();

    switch (res.status) {
      case LoginStatus.cancelled:
        break;
      case LoginStatus.failed:
        final msg = 'failed to login to $entity, ${res.errorMessage}';
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
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        break;
      case LoginStatus.succeed:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FriendsView()),
        );
        break;
    }
  }
}
