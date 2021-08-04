import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
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
import 'package:langame/views/memes/topic_search_bar.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:langame/helpers/random.dart';
import 'colors/colors.dart';

class PhysicalLangamePageView extends StatefulWidget {
  final void Function(int, {Curve? curve}) _goToPage;
  PhysicalLangamePageView(this._goToPage);

  @override
  _State createState() => _State();
}

class _State extends State<PhysicalLangamePageView>
    with AfterLayoutMixin<PhysicalLangamePageView> {
  Future<LangameResponse<void>>? _getMemes;
  List<bool> _languageSelected = [true, false, false, false];
  static const List<String> _languages = ['us', 'de', 'fr', 'es'];

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
                          _languageSelected = [true, false, false, false];
                        });
                      },
                    ),
                    LangameButton(
                      FontAwesomeIcons.arrowAltCircleRight,
                      onPressed: () {
                        plp.next();
                        setState(() {
                          _languageSelected = [true, false, false, false];
                        });
                      },
                    ),
                  ],
                ),
              ])
            : SizedBox.shrink(),
        plp.memes.length > 0 && plp.memes[plp.currentMeme]['translated'] != null
            ? ToggleButtons(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                fillColor: Theme.of(context).colorScheme.secondary,
                selectedBorderColor: getBlackAndWhite(context, 0),
                children: [
                  Text('🇺🇸'),
                  Text('🇩🇪'),
                  Text('🇫🇷'),
                  Text('🇪🇸'),
                ],
                onPressed: (int index) {
                  var n = _languageSelected.map((e) => false).toList();
                  n[index] = true;
                  setState(() {
                    _languageSelected = n;
                  });
                },
                isSelected: _languageSelected,
              )
            : SizedBox.shrink(),
        SizedBox(height: AppSize.safeBlockVertical * 5),
        plp.memes.length == 0
            ? Image.asset('images/logo-colourless.png',
                height: AppSize.safeBlockVertical * 20)
            : Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    _languageSelected[0]
                        ? plp.memes[plp.currentMeme]['content']
                        : plp.memes[plp.currentMeme]['translated'][_languages[
                            _languageSelected.indexWhere((e) => e == true)]],
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6!.merge(
                        TextStyle(
                            color: isLightThenDark(context, reverse: false))),
                  ),
                ),
              ),
        Padding(
            padding: EdgeInsets.all(30),
            child: Stack(alignment: Alignment.center, children: [
              plp.memes.length > 0
                  ? Align(
                      alignment: Alignment.bottomLeft,
                      child: IconButton(
                          onPressed: () => Share.share(
                              'I got into conversations on Langame:\n' +
                                  plp.memes[plp.currentMeme]['content'] +
                                  '\n' +
                                  'If you don\'t have Langame you can join us for incredible conversations here ${AppConst.mainUrl}',
                              subject:
                                  '${plp.memes[plp.currentMeme]['content'].substring(0, 10)}...'),
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
                          color: ap.user!.credits == 0 ? Colors.transparent : getBlackAndWhite(context, 1)),
                      onPressed: ap.user!.credits > 0
                          ? () {
                              _getMemes = plp.getMemes(
                                  topics: tp.selectedTopics.toList());
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
