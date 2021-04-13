import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/notification.dart';
import 'package:langame/models/user.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/views/popup_menu.dart';
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
        backgroundColor: theme.colorScheme.primary,
        actions: [
          buildPopupMenuWithHelpAndFeedback(),
        ],
      ),
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

    return FutureBuilder<LangameResponse<LangameUser>>(
        future: p.getLangameUser(p.notifications[i].senderUid),
        builder: (BuildContext context, snapshot) {
          var n = p.notifications[i];
          print(n.toJson());
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.result != null &&
              n.topics != null) {
            return Dismissible(
              // Show a red background as the item is swiped away.
              background: Container(color: Colors.red),
              key: Key(n.id!),
              onDismissed: (direction) async {
                if (i > p.notifications.length) return; // Already deleted?
                var res = await p.deleteNotification(n.id!);
                res.thenShowToast(
                    'Notification deleted!',
                    Provider.of<FunnyProvider>(context, listen: false)
                        .getFailingRandom(),
                    onSucceed: setState);
              },
              child: Card(
                child: ListTile(
                  leading: buildCroppedRoundedNetworkImage(
                      snapshot.data!.result!.photoUrl),
                  title: Text(snapshot.data!.result!.displayName!),
                  subtitle: Text(n.ready == null || !n.ready!
                      ? 'is ready to play ${n.topics}'
                      : n.topics!.join(',')),
                  // tileColor: Color.lerp(p.notifications[i].relation.level.toColor(),
                  //     theme.colorScheme.primary, 0.5), // TODO
                  onTap: () {
                    // TODO: delete notification
                    p.deleteNotification(n.id!);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            LangameView(n, n.ready == null || !n.ready!),
                      ),
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

/// When opened a notification with app on the background or foreground, switch to
/// LangameView, TODO: add buttons on notification "accept" "decline"
void onBackgroundOrForegroundOpened(LangameNotification? n) {
  // TODO: should delete notification then?
  if (n?.channelName != null) {
    AppConst.navKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) => LangameView(n!, n.ready == null || !n.ready!),
      ),
    );
  } else {
    // Fluttertoast.showToast(
    //     msg: '',
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
  }
}
