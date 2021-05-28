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
import 'package:langame/providers/langame_provider.dart';
import 'package:langame/providers/message_provider.dart';
import 'package:langame/views/buttons/popup_menu.dart';
import 'package:langame/views/texts/texts.dart';
import 'package:provider/provider.dart';

import 'colors/colors.dart';
import 'images/image.dart';
import 'langame.dart';

class RunningLangamesView extends StatefulWidget {
  @override
  _RunningLangamesViewState createState() => _RunningLangamesViewState();
}

class _RunningLangamesViewState extends State<RunningLangamesView> {
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
          color: isLightThenDark(context), //change your color here
        ),
        title: Text('Notifications'),
        backgroundColor: Colors.transparent,
        actions: [
          buildPopupMenuWithHelpAndFeedback(context),
        ],
      ),
      body: Consumer<LangameProvider>(
        builder: (BuildContext context, p, c) {
          if (p.runningLangames.length == 0) {
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
          var langames = p.runningLangames.values.toList();
          return ListView.separated(
            itemBuilder: (_, int i) =>
                _buildNotificationCard(langames[i]),
            itemCount: langames.length,
            separatorBuilder: (_, int i) => TextDivider(langames[i].topics.join(',')),
          );
        },
      ),
    );
  }

  Widget _buildNotificationCard(lg.Langame l) {
    var cp = Provider.of<ContextProvider>(context, listen: false);
    var ap = Provider.of<AuthenticationProvider>(context, listen: false);
    return FutureBuilder<LangameResponse<List<lg.User>>>(
        future: ap.getLangameUsers(l.players.map((e) => e.userId).toList()),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.result != null) {
            return Card(
              child: ListTile(
                title: Row(
                    children: snapshot.data!.result!
                        .map((e) => buildCroppedRoundedNetworkImage(e.photoUrl))
                        .toList()),
                onTap: () =>
                    cp.pushReplacement(LangameView(l.channelName, false)),
              ),
            );
          }
          return SizedBox.shrink();
        });
  }
}
