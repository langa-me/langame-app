import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/views/buttons/popup_menu.dart';
import 'package:langame/views/hack.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'buttons/button.dart';
import 'colors/colors.dart';
import 'login.dart';
import 'profile_view.dart';

class SettingsView extends StatefulWidget {
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsView> with WidgetsBindingObserver {
  final FlexSchemeData flexSchemeData = FlexColor.schemes[FlexScheme.mandyRed]!;
  PreferenceProvider? writeOnlyPreferenceProvider;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Save on background
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      writeOnlyPreferenceProvider?.save();
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('settings');
    writeOnlyPreferenceProvider =
        Provider.of<PreferenceProvider>(context, listen: false);
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() async {
    WidgetsBinding.instance?.removeObserver(this);
    writeOnlyPreferenceProvider?.save();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cp = Provider.of<ContextProvider>(context, listen: false);
    var cap = Provider.of<CrashAnalyticsProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: isLightThenDark(context), //change your color here
        ),
        backgroundColor: Colors.transparent,
        actions: [
          buildPopupMenuWithHelpAndFeedback(context),
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12),
              child: Consumer<PreferenceProvider>(builder: (context, s, child) {
                return FlexThemeModeSwitch(
                  title: Text('Theme',
                      style: Theme.of(context).textTheme.headline6),
                  padding: EdgeInsets.all(5),
                  themeMode: ThemeMode.values[s.preference!.themeIndex],
                  onThemeModeChanged: s.setTheme,
                  flexSchemeData: flexSchemeData,
                );
              }),
            ),
            Consumer<AuthenticationProvider>(
                builder: (ctx, p, c) => p.user!.role == 'admin' ?
                        ListTile(
                            onTap: () {
                              cp.push(HackView());
                            },
                            leading: Icon(FontAwesomeIcons.dharmachakra,
                                color: isLightThenDark(context)),
                            title: Text('Hack',
                                style: Theme.of(context).textTheme.headline6),
                          )
                        : SizedBox.shrink()),
            // ListTile(
            //   onTap: () {
            //     // Only safe in dev mode yet
            //     if (kReleaseMode) {
            //       cp.showSnackBar('Coming soon!');
            //       cap.logNewFeatureClick('settings_subscription');
            //       return;
            //     }
            //     cp.push(PaymentView());
            //   },
            //   leading: Icon(Icons.subscriptions_rounded,
            //       color: isLightThenDark(context)),
            //   title: Text('Subscription',
            //       style: Theme.of(context).textTheme.headline6),
            // ),
            ListTile(
              onTap: () {
                cp.push(ProfileView());
              },
              leading: Icon(Icons.account_circle_outlined,
                  color: isLightThenDark(context)),
              title:
                  Text('Profile', style: Theme.of(context).textTheme.headline6),
            ),
            ListTile(
              onTap: () {
                cp.showSnackBar('Coming soon!');
                cap.logNewFeatureClick('settings_notifications');
              },
              leading: Icon(Icons.notifications_outlined,
                  color: isLightThenDark(context)),
              title: Text('Notifications',
                  style: Theme.of(context).textTheme.headline6),
            ),
            Consumer<PreferenceProvider>(
              builder: (context, p, child) => ListTile(
                onTap: () {
                  if (!p.preference!.userRecommendations) {
                    cp.showSnackBar(
                        'Understood! You will have recommendation in user search for example!');
                  }
                  p.setRecommendations(!p.preference!.userRecommendations);
                },
                leading: Icon(Icons.recommend, color: isLightThenDark(context)),
                title: Text('User recommendations',
                    style: Theme.of(context).textTheme.headline6),
                trailing: Switch(
                    value: p.preference!.userRecommendations,
                    onChanged: (v) {
                      if (!p.preference!.userRecommendations) {
                        cp.showSnackBar(
                            'Understood! You will have recommendation in user search for example!');
                      }
                      p.setRecommendations(!p.preference!.userRecommendations);
                    }),
              ),
            ),
            Divider(),
            ListTile(
              onTap: () {
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
                        'Are you sure to leave us?',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      LangameButton(Icons.delete_forever_outlined,
                          onPressed: () {
                        cp.dialogComplete();
                        _delete();
                      }, text: 'Delete my account', layer: 2)
                    ]),
                  )
                ], canBack: true);
              },
              leading: Icon(Icons.whatshot_outlined,
                  color: isLightThenDark(context)),
              title: Text('Delete my account and all my data',
                  style: Theme.of(context).textTheme.headline6),
            ),
            // ListTile(
            //   onTap: () async {
            //     final ap =
            //         Provider.of<AuthenticationProvider>(context, listen: false);
            //     cp.showLoadingDialog();
            //     await writeOnlyPreferenceProvider?.save();
            //     await ap.logout();
            //     await Future.delayed(Duration(seconds: 1));
            //     cp.dialogComplete();
            //     cp.pushReplacement(LoginView());
            //   },
            //   leading:
            //       Icon(Icons.login_outlined, color: isLightThenDark(context)),
            //   title:
            //       Text('Log out', style: Theme.of(context).textTheme.headline6),
            // ),
          ],
        ),
      ),
    );
  }

  void _delete() async {
    var cp = Provider.of<ContextProvider>(context, listen: false);
    cp.showLoadingDialog();
    var r = await Provider.of<AuthenticationProvider>(context, listen: false)
        .delete();
    cp.handleLangameResponse(r, onSucceed: () async {
      cp.dialogComplete();
      cp.showSuccessDialog('You will miss us!');
      await Future.delayed(Duration(seconds: 2));
      cp.dialogComplete();
      cp.pushReplacement(LoginView());
    }, onFailure: () async {
      cp.dialogComplete();
      cp.showFailureDialog(
          'We are deeply sorry to announce that we could not execute your request, please contact support');
      await Future.delayed(Duration(seconds: 2));
      cp.dialogComplete();
    });
  }
}
