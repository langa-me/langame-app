import 'package:after_layout/after_layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/helpers/widget.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/physical_langame_provider.dart';
import 'package:langame/providers/tag_provider.dart';
import 'package:langame/views/buttons/button.dart';
import 'package:langame/views/topics/topic_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import 'colors/colors.dart';

class PhysicalLangamePageView extends StatefulWidget {
  PhysicalLangamePageView();

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
    'it': {'code': "it-IT", 'flag': '🇮🇹'},
    'ja': {'code': "ja-JP", 'flag': '🇯🇵'},
    'ko': {'code': "ko-KR", 'flag': '🇰🇷'},
    'pt': {'code': "pt-BR", 'flag': '🇧🇷'},
    'ru': {'code': "ru-RU", 'flag': '🇷🇺'},
    'zh-CN': {'code': "zh-CN", 'flag': '🇨🇳'},
  };

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
    final tts = FlutterTts();

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
      children: [
        Container(
            height: AppSize.safeBlockVertical * 20,
            child: TopicSearchWidget(
              onTopicSelected: (topic) {
                if (tp.selectedTopics.length >= 3) {
                  Provider.of<ContextProvider>(context, listen: false)
                      .showSnackBar('Three topics at most is allowed');
                  return;
                }
                tp.addToSelectedTopic(topic);
              },
            )),
        Expanded(
          child: Wrap(
            spacing: 2,
            runSpacing: 2,
            children: tp.selectedTopics
                .map((e) => LangameButton(FontAwesomeIcons.times,
                    layer: 1,
                    text: e,
                    onPressed: () => tp.removeFromSelectedTopic(e)))
                .toList(),
          ),
        ),
        plp.memes.length != 0
            ? Stack(children: [
                plp.memes.length > 1
                    ? Row(
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
                      )
                    : SizedBox.shrink(),
                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: LangameButton(
                          FontAwesomeIcons.headphonesAlt,
                          disableForFewMs: 2000,
                          onPressed: () async {
                            tts.stop();
                            var memeText = getMeme(plp);
                            await tts.setLanguage(
                                _languages[_languageSelected]!['code']!);
                            tts.speak(memeText);
                          },
                        ))),
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
                                onChanged: (e) {
                                  setState(
                                      () => _languageSelected = e as String);
                                },
                                value: _languageSelected,
                                items: (plp.memes[plp.currentMeme].translated
                                            .keys
                                            .toList() +
                                        ['us'])
                                    .map((v) {
                                  return DropdownMenuItem(
                                      value: v,
                                      child: Text(_languages[v]!['flag']!));
                                }).toList())))
                    : SizedBox.shrink(),
              ])
            : SizedBox.shrink(),
        plp.memes.length == 0
            ? Image.asset('images/logo-colourless.png',
                height: AppSize.safeBlockVertical * 40)
            : Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(12),
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Text(
                    getMeme(plp),
                    textAlign: TextAlign.center,
                    style: (AppSize.isLargeWidth
                            ? Theme.of(context).textTheme.headline4
                            : Theme.of(context).textTheme.headline5)!
                        .merge(TextStyle(
                            color:
                                getBlackAndWhite(context, 0, reverse: false))),
                  ),
                ),
              ),
        Padding(
          padding: EdgeInsets.all(30),
          child: Stack(alignment: Alignment.center, children: [
            // web is shit (mail only)
            !kIsWeb && plp.memes.length > 0
                ? Align(
                    alignment: Alignment.bottomLeft,
                    child: LangameButton(
                      FontAwesomeIcons.shareAlt,
                      onPressed: () => Share.share(
                          plp.memes[plp.currentMeme].content +
                              '\n' +
                              'Generated by ${AppConst.mainUrl}',
                          subject:
                              '${plp.memes[plp.currentMeme].content.substring(0, 10)}...'),
                    ),
                  )
                : SizedBox.shrink(),

            Align(
              alignment: Alignment.center,
              child: LangameButton(
                  ap.user!.credits == 0
                      ? FontAwesomeIcons.stopCircle
                      : FontAwesomeIcons.syncAlt,
                  disableForFewMs: 10000,
                  onPressed: ap.user!.credits > 0
                      ? () {
                          _getMemes = plp
                              .getMemes(
                                  topics: tp.selectedTopics.toList(),
                                  quantity: 3)
                              .then((ok) {
                            if (ok.result != null && ok.result!) return ok;
                            final cp = Provider.of<ContextProvider>(context,
                                listen: false);
                            cp.showFailureDialog(null);
                            Future.delayed(Duration(seconds: 3),
                                () => cp.dialogComplete());
                            return ok;
                          });
                          setState(() {});
                          _getMemes!.whenComplete(
                              () => setState(() => _getMemes = null));
                        }
                      : null),
            ),
          ]),
        ),
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
