import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/providers/message_provider.dart';
import 'package:langame/views/buttons/popup_menu.dart';
import 'package:provider/provider.dart';

import 'colors/colors.dart';
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
        .setCurrentScreen('notifications');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: isLightThenBlack(context), //change your color here
        ),
        title: Text('Notifications'),
        backgroundColor: Colors.transparent,
        actions: [
          buildPopupMenuWithHelpAndFeedback(context),
        ],
      ),
      body: Consumer<MessageProvider>(
        builder: (BuildContext context, p, c) {
          if (p.notifications.length == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    width: AppSize.blockSizeHorizontal * 30,
                    image: AssetImage('images/logo-colourless.png'),
                  ),
                  SizedBox(height: AppSize.safeBlockVertical * 10),
                  Text('All caught up!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4),
                  SizedBox(height: AppSize.safeBlockVertical * 5),
                  Text('Invite your friends for a great conversation',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption),
                ],
              ),
            );
          }
          return GroupedListView<lg.Notification, String>(
            elements: p.notifications,
            groupBy: (n) => '${n.channelName};${n.topics.join(",")}',
            groupSeparatorBuilder: (String groupByValue) =>
                _buildTextDivider(groupByValue.split(';')[1]),
            itemBuilder: (c, i) {
              return _buildNotificationCard(i);
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
              height: 1,
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
              height: 1,
            ),
          ),
        ],
      );

  Widget _buildNotificationCard(lg.Notification n) {
    // if (i > p.notifications.length) {
    //   // TODO: fix (when spamming dismiss)
    //   return Scaffold();
    // }
    var p = Provider.of<MessageProvider>(context, listen: false);
    return FutureBuilder<LangameResponse<lg.User>>(
        future: Provider.of<AuthenticationProvider>(context, listen: false)
            .getLangameUser(n.senderUid),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.result != null &&
              n.topics != null) {
            return Dismissible(
              // Show a red background as the item is swiped away.
              background:
                  Container(color: Theme.of(context).colorScheme.secondary),
              key: Key(n.id),
              onDismissed: (direction) async {
                var res = await p.deleteNotification(n.channelName);
                var cp = Provider.of<ContextProvider>(context, listen: false);
                cp.handleLangameResponse(
                  res,
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
                  subtitle: Text(n.ready == null || !n.ready
                      ? 'is ready to play ${n.topics}'
                      : n.topics.join(',')),
                  // tileColor: Color.lerp(p.notifications[i].relation.level.toColor(),
                  //     theme.colorScheme.primary, 0.5), // TODO
                  onTap: () {
                    // TODO: delete notification
                    p.deleteNotification(n.channelName);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LangameView(
                            n.channelName, n.ready == null || !n.ready),
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
