import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/helpers/future.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/langame/protobuf/langame.pbenum.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/feedback_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
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
import 'main_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  Future<void>? successDialogFuture;
  bool isAuthenticating = true;
  TextEditingController _hackControllerPassword = TextEditingController();
  bool _isVersionCheckOk = false;

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
      // Bunch of spaghetti code to check if it is a new user or already authenticated
      ap.userStream.first.then((user) async {
        // 10 seconds
        await waitUntil(() => _isVersionCheckOk == true, maxIterations: 10000);
        if (user.after == null || successDialogFuture != null) {
          return null;
        }
        setState(() => isAuthenticating = true);

        if (user.after!.disabled) {
          cp.showFailureDialog(
              'Unfortunately, your account has been disabled, please contact customer support');
          await Future.delayed(Duration(seconds: 2));
          cp.dialogComplete();
          return;
        }
        // Once arriving on login page, if coming from a notification tap coming
        // from a terminated state (app closed, have notification in bar)
        // and the user is properly authenticated, will open directly langame view
        // otherwise it will go to setup or friends according to auth state
        cp.showSuccessDialog(
            'Connected${user.after!.tag.isNotEmpty ? ' as ' : ''}${user.after!.tag}!');

        // TODO: ultra hack to wait for pref update
        await Future.delayed(Duration(milliseconds: 100));
        var pp = Provider.of<PreferenceProvider>(context, listen: false);
        await waitUntil(() => pp.preference != null);
        // TODO: should probably quit if fail to initialize pref
        if (pp.preference != null && pp.preference!.hasDoneOnBoarding) {
          // Probably logged-out, skip message api init
          var mp = Provider.of<MessageProvider>(context, listen: false);
          await waitUntil(() => mp.isReady == true, maxIterations: 10000)
              .catchError((_) =>
                  // ignore: invalid_return_type_for_catch_error
                  Provider.of<ContextProvider>(context, listen: false)
                      .showFailureDialog(null));
          // Just a check that we didn't open notification / DL
          if (cp.route == LangameRoute.LoginView)
            cp.pushReplacement(MainView());
        } else {
          // User previously authenticated but didn't do setup
          // User is not opening the app from a notification
          cp.pushReplacement(OnBoarding());
        }
      });
      // HACK TODO
      await Future.delayed(Duration(milliseconds: 100));
      cp.showLoadingDialog();
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
                      canLaunch(url!).then((e) {
                        if (e) launch(url);
                      }).catchError((e) {
                        cp.showFailureDialog(
                            'An error has occurred, please update your application manually');
                      });
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
        setState(() {
          isAuthenticating = false;
          _isVersionCheckOk = false;
        });
        return;
      } else {
        setState(() {
          _isVersionCheckOk = true;
        });
      }
      if (cp.route == LangameRoute.LoginView)
        setState(() => isAuthenticating = false);
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
