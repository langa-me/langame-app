import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/langame/protobuf/langame.pbenum.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/dynamic_links_provider.dart';
import 'package:langame/providers/feedback_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/providers/langame_provider.dart';
import 'package:langame/providers/message_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/views/buttons/button.dart';
import 'package:langame/views/buttons/google.dart';
import 'package:langame/views/on_boarding.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';

import 'buttons/apple.dart';
import 'langame.dart';
import 'main_view.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future<void>? successDialogFuture;
  bool isAuthenticating = true;
  TextEditingController _hackControllerPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    var cap = Provider.of<CrashAnalyticsProvider>(context, listen: false);
    cap.setCurrentScreen('login');
    final ap = Provider.of<AuthenticationProvider>(context, listen: false);
    Provider.of<FeedbackProvider>(context, listen: false).init();
    var cp = Provider.of<ContextProvider>(context, listen: false);
    Connectivity().checkConnectivity().then((network) async {
      if (network == ConnectivityResult.none) {
        cap.log('I am offline', analyticsMessage: 'offline');
        // Wait until internet then
        await Connectivity().onConnectivityChanged.first;
      }
      // HACK TODO
      await Future.delayed(Duration(milliseconds: 100));
      cp.showLoadingDialog(text: 'Checking version...');
      final checkVersion = await ap.checkVersion();
      cp.dialogComplete();
      if (checkVersion.status == LangameStatus.failed) {
        cp.showCustomDialog(stateless: [
          Center(
            child: Column(children: [
              Lottie.asset(
                'animations/sad2.json',
                width: AppSize.safeBlockHorizontal * 20,
                repeat: false,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Unfortunately, something seems broken, please restart your application',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
              LangameButton(
                FontAwesomeIcons.doorOpen,
                onPressed: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                text: 'Quit',
                highlighted: true,
              )
            ]),
          )
        ]);
        return;
      }
      if (checkVersion.result !=
              FunctionResponse_VersionCheck_UpdateRequired.OK &&
          checkVersion.result !=
              FunctionResponse_VersionCheck_UpdateRequired.RETRO_COMPATIBLE) {
        cp.showCustomDialog(
          stateless: [
            UniversalPlatform.isAndroid || UniversalPlatform.isIOS
                ? LangameButton(
                    FontAwesomeIcons.externalLinkAlt,
                    text: 'Update',
                    onPressed: () async {
                      final url = UniversalPlatform.isAndroid
                          ? AppConst.googlePlayUrl
                          : UniversalPlatform.isIOS
                              ? AppConst.testFlightUrl
                              : null;
                      if (await canLaunch(url!)) {
                        await launch(url);
                      }
                    },
                    highlighted: true,
                  )
                : SizedBox.shrink()
          ],
          title: Text('You need to update your application 😓',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3),
          height: 20,
        );
        setState(() => isAuthenticating = false);
        return;
      }
      setState(() => isAuthenticating = false);

      // Bunch of spaghetti code to check if it is a new user or already authenticated
      ap.userStream.first.then((user) async {
        cap.log('login - userStream');
        if (user == null || successDialogFuture != null) {
          return null;
        }
        setState(() => isAuthenticating = true);

        if (user.disabled) {
          cp.showFailureDialog(
              'Unfortunately, your account has been disabled, please contact customer support');
          await Future.delayed(Duration(seconds: 2));
          cp.dialogComplete();
          return;
        }
        Provider.of<LangameProvider>(context, listen: false).initialize();
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
    });
  }

  @override
  Widget build(BuildContext context) {
    AppSize(context);

    final crash = Provider.of<CrashAnalyticsProvider>(context, listen: false);
    final cp = Provider.of<ContextProvider>(context, listen: false);

    var network = Provider.of<ConnectivityResult>(context);

    if (network == ConnectivityResult.none) {
      crash.log('I am offline', analyticsMessage: 'offline');
      setState(() => isAuthenticating = true);

      return Scaffold(
          body: Center(child: cp.buildLoadingWidget(text: 'Offline')));
    }
    setState(() => isAuthenticating = false);

    final ap = Provider.of<AuthenticationProvider>(context, listen: false);

    var logins = [
      GoogleSignInButton(
          onPressed: () async {
            if (isAuthenticating) return;
            await _handleOnPressedLogin(ap.loginWithGoogle, 'Google');
          },
          splashColor: Theme.of(context).colorScheme.primary),
      UniversalPlatform.isIOS
          ? AppleSignInButton(
              onPressed: () async {
                if (isAuthenticating) return;
                await _handleOnPressedLogin(ap.loginWithApple, 'Apple');
              },
              splashColor: Theme.of(context).colorScheme.primary)
          : SizedBox.shrink()
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: GestureDetector(
            onLongPress: () {
              var cp = Provider.of<ContextProvider>(context, listen: false);
              cp.showCustomDialog(stateless: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Are you a hacker 🤓?',
                          style: Theme.of(context).textTheme.headline4),
                      Divider(),
                      SizedBox(height: AppSize.safeBlockVertical * 10),
                      TextField(
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: _hackControllerPassword,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .merge(TextStyle(color: Colors.transparent)),
                        decoration: InputDecoration(
                            hintStyle: Theme.of(context).textTheme.headline6,
                            hintText: "Enter the hack password"),
                      ),
                      LangameButton(FontAwesomeIcons.code,
                          layer: 2,
                          text: 'Enter the matrix 😈',
                          border: true,
                          onPressed: () => _handleOnPressedLogin(
                              () => ap
                                  .loginWithHack(_hackControllerPassword.text),
                              'email')),
                      LangameButton(
                        FontAwesomeIcons.baby,
                        layer: 2,
                        text:
                            'Bring me back to right\nside of the force,\nmaster, please 👼',
                        border: true,
                        onPressed: cp.dialogComplete,
                      ),
                    ]),
              ], canBack: true);
            },
            child: Container(
              width: AppSize.safeBlockHorizontal * 30,
              height: AppSize.safeBlockVertical * 30,
              child: Image.asset('images/logo-colourless.png',
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white),
            ),
          )),
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
              cp.handleLangameResponse(messages, onSucceed: () async {
                await Provider.of<DynamicLinksProvider>(context, listen: false)
                    .setupAndCheckDynamicLinks();
                // Note that we ignore failures in dynamic link initialization
                if (messages.result != null) {
                  cp.pushReplacement(
                      LangameView(messages.result!.channelName, false));
                } else {
                  cp.pushReplacement(MainView());
                  // User is not opening the app from a notification
                }
              });
            },
            onFailure: () => cp.dialogComplete());
      });

  Future _handleOnPressedLogin(
      Future<LangameResponse<void>> Function() fn, String entity) async {
    setState(() => isAuthenticating = true);
    var f = fn().timeout(const Duration(seconds: 10));
    var cp = Provider.of<ContextProvider>(context, listen: false);
    cp.showLoadingDialog();
    f.whenComplete(() {
      cp.dialogComplete();
      setState(() => isAuthenticating = false);
    });
    f.then((res) {
      if (res.status == LangameStatus.succeed) {
        Provider.of<CrashAnalyticsProvider>(context, listen: false)
            .analytics
            .logSignUp(signUpMethod: entity);
      }
      cp.handleLangameResponse(
        res,
        failedMessage: Provider.of<FunnyProvider>(context, listen: false)
            .getFailingRandom(),
      );
    });
  }
}
