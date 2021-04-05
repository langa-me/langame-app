import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/notification.dart';
import 'package:langame/models/user.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
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
            var n = p.notifications[i];
            print(n.toJson());
            print(n is LangameNotificationReadyToPlay);
            return Dismissible(
              // Show a red background as the item is swiped away.
              background: Container(color: Colors.red),
              key: Key(n.id),
              onDismissed: (direction) {
                if (i > p.notifications.length) return; // Already deleted?
                p.deleteNotification(n.id).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('successfully deleted')));
                }).catchError((err) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('failed to delete, $err')));
                });
                setState(() {});
              },
              child: Card(
                child: ListTile(
                  leading:
                      buildCroppedRoundedNetworkImage(snapshot.data?.photoUrl),
                  title: Text(snapshot.data!.displayName!),
                  subtitle: Text(n is LangameNotificationReadyToPlay
                      ? 'is ready to play ${n.topic}'
                      : n is LangameNotificationPlay
                          ? n.topic
                          : Provider.of<FunnyProvider>(context)
                              .getFailingRandom()),
                  // tileColor: Color.lerp(p.notifications[i].relation.level.toColor(),
                  //     theme.colorScheme.primary, 0.5), // TODO
                  onTap: () {
                    // TODO: delete notification
                    // p.deleteNotification(n.id);
                    if (n is LangameNotificationPlay) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LangameView(n.senderUid, n.topic, 'Who?', true),
                        ),
                      );
                    } else if (n is LangameNotificationReadyToPlay) {
                      // Received a message "I am ready!"
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LangameView(
                              n.senderUid, n.topic, n.question, false),
                        ),
                      );
                    }
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

/// When opened a notification with app on the background or foreground, switch to
/// LangameView, TODO: add buttons on notification "accept" "decline"
void onBackgroundOrForegroundOpened(LangameNotification n) {
  if (n is LangameNotificationPlay) {
    AppConst.navKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) => LangameView(n.senderUid, n.topic, 'Who?', true),
      ),
    );
  } else if (n is LangameNotificationReadyToPlay) {
    // Received a message "I am ready!"
    AppConst.navKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            LangameView(n.senderUid, n.topic, n.question, false),
      ),
    );
  }
}
