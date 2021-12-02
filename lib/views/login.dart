import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/helpers/future.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/feedback_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/providers/message_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/views/buttons/button.dart';
import 'package:langame/views/on_boarding.dart';
import 'package:langame/views/shortcuts/simple_shortcut.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';

import 'colors/colors.dart';
import 'main_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isAuthenticating = true;
  TextEditingController _hackControllerPassword = TextEditingController();
  TextEditingController _webControllerUsername = TextEditingController();
  TextEditingController _webControllerPassword = TextEditingController();
  bool _isVersionCheckOk = false;

  @override
  void initState() {
    super.initState();
    var cap = Provider.of<CrashAnalyticsProvider>(context, listen: false);
    cap.setCurrentScreen('login');
    final ap = Provider.of<AuthenticationProvider>(context, listen: false);
    Provider.of<FeedbackProvider>(context, listen: false).init();
    var cp = Provider.of<ContextProvider>(context, listen: false);
    var mp = Provider.of<MessageProvider>(context, listen: false);

    // Load for this page
    Provider.of<FunnyProvider>(context, listen: false).getLoadingRandom();
    var pp = Provider.of<PreferenceProvider>(context, listen: false);

    Connectivity().checkConnectivity().then((network) async {
      if (network == ConnectivityResult.none) {
        cap.log('I am offline', analyticsMessage: 'offline');
        // Wait until internet then
        await Connectivity().onConnectivityChanged.first;
      }
      StreamSubscription<UserChange>? sub;
      // Bunch of spaghetti code to check if it is a new user or already authenticated
      sub = ap.userStream.listen((user) async {
        if (!this.mounted) return;
        // 10 seconds
        await waitUntil(() => _isVersionCheckOk == true, maxIterations: 10000);
        if (user.after == null) {
          return null;
        }

        if (user.after!.disabled) {
          cp.showFailureDialog(
              'Unfortunately, your account has been disabled, please contact customer support');
          await Future.delayed(Duration(seconds: 2));
          cp.dialogComplete();
          return;
        }

        await pp.preferenceStream
            .firstWhere((e) => e.userId == user.after!.uid)
            .timeout(Duration(milliseconds: 500))
            .catchError((_) => lg.UserPreference());

        sub?.cancel();
        if (pp.preference.hasDoneOnBoarding) {
          // Probably logged-out, skip message api init
          await waitUntil(() => mp.isReady == true, maxIterations: 10000)
              .catchError((_) =>
                  // ignore: invalid_return_type_for_catch_error
                  cp.showFailureDialog(null));
          // Just a check that we didn't open notification / DL
          if (cp.route == LangameRoute.LoginView)
            cp.pushReplacement(MainView());
        } else {
          cap.log('login_view:starting onboarding');
          // User previously authenticated but didn't do setup
          // User is not opening the app from a notification
          cp.pushReplacement(OnBoarding());
        }
      });
      final checkVersion = await ap.checkVersion();
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
              lg.FunctionResponse_VersionCheck_UpdateRequired.OK &&
          checkVersion.result !=
              lg.FunctionResponse_VersionCheck_UpdateRequired
                  .RETRO_COMPATIBLE) {
        cp.showCustomDialog(
          stateless: [
            LangameButton(
              FontAwesomeIcons.externalLinkAlt,
              text: 'Update',
              onPressed: () async {
                final url = UniversalPlatform.isAndroid
                    ? AppConst.googlePlayUrl
                    : UniversalPlatform.isIOS
                        ? AppConst.testFlightUrl
                        : null;
                if (await canLaunch(url!)) {
                  await launch(
                    url,
                  );
                }
              },
              highlighted: true,
            )
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
        setState(() {
          isAuthenticating = false;
        });
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
          backgroundColor: getBlackAndWhite(context, 0, reverse: true),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [cp.buildLoadingWidget(text: 'Offline', last: true)]));
    }

    if (!_isVersionCheckOk) {
      return Scaffold(
          backgroundColor: getBlackAndWhite(context, 0, reverse: true),
          body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image(
              width: AppSize.blockSizeHorizontal * 30,
              image: AssetImage('images/logo-colourless.png'),
            ),
            SizedBox(height: AppSize.safeBlockVertical * 20),
            cp.buildLoadingWidget(
                text: Provider.of<FunnyProvider>(context, listen: false)
                    .getLoadingRandom(last: true),
                last: true)
          ]));
    }

    setState(() => isAuthenticating = false);

    final ap = Provider.of<AuthenticationProvider>(context, listen: false);

    var _buildButtonParent = (Widget child) => Container(
          child: child,
          padding: EdgeInsets.all(12),
        );
    var logins = [
      // We disable Google Auth on Langame Web dev, since it's internal only
      UniversalPlatform.isWeb && AppConst.isDev
          ? SizedBox.shrink()
          : _buildButtonParent(LangameButton(
              FontAwesomeIcons.google,
              fixedSize: Size(AppSize.safeBlockHorizontal * 20,
                  AppSize.safeBlockVertical * 5),
              onPressed: () async {
                if (isAuthenticating) return;
                await _handleOnPressedLogin(ap.loginWithGoogle, 'Google');
              },
              layer: 1,
            )),
      UniversalPlatform.isIOS
          ? _buildButtonParent(
              LangameButton(
                FontAwesomeIcons.apple,
                onPressed: () async {
                  if (isAuthenticating) return;
                  await _handleOnPressedLogin(ap.loginWithApple, 'Apple');
                },
                layer: 1,
                fixedSize: Size(AppSize.safeBlockHorizontal * 20,
                    AppSize.safeBlockVertical * 5),
              ),
            )
          : SizedBox.shrink()
    ];

    if (UniversalPlatform.isWeb) {
      logins.addAll([
        _buildButtonParent(LangameButton(
          FontAwesomeIcons.envelope,
          fixedSize: Size(
              AppSize.safeBlockHorizontal * 20, AppSize.safeBlockVertical * 5),
          onPressed: () async {
            if (isAuthenticating) return;
            var cp = Provider.of<ContextProvider>(context, listen: false);
            final ln = () => _handleOnPressedLogin(
                () => ap.loginWithEmail(
                      _webControllerUsername.text,
                      _webControllerPassword.text,
                    ),
                'email');
            cp.showCustomDialog(
                stateless: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextField(
                          obscureText: false,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: _webControllerUsername,
                          style: Theme.of(context).textTheme.headline6,
                          decoration: InputDecoration(
                              hintStyle: Theme.of(context).textTheme.headline6,
                              hintText: "email"),
                        ),
                        TextField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: _webControllerPassword,
                          style: Theme.of(context).textTheme.headline6,
                          decoration: InputDecoration(
                              hintStyle: Theme.of(context).textTheme.headline6,
                              hintText: "password"),
                        ),
                        SimpleShortcut(
                          bindings: {
                            const SingleActivator(LogicalKeyboardKey.enter,
                                control: true): ln,
                          },
                          child: LangameButton(
                            FontAwesomeIcons.signInAlt,
                            layer: 2,
                            highlighted: true,
                            onPressed: ln,
                          ),
                        ),
                        Text(
                          'If you don\'t have an account for Langame web beta, request one at contact@langa.me',
                          style: Theme.of(context).textTheme.caption,
                          textAlign: TextAlign.center,
                        ),
                      ]),
                ],
                canBack: true,
                title: Text('Langame Web beta - VIP only',
                    style: Theme.of(context).textTheme.headline4));
          },
          layer: 1,
        )),
        Text(
          '⚠️ Langame web is very experimental and currently used for fast internal product design and many features does not work yet ⚠️',
          style: Theme.of(context).textTheme.caption,
          textAlign: TextAlign.center,
        ),
      ]);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: GestureDetector(
            onLongPress: _onLongPressLogo,
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
          Column(
              children: logins,
              mainAxisAlignment: MainAxisAlignment.spaceBetween),
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

  void _onLongPressLogo() {
    final ap = Provider.of<AuthenticationProvider>(context, listen: false);
    var cp = Provider.of<ContextProvider>(context, listen: false);
    cp.showCustomDialog(stateless: [
      Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
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
            highlighted: true,
            onPressed: () => _handleOnPressedLogin(
                () => ap.loginWithEmail(
                    'hack@langa.me', _hackControllerPassword.text),
                'email')),
        LangameButton(
          FontAwesomeIcons.baby,
          layer: 2,
          text: 'Bring me back to right\nside of the force,\nmaster, please 👼',
          border: true,
          onPressed: cp.dialogComplete,
        ),
      ]),
    ], canBack: true);
  }

  Future _handleOnPressedLogin(
      Future<LangameResponse<void>> Function() fn, String entity) async {
    setState(() => isAuthenticating = true);
    var f = fn().timeout(const Duration(seconds: 120));
    var cp = Provider.of<ContextProvider>(context, listen: false);
    cp.showLoadingDialog();
    f.whenComplete(() {
      cp.dialogComplete();
      setState(() => isAuthenticating = false);
    });

    final res = await f;
    cp.handleLangameResponse(
      res,
      failedMessage:
          Provider.of<FunnyProvider>(context, listen: false).getFailingRandom(),
      onSucceed: () =>
          Provider.of<CrashAnalyticsProvider>(context, listen: false)
              .analytics
              .logSignUp(signUpMethod: entity),
    );
  }
}
