import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/views/buttons/popup_menu.dart';
import 'package:langame/views/langames/langames_schedule_settings_view.dart';
import 'package:langame/views/notifications/notification_view.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'buttons/button.dart';
import 'colors/colors.dart';
import 'goals/goals_list_tiles.dart';
import 'users/self_profile_page.dart';

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
    var pp = Provider.of<PreferenceProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: getBlackAndWhite(context, 0), //change your color here
        ),
        backgroundColor: Colors.transparent,
        actions: [
          buildPopupMenuWithHelpAndFeedback(context),
        ],
      ),
      body: Container(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12),
              child: FlexThemeModeSwitch(
                title:
                    Text('Theme', style: Theme.of(context).textTheme.headline6),
                padding: EdgeInsets.all(5),
                themeMode: ThemeMode.values[pp.preference.themeIndex],
                onThemeModeChanged: pp.setTheme,
                flexSchemeData: flexSchemeData,
              ),
            ),
            ListTile(
              onTap: () {
                cp.push(SelfProfilePage());
              },
              leading: Icon(FontAwesomeIcons.userCircle,
                  color: getBlackAndWhite(context, 0)),
              title:
                  Text('Profile', style: Theme.of(context).textTheme.headline6),
            ),
            ...buildGoalsListTiles(context, pp),
            ListTile(
              onTap: () {
                cp.push(NotificationSettingsView());
              },
              leading: Icon(
                Icons.notifications_outlined,
                color: getBlackAndWhite(context, 0),
              ),
              title: Text('Notifications',
                  style: Theme.of(context).textTheme.headline6),
            ),
            ListTile(
              onTap: () {
                cp.push(LangamesScheduleSettingsView());
              },
              leading: Icon(
                FontAwesomeIcons.grinTongue,
                color: getBlackAndWhite(context, 0),
              ),
              title: Text('Langames schedule',
                  style: Theme.of(context).textTheme.headline6),
            ),
            Divider(),
            ExpansionTile(
                leading:
                    Icon(FontAwesomeIcons.skullCrossbones, color: Colors.red),
                title: Text('Danger Zone',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .merge(TextStyle(color: Colors.red))),
                children: [
                  ListTile(
                    onTap: () async {
                      final ap = Provider.of<AuthenticationProvider>(context,
                          listen: false);
                      cp.showLoadingDialog();
                      await writeOnlyPreferenceProvider?.save();
                      await ap.logout();
                      await Future.delayed(Duration(seconds: 1));
                      cp.showSuccessDialog('You will miss us! 😞');
                    },
                    leading: Icon(Icons.login_outlined,
                        color: getBlackAndWhite(context, 0)),
                    title: Text('Log out',
                        style: Theme.of(context).textTheme.headline6),
                  ),
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
                        color: getBlackAndWhite(context, 0)),
                    title: Text('Delete my account and all my data',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                ]),
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
    }, onFailure: () async {
      cp.dialogComplete();
      cp.showFailureDialog(
          'We are deeply sorry to announce that we could not execute your request, please contact support');
      await Future.delayed(Duration(seconds: 2));
      cp.dialogComplete();
    });
  }
}
