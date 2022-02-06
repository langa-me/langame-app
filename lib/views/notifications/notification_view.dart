import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/message_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/views/app_bars/app_bars.dart';
import 'package:langame/views/buttons/button.dart';
import 'package:langame/views/colors/colors.dart';
import 'package:langame/views/dividers/text_divider.dart';
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
    var mp = Provider.of<MessageProvider>(context);

    return Scaffold(
      appBar: buildAppBar(context, 'Notification settings'),
      body: buildNotificationPreferences(context, pp, mp),
    );
  }
}

buildNotificationPreferences(
        BuildContext context, PreferenceProvider pp, MessageProvider mp) =>
    ListView(
      physics: BouncingScrollPhysics(),
      children: [
        TextDivider(
          'Messages',
          tooltip: 'All messages that are not invitations to a Langame',
          dividerThickness: 0,
        ),
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          tileColor: getBlackAndWhite(context, 1, reverse: true),
          leading: Icon(
            FontAwesomeIcons.bell,
            color: getBlackAndWhite(context, 0),
          ),
          onTap: () {
            pp.preference.notification.message.push =
                !pp.preference.notification.message.push;
            pp.refresh();
          },
          title: Text('Push', style: Theme.of(context).textTheme.headline6),
          trailing: Switch(
              value: pp.preference.notification.message.push,
              onChanged: (_) {
                pp.preference.notification.message.push =
                    !pp.preference.notification.message.push;
                pp.refresh();
              }),
        ),
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          tileColor: getBlackAndWhite(context, 1, reverse: true),
          leading: Icon(
            FontAwesomeIcons.envelope,
            color: getBlackAndWhite(context, 0),
          ),
          onTap: () {
            pp.preference.notification.message.email =
                !pp.preference.notification.message.email;
            pp.refresh();
          },
          title: Text('Email', style: Theme.of(context).textTheme.headline6),
          trailing: Switch(
              value: pp.preference.notification.message.email,
              onChanged: (_) {
                pp.preference.notification.message.email =
                    !pp.preference.notification.message.email;
                pp.refresh();
              }),
        ),
        TextDivider(
          'Invitations',
          tooltip: 'All messages that are invitations to a Langame',
          dividerThickness: 0,
        ),
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          tileColor: getBlackAndWhite(context, 1, reverse: true),
          leading: Icon(
            FontAwesomeIcons.bell,
            color: getBlackAndWhite(context, 0),
          ),
          onTap: () {
            pp.preference.notification.invite.push =
                !pp.preference.notification.invite.push;
            pp.refresh();
          },
          title: Text('Push', style: Theme.of(context).textTheme.headline6),
          trailing: Switch(
              value: pp.preference.notification.invite.push,
              onChanged: (_) {
                pp.preference.notification.invite.push =
                    !pp.preference.notification.invite.push;
                pp.refresh();
              }),
        ),
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          tileColor: getBlackAndWhite(context, 1, reverse: true),
          leading: Icon(
            FontAwesomeIcons.envelope,
            color: getBlackAndWhite(context, 0),
          ),
          onTap: () {
            pp.preference.notification.invite.email =
                !pp.preference.notification.invite.email;
            pp.refresh();
          },
          title: Text('Email', style: Theme.of(context).textTheme.headline6),
          trailing: Switch(
              value: pp.preference.notification.invite.email,
              onChanged: (_) {
                pp.preference.notification.invite.email =
                    !pp.preference.notification.invite.email;
                pp.refresh();
              }),
        ),
        TextDivider(
          'New versions',
          tooltip: 'New Langame versions',
          dividerThickness: 0,
        ),
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          tileColor: getBlackAndWhite(context, 1, reverse: true),
          leading: Icon(
            FontAwesomeIcons.bell,
            color: getBlackAndWhite(context, 0),
          ),
          onTap: () {
            pp.preference.notification.newVersion.push =
                !pp.preference.notification.newVersion.push;
            pp.refresh();
          },
          title: Text('Push', style: Theme.of(context).textTheme.headline6),
          trailing: Switch(
              value: pp.preference.notification.newVersion.push,
              onChanged: (_) {
                pp.preference.notification.newVersion.push =
                    !pp.preference.notification.newVersion.push;
                pp.refresh();
              }),
        ),
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          tileColor: getBlackAndWhite(context, 1, reverse: true),
          leading: Icon(
            FontAwesomeIcons.envelope,
            color: getBlackAndWhite(context, 0),
          ),
          onTap: () {
            pp.preference.notification.newVersion.email =
                !pp.preference.notification.newVersion.email;
            pp.refresh();
          },
          title: Text('Email', style: Theme.of(context).textTheme.headline6),
          trailing: Switch(
              value: pp.preference.notification.newVersion.email,
              onChanged: (_) {
                pp.preference.notification.newVersion.email =
                    !pp.preference.notification.newVersion.email;
                pp.refresh();
              }),
        ),
        !mp.hasPermissions
            ? Container(
                child: LangameButton(
                  FontAwesomeIcons.check,
                  onPressed: mp.askPermissions,
                  text: 'Allow notifiations',
                  fixedSize: Size(
                    AppSize.safeBlockHorizontal * 50,
                    AppSize.safeBlockVertical * 5,
                  ),
                ),
              )
            : SizedBox.shrink()
      ],
    );
