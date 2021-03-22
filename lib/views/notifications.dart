import 'package:flutter/material.dart';
import 'package:langame/api/extension.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/views/langame.dart';
import 'package:provider/provider.dart';

import 'image.dart';

class NotificationsView extends StatefulWidget {
  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
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
    if (i > p.notifications.length) {
      // TODO: fix (when spamming dismiss)
      return Scaffold();
    }
    return Dismissible(
      // Show a red background as the item is swiped away.
      background: Container(color: Colors.red),
      key: Key(p.notifications[i].id),
      onDismissed: (direction) {
        if (i > p.notifications.length) return; // Already deleted?
        p.deleteNotification(p.notifications[i]).then((value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('successfully deleted')));
        }).catchError((err) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('failed to delete, $err')));
        });
      },
      child: Card(
        child: ListTile(
          leading: buildCroppedRoundedNetworkImage(
              p.notifications[i].sender.photoUrl),
          title: Text(p.notifications[i].sender.displayName),
          subtitle: Text(p.notifications[i].topic),
          tileColor: Color.lerp(p.notifications[i].relation.toColor(),
              theme.colorScheme.primary, 0.5),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => LangameView(p.notifications[i])),
            );
          },
        ),
      ),
    );
  }
}
