import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/helpers/random.dart';
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
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import 'colors/colors.dart';

// This is a list of texts to display when the user was being recorded but did not speak clearly enough or the speech could not be turned into text
final _couldNotHear = [
  'We did not hear you 😕',
  'We could not understand you 🤔',
  'We could not parse you 😟',
  'Sorry, what was that? 🤨',
  'Sorry, I didn\'t catch that 🤨',
  'what was that? 🤨',
  'I didn\'t catch that 😕',
  'I didn\'t get that 🤨',
  'Could you repeat please? 🤨',
  'Could you repeat it please? 🤨',
  'Can you say that again? 🤨',
  'Could you say that again? 🤨',
  'Can you say that again, please? 🤨',
];

// This is a list of texts to display when the user gives a feedback, it is a grateful message to thank him
final _gratitudeMessages = [
  'Thank you for your valuable feedback 😃!',
  'Wow, we really appreciate that we got your feedback and we will do better 😇!',
  'Have a great day, the system should be improved by now!',
  'Thank you for your feedback, we will improve the system soon!',
  'Thank you for improving the AI behind Langame 😍!',
  'Thank you, the system will be more efficient soon!',
  'Thank you for your help 😌!',
  'Thank you for the support, the system will improve soon!',
  'The system can be improved by thanks to your contribution 👍!',
  'Thank you so much for the helpful feedback 😃!',
];

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
                      disableForFewMs: 2000,
                      onPressed: () {
                        plp.previous();
                        setState(() {
                          _languageSelected = 'us';
                        });
                      },
                    ),
                    LangameButton(
                      FontAwesomeIcons.arrowAltCircleRight,
                      disableForFewMs: 2000,
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
                            child: LangameButton(
                              FontAwesomeIcons.headphonesAlt,
                              disableForFewMs: 2000,
                              onPressed: () async {
                                final tts = FlutterTts();
                                tts.stop();
                                var memeText = getMeme(plp);
                                await tts.setLanguage(
                                    _languages[_languageSelected]!['code']!);
                                tts.speak(memeText);
                              },
                            )))
                    : SizedBox.shrink(),
                plp.memes.length > 0 &&
                        plp.memes[plp.currentMeme].translated.isNotEmpty
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: DropdownButton(
                                dropdownColor:
                                    getBlackAndWhite(context, 1, reverse: true),
                                underline: SizedBox.shrink(),
                                icon: Icon(
                                  FontAwesomeIcons.arrowDown,
                                  color: getBlackAndWhite(context, 1),
                                  size: AppSize.safeBlockVertical * 3,
                                ),
                                onChanged: (e) => setState(
                                    () => _languageSelected = e as String),
                                value: _languageSelected,
                                items: _languages.values.map((v) {
                                  return DropdownMenuItem(
                                      // Hack because mapping dict is annoying
                                      value: v['code']!
                                          .split('-')[1]
                                          .toLowerCase(),
                                      child: Text(v['flag']!));
                                }).toList())))
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
            ? LangameButton(
                FontAwesomeIcons.microphoneAlt,
                disableForFewMs: 5000,
                highlighted: _isRecording,
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
                    var txt = await rp.stop(metadata: {
                      'meme': getMeme(plp),
                      'context': 'face-to-face',
                      'language': _languageSelected,
                      'topics': plp.memes[plp.currentMeme].topics.map((e) => '#$e').join(' '),
                    });
                    if (txt.result == '') {
                      cp.showSnackBar(_couldNotHear.pickAny()!);
                    } else {
                      cp.showSnackBar('Recorded 😇');
                    }
                  }
                },
              )
            : SizedBox.shrink(),
        plp.memes.length > 0
            ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                LangameButton(
                  FontAwesomeIcons.solidThumbsDown,
                  disableForFewMs: 1000,
                  onPressed: () => Provider.of<FeedbackProvider>(context,
                          listen: false)
                      .sendMemeLike(plp.memes[plp.currentMeme].id, false)
                      .whenComplete(
                          () => cp.showSnackBar(_gratitudeMessages.pickAny()!)),
                ),
                LangameButton(
                  FontAwesomeIcons.solidThumbsUp,
                  disableForFewMs: 1000,
                  onPressed: () => Provider.of<FeedbackProvider>(context,
                          listen: false)
                      .sendMemeLike(plp.memes[plp.currentMeme].id, true)
                      .whenComplete(
                          () => cp.showSnackBar(_gratitudeMessages.pickAny()!)),
                ),
              ])
            : SizedBox.shrink(),
        Padding(
            padding: EdgeInsets.all(30),
            child: Stack(alignment: Alignment.center, children: [
              plp.memes.length > 0
                  ? Align(
                      alignment: Alignment.bottomLeft,
                      child: LangameButton(
                        FontAwesomeIcons.shareAlt,
                        onPressed: () => Share.share(
                            plp.memes[plp.currentMeme].content +
                                '\n' +
                                'Straight from ${AppConst.mainUrl}',
                            subject:
                                '${plp.memes[plp.currentMeme].content.substring(0, 10)}...'),
                      ),
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
                            color: ap.user?.credits == 0
                                ? Colors.red
                                : getBlackAndWhite(context, 0))
                      ]))),
              Align(
                  alignment: Alignment.center,
                  child: LangameButton(
                      ap.user!.credits == 0
                          ? FontAwesomeIcons.stopCircle
                          : FontAwesomeIcons.syncAlt,
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

  String getMeme(PhysicalLangameProvider plp) {
    var memeText = plp.memes[plp.currentMeme].content;
    if (_languageSelected != 'us') {
      memeText = plp.memes[plp.currentMeme].translated[_languageSelected]!;
    }
    return memeText;
  }
}
