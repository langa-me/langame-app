import 'package:after_layout/after_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/helpers/widget.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/feedback_provider.dart';
import 'package:langame/providers/physical_langame_provider.dart';
import 'package:langame/providers/recording_provider.dart';
import 'package:langame/providers/tag_provider.dart';
import 'package:langame/views/buttons/button.dart';
import 'package:langame/views/memes/topic_search_bar.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:langame/helpers/random.dart';
import 'colors/colors.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class PhysicalLangamePageView extends StatefulWidget {
  final void Function(int, {Curve? curve}) _goToPage;
  PhysicalLangamePageView(this._goToPage);

  @override
  _State createState() => _State();
}

class _State extends State<PhysicalLangamePageView>
    with AfterLayoutMixin<PhysicalLangamePageView> {
  Future<LangameResponse<void>>? _getMemes;
  String _languageSelected = 'us';
  final _languages = {
    'us': {'code': "en-US", 'flag': '🇺🇸'},
    'de': {'code': "de-DE", 'flag': '🇩🇪'},
    'fr': {'code': "fr-FR", 'flag': '🇫🇷'},
    'es': {'code': "es-ES", 'flag': '🇪🇸'},
  };
  bool _isRecording = false;

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('physical_langame_page_view');
    postFrameCallback((_) => setState(() {}));
  }

  String getMeme(PhysicalLangameProvider plp) {
    var memeText = plp.memes[plp.currentMeme].content;
    if (_languageSelected != 'us') {
      memeText = plp.memes[plp.currentMeme].translated[_languageSelected]!;
    }
    return memeText;
  }

  @override
  Widget build(BuildContext context) {
    var plp = Provider.of<PhysicalLangameProvider>(context);
    var ap = Provider.of<AuthenticationProvider>(context);
    var tp = Provider.of<TagProvider>(context);
    var rp = Provider.of<RecordingProvider>(context);
    var cp = Provider.of<ContextProvider>(context);

    if (_getMemes != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Provider.of<ContextProvider>(context, listen: false)
                  .buildLoadingWidget())
        ],
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Stack(
          children: [
            Container(
                height: AppSize.safeBlockVertical * 20,
                child: TopicSearchWidget()),
            Positioned(
                top: 0,
                right: AppSize.safeBlockHorizontal * 5,
                child: Container(
                    width: AppSize.safeBlockHorizontal * 30,
                    child: Wrap(
                      children: tp.selectedTopics
                          .map((e) => LangameButton(FontAwesomeIcons.times,
                              layer: 1,
                              text: e,
                              onPressed: () => tp.removeFromSelectedTopic(e)))
                          .toList(),
                    ))),
          ],
        ),
        plp.memes.length != 0
            ? Stack(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LangameButton(
                      FontAwesomeIcons.arrowAltCircleLeft,
                      onPressed: () {
                        plp.previous();
                        setState(() {
                          _languageSelected = 'us';
                        });
                      },
                    ),
                    LangameButton(
                      FontAwesomeIcons.arrowAltCircleRight,
                      onPressed: () {
                        plp.next();
                        setState(() {
                          _languageSelected = 'us';
                        });
                      },
                    ),
                  ],
                ),
                plp.memes.length > 0
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: IconButton(
                                onPressed: () async {
                                  final tts = FlutterTts();
                                  tts.stop();
                                  var memeText = getMeme(plp);
                                  await tts.setLanguage(
                                      _languages[_languageSelected]!['code']!);
                                  tts.speak(memeText);
                                },
                                icon: Icon(
                                  FontAwesomeIcons.headphonesAlt,
                                  color: isLightThenDark(context),
                                ))))
                    : SizedBox.shrink(),
                plp.memes.length > 0 &&
                        plp.memes[plp.currentMeme].translated.isNotEmpty
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: DropdownButton(
                                dropdownColor: getBlackAndWhite(context, 1, reverse: true),
                                underline: SizedBox.shrink(),
                                icon: Icon(FontAwesomeIcons.arrowDown,
                                color: getBlackAndWhite(context, 1),
                                  size: AppSize.safeBlockHorizontal * 3,
                                ),
                                onChanged: (e) => setState(
                                    () => _languageSelected = e as String),
                                value: _languageSelected,
                                items: _languages.
                                    values.map((v) {
                                      return 
                                          DropdownMenuItem(
                                              // Hack because mapping dict is annoying
                                              value: v['code']!.split('-')[1].toLowerCase(),
                                              child: Text(v['flag']!));
                                    })
                                    .toList())))
                    : SizedBox.shrink(),
              ])
            : SizedBox.shrink(),

        // SizedBox(height: AppSize.safeBlockVertical * 5),
        plp.memes.length == 0
            ? Image.asset('images/logo-colourless.png',
                height: AppSize.safeBlockVertical * 20)
            : Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    getMeme(plp),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6!.merge(
                        TextStyle(
                            color: isLightThenDark(context, reverse: false))),
                  ),
                ),
              ),
        plp.memes.length > 0
            ? IconButton(
                color: _isRecording ? Colors.red : null,
                onPressed: () async {
                  setState(() {
                    _isRecording = !_isRecording;
                  });
                  if (_isRecording) {
                    var r = await rp.start();
                    if (r.status == LangameStatus.failed) {
                      cp.showFailureDialog(null);
                      Future.delayed(Duration(seconds: 2))
                          .whenComplete(() => cp.dialogComplete());
                      setState(() {
                        _isRecording = false;
                      });
                    } else if (r.status == LangameStatus.cancelled) {
                      cp.showFailureDialog(
                          'you need to allow recording audio!');
                      Future.delayed(Duration(seconds: 2))
                          .whenComplete(() => cp.dialogComplete());
                      setState(() {
                        _isRecording = false;
                      });
                    }
                  } else {
                    rp.stop(metadata: {
                      'meme': getMeme(plp),
                      'context': 'face-to-face',
                      'language': _languageSelected,
                    });
                    cp.showSnackBar('Recorded 😇');
                  }
                },
                icon: Icon(FontAwesomeIcons.microphoneAlt))
            : SizedBox.shrink(),
        plp.memes.length > 0
            ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(
                    onPressed: () =>
                        Provider.of<FeedbackProvider>(context, listen: false)
                            .sendMemeLike(plp.memes[plp.currentMeme].id, false),
                    icon: Icon(FontAwesomeIcons.solidThumbsDown,
                        color: getBlackAndWhite(context, 0))),
                IconButton(
                    onPressed: () =>
                        Provider.of<FeedbackProvider>(context, listen: false)
                            .sendMemeLike(plp.memes[plp.currentMeme].id, true),
                    icon: Icon(FontAwesomeIcons.solidThumbsUp,
                        color: getBlackAndWhite(context, 0))),
              ])
            : SizedBox.shrink(),
        Padding(
            padding: EdgeInsets.all(30),
            child: Stack(alignment: Alignment.center, children: [
              plp.memes.length > 0
                  ? Align(
                      alignment: Alignment.bottomLeft,
                      child: IconButton(
                          onPressed: () => Share.share(
                              'I got into conversations on Langame:\n' +
                                  plp.memes[plp.currentMeme].content +
                                  '\n' +
                                  'If you don\'t have Langame you can join us for incredible conversations here ${AppConst.mainUrl}',
                              subject:
                                  '${plp.memes[plp.currentMeme].content.substring(0, 10)}...'),
                          icon: Icon(
                            FontAwesomeIcons.shareAlt,
                            color: isLightThenDark(context),
                          )),
                    )
                  : SizedBox.shrink(),
              Positioned(
                  right: AppSize.safeBlockHorizontal * 5,
                  child: Tooltip(
                      message: 'You are given 5 credits a day',
                      child: Row(children: [
                        Text('${ap.user != null ? ap.user!.credits : 0}',
                            style: Theme.of(context).textTheme.caption),
                        Icon(FontAwesomeIcons.bitcoin,
                            color: ap.user!.credits == 0
                                ? Colors.red
                                : getBlackAndWhite(context, 0))
                      ]))),
              Align(
                  alignment: Alignment.center,
                  child: IconButton(
                      icon: Icon(
                          ap.user!.credits == 0
                              ? FontAwesomeIcons.stopCircle
                              : FontAwesomeIcons.syncAlt,
                          color: ap.user!.credits == 0
                              ? Colors.transparent
                              : getBlackAndWhite(context, 1)),
                      onPressed: ap.user!.credits > 0
                          ? () {
                              _getMemes = plp
                                  .getMemes(topics: tp.selectedTopics.toList())
                                  .then((ok) {
                                if (ok.result != null && ok.result!) return ok;
                                final cp = Provider.of<ContextProvider>(context,
                                    listen: false);
                                cp.showFailureDialog(
                                    'Could not find anything that you did not already see in this topics!');
                                Future.delayed(Duration(seconds: 3),
                                    () => cp.dialogComplete());
                                return ok;
                              });
                              setState(() {});
                              _getMemes!.whenComplete(
                                  () => setState(() => _getMemes = null));
                            }
                          : null)),
            ])),
      ],
    );
  }
}
