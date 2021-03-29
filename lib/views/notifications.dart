import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/models/notification.dart';
import 'package:langame/models/user.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

import 'image.dart';
import 'langame.dart';

class NotificationsView extends StatefulWidget {
  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
          title: Text('Notifications'),
          backgroundColor: theme.colorScheme.primary),
      body: Consumer<AuthenticationProvider>(
        builder: (BuildContext context, p, c) {
          return ListView.builder(
            itemCount: p.notifications.length,
            itemBuilder: (c, i) {
              return _buildNotificationCard(i, p, theme);
            },
          );
        },
      ),
    );
  }

  Widget _buildNotificationCard(
      int i, AuthenticationProvider p, ThemeData theme) {
    // if (i > p.notifications.length) {
    //   // TODO: fix (when spamming dismiss)
    //   return Scaffold();
    // }

    return FutureBuilder<LangameUser?>(
        future: p.getLangameUser(p.notifications[i].senderUid),
        builder: (BuildContext context, AsyncSnapshot<LangameUser?> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            var hasTopic = (p.notifications[i] is LangameNotificationPlay);
            return Dismissible(
              // Show a red background as the item is swiped away.
              background: Container(color: Colors.red),
              key: Key(p.notifications[i].id),
              onDismissed: (direction) {
                if (i > p.notifications.length) return; // Already deleted?
                p.deleteNotification(p.notifications[i].id).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('successfully deleted')));
                }).catchError((err) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('failed to delete, $err')));
                });
              },
              child: Card(
                child: ListTile(
                  leading:
                      buildCroppedRoundedNetworkImage(snapshot.data?.photoUrl),
                  title: Text(snapshot.data!.displayName!),
                  subtitle: Text(hasTopic
                      ? (p.notifications[i] as LangameNotificationPlay).topic
                      : 'No topic?'),
                  // tileColor: Color.lerp(p.notifications[i].relation.level.toColor(),
                  //     theme.colorScheme.primary, 0.5), // TODO
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LangameView(p.notifications[i])),
                    );
                  },
                ),
              ),
            );
          }
          if (kReleaseMode)
            print('failed to get user ${p.notifications[i].senderUid}');
          return SizedBox.shrink();
        });
  }
}
