import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/langame_provider.dart';
import 'package:langame/views/buttons/button.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:universal_platform/universal_platform.dart';
import 'colors/colors.dart';
import 'langames/langame_audio.dart';
import 'langames/langame_text.dart';

class LangameListView extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<LangameListView> {
  @override
  void initState() {
    super.initState();
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('langame_list');
  }

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<LangameProvider>(context);
    // TODO: fucking inefficient
    var langames = p.langames.values.toList();
    langames.sort((a, b) => b.date.toDateTime().compareTo(a.date.toDateTime()));
    if (UniversalPlatform.isWeb) {
      // Web does support audio yet
      langames.retainWhere((e) => e.isText);
    }
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: isLightThenDark(context, reverse: true),
        resizeToAvoidBottomInset: false,
        body: p.langames.length == 0
            ? _noLangame()
            : ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (_, int i) => langames[i].isText
                    ? _buildTextCard(langames[i])
                    : _buildAudioCard(langames[i]),
                itemCount: langames.length,
                separatorBuilder: (_, int i) => Divider(),
              ),
      ),
    );
  }

  Widget _noLangame() => Center(
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
            Text(
                'After participating to a Langame, you will see it here',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption),
          ],
        ),
      );

  Widget _buildTextCard(lg.Langame l) {
    var cp = Provider.of<ContextProvider>(context, listen: false);
    var lp = Provider.of<LangameProvider>(context, listen: false);
    return FutureBuilder<LangameResponse<List<lg.User>>>(
        future: lp.getUsers(l.channelName),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.result != null) {
            return ListTile(
              leading: Icon(
                FontAwesomeIcons.keyboard,
                color: getBlackAndWhite(context, 1, reverse: false),
              ),
              tileColor: getBlackAndWhite(context, 1, reverse: true),
              title: Text(l.topics.join(','),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption),
              subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: snapshot.data!.result!
                      .map((e) => e.hasPhotoUrl()
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(e.photoUrl),
                            )
                          : CircleAvatar(
                              child: Text(e.tag),
                            ))
                      .toList()),
              onTap: () => cp.push(
                LangameTextView(l),
              ),
            );
          }
          return SizedBox.shrink();
        });
  }

  Widget _buildAudioCard(lg.Langame l) {
    var cp = Provider.of<ContextProvider>(context, listen: false);
    var lp = Provider.of<LangameProvider>(context, listen: false);
    var ap = Provider.of<AuthenticationProvider>(context, listen: false);
    return FutureBuilder<LangameResponse<List<lg.User>>>(
        future: lp.getUsers(l.channelName),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.result != null) {
            var format = DateFormat("d/M/y HH:mm:ss");
            var d = format.format(l.date.toDateTime().toLocal());
            var s = format.format(l.started.toDateTime().toLocal());
            var startedString = l.hasStarted() ? '\n\nstarted: $s' : '';
            return ExpansionTile(
                leading: Icon(
                  FontAwesomeIcons.headphones,
                  color: getBlackAndWhite(context, 1, reverse: false),
                ),
                backgroundColor: getBlackAndWhite(context, 1, reverse: true),
                collapsedBackgroundColor:
                    getBlackAndWhite(context, 1, reverse: true),
                title: Text(l.topics.join(','),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption),
                subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: snapshot.data!.result!
                        .map((e) => e.hasPhotoUrl()
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(e.photoUrl),
                              )
                            : CircleAvatar(
                                child: Text(e.tag),
                              ))
                        .toList()),
                trailing: Tooltip(
                    child: Icon(FontAwesomeIcons.clock),
                    message: 'planned: $d$startedString'),
                expandedCrossAxisAlignment: CrossAxisAlignment.center,
                expandedAlignment: Alignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.all(12),
                      height: AppSize.safeBlockVertical * 10,
                      child: Stack(children: [
                        Align(
                            alignment: Alignment.center,
                            child: LangameButton(
                              FontAwesomeIcons.doorOpen,
                              highlighted: true,
                              text: 'join',
                              onPressed: () => cp.pushReplacement(
                                LangameAudioView(l.channelName, false),
                              ),
                            )),
                        l.initiator == ap.user?.uid
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: Icon(FontAwesomeIcons.users,
                                      color: isLightThenDark(context,
                                          reverse: false)),
                                  onPressed: () => _onOpenLangameLink(l),
                                ))
                            : SizedBox.shrink(),
                      ])),
                ]);
          }
          return SizedBox.shrink();
        });
  }

  void _onOpenLangameLink(lg.Langame l) {
    var cp = Provider.of<ContextProvider>(context, listen: false);
    cp.showCustomDialog(
      stateless: [
        ListTile(
          onTap: () => FlutterClipboard.copy('langa.me/join/${l.link}').then(
              (v) => cp.showSnackBar(
                  'langa.me/join/${l.link} copied to clipboard!')),
          tileColor: getBlackAndWhite(context, 2, reverse: true),
          title: Text('langa.me/join/${l.link}',
              style: Theme.of(context).textTheme.headline6),
          leading: IconButton(
            icon: Icon(FontAwesomeIcons.shareAlt,
                color: isLightThenDark(context, reverse: false)),
            onPressed: () => Share.share(
                'Join me on Langame for an incredible conversation on ${l.topics.join(',')}!\n' +
                    'Just open this link: langa.me/join/${l.link}\n' +
                    'If you don\'t have Langame you can join us for incredible conversations here ${AppConst.mainUrl}',
                subject:
                    'Join me on Langame for an incredible conversation on ${l.topics.join(',')}'),
          ),
          trailing: Icon(FontAwesomeIcons.copy,
              color: isLightThenDark(context, reverse: false)),
        ),
      ],
      canBack: true,
      title: Text('Share',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4),
    );
  }
}
