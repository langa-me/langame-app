import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/views/app_bars/app_bars.dart';
import 'package:langame/views/colors/colors.dart';
import 'package:langame/views/texts/texts.dart';
import 'package:provider/provider.dart';

/// This is Flutter Widget that display a page to manage user notification settings
///
/// This widget is used to manage the notification settings of the user.
class NotificationSettingsView extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<NotificationSettingsView> {
  @override
  Widget build(BuildContext context) {
    var pp = Provider.of<PreferenceProvider>(context);

    return Scaffold(
      appBar: buildAppBar(context, 'Notification settings'),
      body: ListView(
        children: [
          TextDivider('Messages'),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.keyboard,
              color: getBlackAndWhite(context, 0),
            ),
            onTap: () {
              pp.preference!.notification.message.push =
                  !pp.preference!.notification.message.push;
              pp.refresh();
            },
            title: Text('Push', style: Theme.of(context).textTheme.headline6),
            trailing: Switch(
                value: pp.preference!.notification.message.push,
                onChanged: (_) {
                  pp.preference!.notification.message.push =
                      !pp.preference!.notification.message.push;
                  pp.refresh();
                }),
          ),
          TextDivider('Invitations'),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.calendar,
              color: getBlackAndWhite(context, 0),
            ),
            onTap: () {
              pp.preference!.notification.invite.push =
                  !pp.preference!.notification.invite.push;
              pp.refresh();
            },
            title: Text('Push', style: Theme.of(context).textTheme.headline6),
            trailing: Switch(
                value: pp.preference!.notification.invite.push,
                onChanged: (_) {
                  pp.preference!.notification.invite.push =
                      !pp.preference!.notification.invite.push;
                  pp.refresh();
                }),
          ),
        ],
      ),
    );
  }
}
