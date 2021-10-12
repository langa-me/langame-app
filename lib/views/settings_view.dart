import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/views/buttons/popup_menu.dart';
import 'package:langame/views/hack.dart';
import 'package:langame/views/integrations/readwise/readwise_settings.dart';
import 'package:langame/views/language/language_settings.dart';
import 'package:langame/views/notifications/notification_view.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;

import 'buttons/button.dart';
import 'colors/colors.dart';
import 'feature_preview/beta.dart';
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
    var pp = Provider.of<PreferenceProvider>(context);
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
              child: FlexThemeModeSwitch(
                title:
                    Text('Theme', style: Theme.of(context).textTheme.headline6),
                padding: EdgeInsets.all(5),
                themeMode: ThemeMode.values[pp.preference!.themeIndex],
                onThemeModeChanged: pp.setTheme,
                flexSchemeData: flexSchemeData,
              ),
            ),
            Consumer<AuthenticationProvider>(
                builder: (ctx, p, c) => p.user?.role == 'admin'
                    ? ListTile(
                        onTap: () {
                          cp.push(HackView());
                        },
                        leading: Icon(FontAwesomeIcons.dharmachakra,
                            color: isLightThenDark(context)),
                        title: Text('Hack',
                            style: Theme.of(context).textTheme.headline6),
                      )
                    : SizedBox.shrink()),
            ListTile(
              onTap: () {
                cp.push(ProfileView());
              },
              leading: Icon(FontAwesomeIcons.userCircle,
                  color: getBlackAndWhite(context, 0)),
              title:
                  Text('Profile', style: Theme.of(context).textTheme.headline6),
            ),
            ListTile(
              onTap: () {
                cp.push(LanguageSettingsView());
              },
              leading: Icon(FontAwesomeIcons.language,
                  color: isLightThenDark(context)),
              title: Text('Language',
                  style: Theme.of(context).textTheme.headline6),
            ),
            ListTile(
              onTap: () {
                cp.push(NotificationSettingsView());
              },
              leading: Beta(
                  Icon(Icons.notifications_outlined,
                      color: isLightThenDark(context)),
                  type: BetaType.NEW),
              title: Text('Notification',
                  style: Theme.of(context).textTheme.headline6),
            ),
            ExpansionTile(
                leading: Beta(
                    Icon(FontAwesomeIcons.brain,
                        color: isLightThenDark(context)),
                    type: BetaType.PREVIEW),
                title: Text('User recommendations',
                    style: Theme.of(context).textTheme.headline6),
                children: [
                  ListTile(
                    leading: Beta(
                      Icon(FontAwesomeIcons.cartPlus,
                          color: getBlackAndWhite(context, 0)),
                      type: BetaType.SOON,
                    ),
                    title: Text('New relationships',
                        style: Theme.of(context).textTheme.headline6),
                    trailing: Switch(value: false, onChanged: (_) {}),
                  ),
                  ListTile(
                    onTap: () => pp.setRecommendations(
                        pp.preference!.userRecommendations ==
                                lg.UserPreference_RecommendationType.COMPOUND
                            ? lg.UserPreference_RecommendationType.NONE
                            : lg.UserPreference_RecommendationType.COMPOUND),
                    leading: Icon(FontAwesomeIcons.layerGroup,
                        color: getBlackAndWhite(context, 0)),
                    title: Text('Compound relationships',
                        style: Theme.of(context).textTheme.headline6),
                    trailing: Switch(
                        value: pp.preference!.userRecommendations ==
                            lg.UserPreference_RecommendationType.COMPOUND,
                        onChanged: (v) => pp.setRecommendations(v
                            ? lg.UserPreference_RecommendationType.COMPOUND
                            : lg.UserPreference_RecommendationType.NONE)),
                  ),
                ]),
            ExpansionTile(
                onExpansionChanged: (_) {
                  cap.logNewFeatureClick('settings_integration');
                },
                leading: Beta(
                    Icon(FontAwesomeIcons.brain,
                        color: isLightThenDark(context)),
                    type: BetaType.SOON),
                title: Text('Integration',
                    style: Theme.of(context).textTheme.headline6),
                children: !AppConst.isDev
                    ? []
                    : [
                        ListTile(
                          onTap: () {
                            if (!AppConst.isDev) return;
                            cp.push(ReadwiseView());
                          },
                          leading: Icon(FontAwesomeIcons.bookOpen,
                              color: isLightThenDark(context)),
                          title: Text('Readwise',
                              style: Theme.of(context).textTheme.headline6),
                        )
                      ]),
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
                        color: isLightThenDark(context)),
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
                        color: isLightThenDark(context)),
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
