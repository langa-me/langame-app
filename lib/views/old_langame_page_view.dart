import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/langame_provider.dart';
import 'package:langame/views/texts/texts.dart';
import 'package:provider/provider.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:intl/intl.dart';

import 'images/image.dart';

class OldLangamePageView extends StatefulWidget {
  // ignore: unused_field
  final void Function(int, {Curve? curve}) _goToPage;
  OldLangamePageView(this._goToPage);

  @override
  _State createState() => _State();
}

class _State extends State<OldLangamePageView>
    with AfterLayoutMixin<OldLangamePageView> {
  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LangameProvider>(
        builder: (BuildContext context, p, c) {
          if (p.finishedLangames.length == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    width: AppSize.blockSizeHorizontal * 30,
                    image: AssetImage('images/logo-colourless.png'),
                  ),
                  SizedBox(height: AppSize.safeBlockVertical * 10),
                  Text('Never participated in a Langame 😢?',
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
          var langames = p.finishedLangames.values.toList();
          return ListView.separated(
            itemBuilder: (_, int i) => _buildCard(langames[i]),
            itemCount: langames.length,
            separatorBuilder: (_, int i) =>
                TextDivider(langames[i].topics.join(',')),
          );
        },
      ),
    );
  }

  Widget _buildCard(lg.Langame l) {
    var cp = Provider.of<ContextProvider>(context, listen: false);
    var ap = Provider.of<AuthenticationProvider>(context, listen: false);
    var lp = Provider.of<LangameProvider>(context, listen: false);
    var notesFuture = lp.getNotes(l.channelName);
    return FutureBuilder<LangameResponse<List<lg.User>>>(
        future: ap.getLangameUsers(l.players.map((e) => e).toList()),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.result != null) {
            var format = DateFormat("dd/MM HH:mm");
            var s = format.format(l.started.toDateTime().toLocal());
            var lengthInMinutes = l.started
                .toDateTime()
                .difference(l.done.toDateTime().toLocal())
                .inMinutes;

            return Card(
              child: ListTile(
                title: Row(
                    children: snapshot.data!.result!
                        .map((e) => buildCroppedRoundedNetworkImage(e.photoUrl))
                        .toList()),
                subtitle: Text(l.topics.join(',')),
                trailing: Text('started: $s\n\nlength: $lengthInMinutes'),
                onTap: () => cp.showCustomDialog([
                  FutureBuilder(future: notesFuture, builder: _buildNotes),
                ]),
              ),
            );
          }
          return SizedBox.shrink();
        });
  }

  Widget _buildNotes(
      BuildContext c, AsyncSnapshot<LangameResponse<List<lg.Note>>> s) {
    if (s.data != null && s.data!.result != null) {
      var format = DateFormat("dd/MM HH:mm");
      return ListView(
          children: s.data!.result!
              .map((e) => ListTile(
                    trailing: Text(format.format(e.createdAt.toDateTime())),
                    title: Text(e.content),
                  ))
              .toList());
    }
    return Provider.of<ContextProvider>(context, listen: false).buildLoadingWidget();
  }
}
