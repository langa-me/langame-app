import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/physical_langame_provider.dart';
import 'package:langame/providers/recording_provider.dart';
import 'package:langame/providers/tag_provider.dart';
import 'package:langame/views/colors/colors.dart';
import 'package:langame/views/recording/recording.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class RecordingPageView extends StatefulWidget {
  final void Function(int, {Curve? curve}) _goToPage;
  RecordingPageView(this._goToPage);

  @override
  _State createState() => _State();
}

class _State extends State<RecordingPageView>
    with AfterLayoutMixin<RecordingPageView> {
  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('recording_page_view');
  }

  @override
  Widget build(BuildContext context) {
    final plp = Provider.of<PhysicalLangameProvider>(context);
    final ap = Provider.of<AuthenticationProvider>(context);
    final tp = Provider.of<TagProvider>(context);
    final rp = Provider.of<RecordingProvider>(context);
    final cp = Provider.of<ContextProvider>(context);

    return rp.recordings == null || rp.recordings!.size == 0
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  width: AppSize.blockSizeHorizontal * 30,
                  image: AssetImage('images/logo-colourless.png'),
                  color: getBlackAndWhite(context, 0),
                ),
                SizedBox(height: AppSize.safeBlockVertical * 10),
                Text('No memes 😥',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4),
                SizedBox(height: AppSize.safeBlockVertical * 5),
                Text('Play a Langame & record yourself for further thinking!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption),
              ],
            ),
          )
        : ListView.separated(
            itemBuilder: (_, int i) => ListTile(
                trailing: IconButton(
                  icon: Icon(FontAwesomeIcons.shareAlt,
                      color: isLightThenDark(context, reverse: false)),
                  onPressed: () => Share.share(
                      'Question: ${rp.recordings!.docs[i].data().metadata["meme"]!}' +
                          '\nAnswer: ${rp.recordings!.docs[i].data().text}',
                      subject: 'Langame memes'),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
                tileColor: getBlackAndWhite(context, 1, reverse: true),
                onTap: () => cp.push(Recording(
                    rp.recordings!.docs[i].id, rp.recordings!.docs[i].data())),
                subtitle: Text(
                  rp.recordings!.docs[i].data().text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .merge(TextStyle(color: getBlackAndWhite(context, 0))),
                ),
                title: Text(
                  rp.recordings!.docs[i].data().metadata['meme']!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .merge(TextStyle(color: getBlackAndWhite(context, 0))),
                )),
            itemCount: rp.recordings != null ? rp.recordings!.size : 0,
            separatorBuilder: (_, int i) => Divider(),
          );
  }
}
