import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/views/buttons/popup_menu.dart';
import 'package:langame/views/texts/texts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'colors/colors.dart';
import 'login.dart';

class SettingsView extends StatefulWidget {
  _SettingsState createState() => _SettingsState();
}

// The content of the HomePage below is not relevant for using FlexColorScheme
// based application theming. The critical parts are in the above MaterialApp
// theme definitions. The HomePage just contains UI to visually show what the
// defined example looks like in an application and with commonly used Widgets.
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
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: isLightThenBlack(context), //change your color here
        ),
        backgroundColor: Colors.transparent,
        actions: [
          buildPopupMenuWithHelpAndFeedback(context),
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            TextDivider('Style'),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Consumer<PreferenceProvider>(builder: (context, s, child) {
                return FlexThemeModeSwitch(
                  title: Text('Theme'),
                  padding: EdgeInsets.all(5),
                  themeMode: ThemeMode.values[s.preference.themeIndex],
                  onThemeModeChanged: s.setTheme,
                  flexSchemeData: flexSchemeData,
                );
              }),
            ),
            TextDivider('General'),
            ListTile(
              onTap: () {
                final snackBar = SnackBar(content: Text('Coming soon!'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              leading: Icon(Icons.account_circle_outlined),
              title: Text('Profile'),
            ),
            ListTile(
              onTap: () {
                final snackBar = SnackBar(content: Text('Coming soon!'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              leading: Icon(Icons.notifications_outlined),
              title: Text('Notifications'),
            ),
            ListTile(
              onTap: () {
                final snackBar = SnackBar(content: Text('Coming soon!'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              leading: Icon(Icons.self_improvement_outlined),
              title: Text('Digital Wellbeing'),
            ),
            ListTile(
              onTap: () {
                var cp = Provider.of<ContextProvider>(context, listen: false);
                // Only safe in dev mode yet
                if (kReleaseMode) {
                  cp.showSnackBar('Coming soon!');
                  return;
                }
                cp.showCustomDialog([
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
                        style: Theme.of(context).textTheme.headline6!.merge(
                              TextStyle(color: Colors.white),
                            ),
                      ),
                      OutlinedButton.icon(
                          style:
                              OutlinedButton.styleFrom(primary: Colors.white),
                          onPressed: () {
                            cp.dialogComplete();
                            _delete();
                          },
                          icon: Icon(Icons.delete_forever_outlined),
                          label: Text('Delete my account'))
                    ]),
                  )
                ], canBack: true);
              },
              leading: Icon(Icons.whatshot_outlined),
              title: Text('Delete my account and all my data'),
            ),
            ListTile(
              onTap: () async {
                var cp = Provider.of<ContextProvider>(context, listen: false);
                // Only safe in dev mode yet
                if (kReleaseMode) {
                  cp.showSnackBar('Coming soon!');
                  return;
                }
                cp.showLoadingDialog(
                    Provider.of<FunnyProvider>(context, listen: false)
                        .getLoadingRandom());
                await writeOnlyPreferenceProvider?.save();
                await Provider.of<AuthenticationProvider>(context,
                        listen: false)
                    .logout();
                await Future.delayed(Duration(seconds: 1));
                cp.dialogComplete();
                cp.pushReplacement(Login());
              },
              leading: Icon(Icons.login_outlined),
              title: Text('Log out'),
            ),
            TextDivider('Experimental features'),
            Consumer<PreferenceProvider>(
              builder: (context, p, child) => ListTile(
                onTap: () =>
                    p.setShakeToFeedback(!p.preference.shakeToFeedback),
                leading: Icon(Icons.feedback_outlined),
                title: Text('Shake-to-feedback'),
                trailing: Switch(
                    value: p.preference.shakeToFeedback,
                    onChanged: (v) =>
                        p.setShakeToFeedback(!p.preference.shakeToFeedback)),
              ),
            ),
            Consumer<PreferenceProvider>(
              builder: (context, p, child) => ListTile(
                onTap: () => p.setRecommendations(
                    !p.preference.unknownPeopleRecommendations),
                leading: Icon(Icons.recommend),
                title: Text('User recommendations'),
                trailing: Switch(
                    value: p.preference.unknownPeopleRecommendations,
                    onChanged: (v) => p.setRecommendations(
                        !p.preference.unknownPeopleRecommendations)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _delete() async {
    var cp = Provider.of<ContextProvider>(context, listen: false);
    cp.showLoadingDialog(
        Provider.of<FunnyProvider>(context, listen: false).getLoadingRandom());
    var r = await Provider.of<AuthenticationProvider>(context, listen: false)
        .delete();
    cp.handleLangameResponse(r, onSucceed: () async {
      cp.dialogComplete();
      cp.showSuccessDialog('You will miss us!');
      await Future.delayed(Duration(seconds: 2));
      cp.dialogComplete();
      cp.pushReplacement(Login());
    }, onFailure: () async {
      cp.dialogComplete();
      cp.showFailureDialog(
          'We are deeply sorry to announce that we could not execute your request, please contact support');
      await Future.delayed(Duration(seconds: 2));
      cp.dialogComplete();
    });
  }
}
