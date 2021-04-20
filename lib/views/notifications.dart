import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/models/notification.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/views/buttons/popup_menu.dart';
import 'package:provider/provider.dart';

import 'images/image.dart';
import 'langame.dart';

class NotificationsView extends StatefulWidget {
  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  void initState() {
    super.initState();
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .analytics
        .setCurrentScreen(screenName: 'notifications');
  }

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
          return GroupedListView<LangameNotification, String>(
            elements: p.notifications,
            groupBy: (n) => '${n.channelName!};${n.topics!.join(",")}',
            groupSeparatorBuilder: (String groupByValue) =>
                _buildTextDivider(groupByValue.split(';')[1]),
            itemBuilder: (c, i) {
              return _buildNotificationCard(i, p, theme);
            },
            // TODO
            // itemComparator: (item1, item2) => item1['name'].compareTo(item2['name']), // optional
          );
        },
      ),
    );
  }

  Widget _buildTextDivider(String text) => Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.black12,
              height: 10,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: Colors.black12,
            ),
            child: Center(
                child: Text(
              text,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            )),
          ),
          Expanded(
            child: Container(
              color: Colors.black12,
              height: 10,
            ),
          ),
        ],
      );

  Widget _buildNotificationCard(
      LangameNotification n, AuthenticationProvider p, ThemeData theme) {
    // if (i > p.notifications.length) {
    //   // TODO: fix (when spamming dismiss)
    //   return Scaffold();
    // }

    return FutureBuilder<LangameResponse<lg.User>>(
        future: p.getLangameUser(n.senderUid),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.result != null &&
              n.topics != null) {
            return Dismissible(
              // Show a red background as the item is swiped away.
              background:
                  Container(color: Theme.of(context).colorScheme.secondary),
              key: Key(n.id!),
              onDismissed: (direction) async {
                var res = await p.deleteNotification(n.channelName!);
                res.thenShowSnackBar(
                  context: context,
                  succeedMessage: 'Notification deleted!',
                  failedMessage:
                      Provider.of<FunnyProvider>(context, listen: false)
                          .getFailingRandom(),
                  // onSucceed: () => setState(() {}),
                );
              },
              child: Card(
                child: ListTile(
                  leading: buildCroppedRoundedNetworkImage(
                      snapshot.data!.result!.photoUrl),
                  title: Text(snapshot.data!.result!.displayName),
                  subtitle: Text(n.ready == null || !n.ready!
                      ? 'is ready to play ${n.topics}'
                      : n.topics!.join(',')),
                  // tileColor: Color.lerp(p.notifications[i].relation.level.toColor(),
                  //     theme.colorScheme.primary, 0.5), // TODO
                  onTap: () {
                    // TODO: delete notification
                    p.deleteNotification(n.channelName!);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LangameView(
                            n.channelName!, n.ready == null || !n.ready!),
                      ),
                    );
                  },
                ),
              ),
            );
          }
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
        builder: (context) =>
            LangameView(n!.channelName!, n.ready == null || !n.ready!),
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
