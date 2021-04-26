import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/helpers/toast.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/feedback_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/providers/local_storage_provider.dart';
import 'package:langame/views/buttons/facebook.dart';
import 'package:langame/views/buttons/google.dart';
import 'package:langame/views/setup.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

import 'buttons/apple.dart';
import 'dialogs/dialogs.dart';
import 'friends.dart';
import 'langame.dart';
import 'notifications.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<State> _keyLoader =
      GlobalKey<State>(debugLabel: '_keyLoader');
  final GlobalKey<State> _keySuccess =
      GlobalKey<State>(debugLabel: '_keySuccess');
  Future<void>? successDialogFuture;
  bool buttonsDisabled = true;

  @override
  void initState() {
    super.initState();
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .analytics
        .setCurrentScreen(screenName: 'login');
  }

  @override
  Widget build(BuildContext context) {
    AppSize(context);

    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    Provider.of<FeedbackProvider>(context, listen: false).initShake();

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
      successDialogFuture = LgDialogs.showSuccessDialog(
          context, _keySuccess, 'Connected as ${user.displayName}!');
      if (hasDoneSetup) {
        var ap = Provider.of<AuthenticationProvider>(context, listen: false);
        ap.initializeMessageApi(onBackgroundOrForegroundOpened).then((res) {
          res.thenShowSnackBar(
              context: context,
              failedMessage: res.error
                      .toString()
                      .contains('firebase_functions/unavailable')
                  ? 'Could not authenticate, please check your internet connection'
                  : !kReleaseMode
                      ? 'failed to initializeMessageApi ${res.error.toString()}'
                      : Provider.of<FunnyProvider>(context, listen: false)
                          .getFailingRandom(),
              onSucceed: () {
                Navigator.of(_keySuccess.currentContext ?? context,
                        rootNavigator: true)
                    .pop();
                successDialogFuture = null;
                ap.messageApi.getInitialMessage().then((n) {
                  if (n != null && n.channelName != null) {
                    Navigator.pushReplacement(
                      context, // opened the terminated app from a notification
                      MaterialPageRoute(
                        builder: (context) => LangameView(
                            n.channelName!, n.ready == null || !n.ready!),
                      ),
                    );
                  } else {
                    // User is not opening the app from a notification
                    Navigator.pushReplacement(
                      context, // If the already logged has already done the setup
                      MaterialPageRoute(builder: (context) => FriendsView()),
                    );
                  }
                });
              },
              onFailure: () => Navigator.of(
                      _keySuccess.currentContext ?? context,
                      rootNavigator: true)
                  .pop());
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
    if (provider.user == null) setState(() => buttonsDisabled = false);

    var logins = <Widget>[
      FacebookSignInButton(
          onPressed: () {
            if (buttonsDisabled) return;
            showBasicSnackBar(
                context, 'Facebook authentication is coming soon!');
            // await _handleOnPressedLogin(provider.loginWithFacebook, 'Facebook');
          },
          splashColor: Theme.of(context).colorScheme.primary),
      GoogleSignInButton(
          onPressed: () async {
            if (buttonsDisabled) return;
            await _handleOnPressedLogin(provider.loginWithGoogle, 'Google');
          },
          splashColor: Theme.of(context).colorScheme.primary),
      AppleSignInButton(
          onPressed: () {
            if (buttonsDisabled) return;
            showBasicSnackBar(context, 'Apple authentication is coming soon!');
            // await _handleOnPressedLogin(provider.loginWithApple, 'Apple');
          },
          splashColor: Theme.of(context).colorScheme.primary)
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
                child: Image.asset('images/logo-colourless.png',
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white),
              ),
            ),
          ),
          SizedBox(height: AppSize.safeBlockVertical * 10),
          Column(children: logins, mainAxisAlignment: MainAxisAlignment.center),
          Spacer(),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (c, s) => Text(
                s.hasData && s.data != null
                    ? '${s.data!.appName}-${s.data!.version}'
                    : '',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption),
          ),
        ],
      ),
    );
  }

  Future _handleOnPressedLogin(
      Future<LangameResponse> Function() fn, String entity) async {
    // TODO: clean this mess
    var f = fn().timeout(const Duration(seconds: 5));
    LgDialogs.showLoadingDialog(context, _keyLoader,
        Provider.of<FunnyProvider>(context, listen: false).getLoadingRandom());
    f.then((res) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      if (res.status == LangameStatus.succeed) {
        Provider.of<CrashAnalyticsProvider>(context, listen: false)
            .analytics
            .logSignUp(signUpMethod: entity);
      }
      res.thenShowSnackBar(
        context: context,
        failedMessage: res.error
                .toString()
                .contains('network_error') // TODO: hack
            ? 'Could not authenticate, please check your internet connection'
            : !kReleaseMode
                ? 'failed to login to $entity, ${res.error.toString()}'
                : Provider.of<FunnyProvider>(context, listen: false)
                    .getFailingRandom(),
      );
    });
  }
}
