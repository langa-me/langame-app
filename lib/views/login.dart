import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/helpers/toast.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/feedback_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/providers/message_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/views/buttons/facebook.dart';
import 'package:langame/views/buttons/google.dart';
import 'package:langame/views/on_boarding.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

import 'buttons/apple.dart';
import 'friends.dart';
import 'langame.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future<void>? successDialogFuture;
  bool isAuthenticating = true;

  @override
  void initState() {
    super.initState();
    var cap = Provider.of<CrashAnalyticsProvider>(context, listen: false);
    cap.setCurrentScreen('login');
    final provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    Provider.of<FeedbackProvider>(context, listen: false).initShake();
    // Bunch of spaghetti code to check if it is a new user or already authenticated
    provider.userStream.first.then((user) async {
      cap.log('login - userStream - ${user?.writeToJson()}');
      if (user == null || successDialogFuture != null) return null;

      var cp = Provider.of<ContextProvider>(context, listen: false);
      // Once arriving on login page, if coming from a notification tap coming
      // from a terminated state (app closed, have notification in bar)
      // and the user is properly authenticated, will open directly langame view
      // otherwise it will go to setup or friends according to auth state
      var displayName =
          user.displayName.isNotEmpty ? ' as ${user.displayName}' : '';
      cp.showSuccessDialog('Connected$displayName!');
      // Kind of hack to wait for preference update // TODO shouldn't need
      await Future.delayed(Duration(seconds: 1));
      var hasDoneOnBoarding =
          Provider.of<PreferenceProvider>(context, listen: false)
              .preference
              .hasDoneOnBoarding;
      if (hasDoneOnBoarding) {
        // Probably logged-out, skip message api init
        initMessageApi(
            Provider.of<MessageProvider>(context, listen: false), cp);
      } else {
        // User previously authenticated but didn't do setup
        Future.delayed(Duration(seconds: 1), () {
          cp.pop();
          // User is not opening the app from a notification
          cp.pushReplacement(OnBoarding());
        });
      }
    });
    // TODO: fix button on/off according to state
    setState(() => isAuthenticating = false);
  }

  @override
  Widget build(BuildContext context) {
    AppSize(context);

    final ap = Provider.of<AuthenticationProvider>(context, listen: false);
    var logins = <Widget>[
      FacebookSignInButton(
          onPressed: () {
            if (isAuthenticating) return;
            showBasicSnackBar(
                context, 'Facebook authentication is coming soon!');
            // await _handleOnPressedLogin(provider.loginWithFacebook, 'Facebook');
          },
          splashColor: Theme.of(context).colorScheme.primary),
      GoogleSignInButton(
          onPressed: () async {
            if (isAuthenticating) return;
            await _handleOnPressedLogin(ap.loginWithGoogle, 'Google');
          },
          splashColor: Theme.of(context).colorScheme.primary),
      AppleSignInButton(
          onPressed: () async {
            if (isAuthenticating) return;
            if (Platform.isAndroid) {
              // Apple auth does not work on Android yet https://firebase.flutter.dev/docs/auth/social#apple
              showBasicSnackBar(
                  context, 'Apple authentication is coming soon!');
              return;
            }
            await _handleOnPressedLogin(ap.loginWithApple, 'Apple');
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
                width: AppSize.safeBlockHorizontal * 30,
                height: AppSize.safeBlockVertical * 30,
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

  Future initMessageApi(MessageProvider mp, ContextProvider cp) =>
      mp.initializeMessageApi().then((res) {
        cp.handleLangameResponse(res,
            failedMessage: res.error
                    .toString()
                    .contains('firebase_functions/unavailable')
                ? 'Could not authenticate, please check your internet connection'
                : !kReleaseMode
                    ? 'failed to initializeMessageApi ${res.error.toString()}'
                    : Provider.of<FunnyProvider>(context, listen: false)
                        .getFailingRandom(),
            onSucceed: () async {
              cp.dialogComplete();
              var messages = await mp.getInitialMessage();
              cp.handleLangameResponse(messages, onSucceed: () {
                if (messages.result != null &&
                    messages.result!.channelName != null) {
                  cp.pushReplacement(LangameView(
                      messages.result!.channelName!,
                      messages.result!.ready == null ||
                          !messages.result!.ready!));
                } else {
                  cp.pushReplacement(FriendsView());
                  // User is not opening the app from a notification
                }
              });
            },
            onFailure: () => cp.dialogComplete());
      });

  Future _handleOnPressedLogin(
      Future<LangameResponse> Function() fn, String entity) async {
    setState(() => isAuthenticating = true);
    // TODO: clean this mess
    var f = fn().timeout(const Duration(seconds: 10));
    var cp = Provider.of<ContextProvider>(context, listen: false);
    cp.showLoadingDialog(
        Provider.of<FunnyProvider>(context, listen: false).getLoadingRandom());
    f.whenComplete(() => cp.dialogComplete());
    f.then((res) {
      if (res.status == LangameStatus.succeed) {
        Provider.of<CrashAnalyticsProvider>(context, listen: false)
            .analytics
            .logSignUp(signUpMethod: entity);
      }
      cp.handleLangameResponse(
        res,
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
