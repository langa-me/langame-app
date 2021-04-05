import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/notification.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/firestore_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/providers/local_storage_provider.dart';
import 'package:langame/views/buttons/facebook.dart';
import 'package:langame/views/buttons/google.dart';
import 'package:langame/views/setup.dart';
import 'package:provider/provider.dart';

import 'buttons/apple.dart';
import 'friends.dart';
import 'langame.dart';
import 'loaders/dialogs.dart';
import 'notifications.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _feedbackFormKey = GlobalKey<FormState>(debugLabel: '_feedbackFormKey');
  final _feedbackController = TextEditingController();
  final GlobalKey<State> _keyLoader =
      GlobalKey<State>(debugLabel: '_keyLoader');
  final GlobalKey<State> _keySuccess =
      GlobalKey<State>(debugLabel: '_keySuccess');
  Future<void>? successDialogFuture;

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

    // Bunch of spaghetti code to check if it is a new user or already authenticated
    provider.userStream.first.then((user) {
      if (user == null || successDialogFuture != null) return null;

      var hasDoneSetup =
          Provider.of<LocalStorageProvider>(context, listen: false)
              .hasDoneSetup;
      // Once arriving on login page, if coming from a notification tap coming
      // from a terminated state (app closed, have notification in bar)
      // and the user is properly authenticated, will open directly langame view
      // otherwise it will go to setup or friends according to auth state
      successDialogFuture = Dialogs.showSuccessDialog(
          context, _keySuccess, 'Connected as ${user.displayName}!');
      if (hasDoneSetup) {
        var ap = Provider.of<AuthenticationProvider>(context, listen: false);
        ap.initializeMessageApi(onBackgroundOrForegroundOpened).then((res) {
          res.thenShowSnackBar(
              context,
              () {
                Navigator.of(_keySuccess.currentContext ?? context,
                        rootNavigator: true)
                    .pop();
                successDialogFuture = null;
                ap.messageApi.getInitialMessage().then((n) {
                  // TODO: doesn't work ? n = null
                  Fluttertoast.showToast(
                      msg: 'opening notification ${n?.toJson()}');
                  if (n != null) {
                    if (n is LangameNotificationPlay) {
                      Navigator.pushReplacement(
                        context, // opened the terminated app from a notification
                        MaterialPageRoute(
                          builder: (context) =>
                              LangameView(n.senderUid, n.topic, 'Who?', true),
                        ),
                      );
                    } else if (n is LangameNotificationReadyToPlay) {
                      // Received a message "I am ready!"
                      Navigator.pushReplacement(
                        context, // opened the terminated app from a notification
                        MaterialPageRoute(
                          builder: (context) => LangameView(
                              n.senderUid, n.topic, n.question, false),
                        ),
                      );
                    }
                  } else {
                    // User is not opening the app from a notification
                    Navigator.pushReplacement(
                      context, // If the already logged has already done the setup
                      MaterialPageRoute(builder: (context) => FriendsView()),
                    );
                  }
                });
              },
              !kReleaseMode
                  ? 'failed to initializeMessageApi ${res.error.toString()}'
                  : Provider.of<FunnyProvider>(context, listen: false)
                      .getFailingRandom(),
              onFailure: () {
                Navigator.of(_keySuccess.currentContext ?? context,
                        rootNavigator: true)
                    .pop();
              });
        });
      } else {
        // User previously authenticated but didn't do setup
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(_keySuccess.currentContext ?? context,
                  rootNavigator: true)
              .pop();
          successDialogFuture = null;
          // User is not opening the app from a notification
          Navigator.pushReplacement(
            context, // If the already logged has already done the setup
            MaterialPageRoute(builder: (context) => Setup()),
          );
        });
      }
    });
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
    var f = fn().timeout(const Duration(seconds: 5));
    Dialogs.showLoadingDialog(context, _keyLoader);
    f.then((res) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      res.thenShowSnackBar(
        context,
        () => {},
        kReleaseMode
            ? 'failed to login to $entity, ${res.error.toString()}'
            : Provider.of<FunnyProvider>(context, listen: false)
                .getFailingRandom(),
      );
    });
  }
}
