import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:clipboard/clipboard.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/helpers/random.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/dynamic_links_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/providers/langame_provider.dart';
import 'package:langame/providers/new_langame_provider.dart';
import 'package:langame/providers/tag_provider.dart';
import 'package:langame/views/buttons/button.dart';
import 'package:langame/views/langames/langame_audio.dart';
import 'package:langame/views/langames/langame_text.dart';
import 'package:langame/views/topics/topic_search_bar.dart';
import 'package:langame/views/langame_list_view.dart';
import 'package:langame/views/search_page_view.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:universal_platform/universal_platform.dart';

import 'colors/colors.dart';
import 'users/user_tile.dart';

class NewLangamePageView extends StatefulWidget {
  final void Function(int, {Curve? curve}) _goToPage;
  NewLangamePageView(this._goToPage);

  @override
  _SendLangameState createState() => _SendLangameState();
}

class _SendLangameState extends State<NewLangamePageView>
    with AfterLayoutMixin<NewLangamePageView> {
  _SendLangameState();

  List<bool> _textAudioToggles = [true, false];
  bool get isText => _textAudioToggles[0];
  bool get isAudio => _textAudioToggles[1];

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('new_langame_page_view');
  }

  @override
  Widget build(BuildContext context) {
    var nlp = Provider.of<NewLangameProvider>(context);
    var cp = Provider.of<ContextProvider>(context);
    var tp = Provider.of<TagProvider>(context);
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                  height: AppSize.safeBlockVertical * 20,
                  child: TopicSearchWidget(onTopicSelected: (topic) {
                    if (tp.selectedTopics.length >= 3) {
                          Provider.of<ContextProvider>(context, listen: false)
                              .showSnackBar('Three topics at most is allowed');
                          return;
                        }
                        tp.addToSelectedTopic(topic);
                  })),
              Positioned(
                  top: 0,
                  right: AppSize.safeBlockHorizontal * 5,
                  child: Container(
                      width:
                          AppSize.safeBlockHorizontal * (isPortrait ? 40 : 20),
                      child: Wrap(
                        children: tp.selectedTopics
                            .map((e) => LangameButton(FontAwesomeIcons.times,
                                // fixedSize: Size(AppSize.safeBlockHorizontal * 20, AppSize.safeBlockVertical * 5),
                                layer: 1,
                                text: e,
                                onPressed: () => tp.removeFromSelectedTopic(e)))
                            .toList(),
                      ))),
            ],
          ),
          Container(
            width: AppSize.safeBlockHorizontal * 40,
            child: Consumer<NewLangameProvider>(
              builder: (c, nlp, child) => ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: nlp.shoppingList.isEmpty
                    ? [
                        LangameButton(
                          FontAwesomeIcons.userPlus,
                          text: 'Invite',
                          onPressed: () =>
                              cp.push(SearchPageView(widget._goToPage)),
                          layer: 1,
                          border: false,
                        ),
                        isText
                            ? SizedBox.shrink()
                            : Text(
                                'Your friends can also join later using a link for example',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.caption!),
                      ]
                    : nlp.shoppingList
                        .map(
                          (e) => buildUserTile(
                            context,
                            nlp,
                            e,
                            widget._goToPage,
                          ),
                        )
                        .toList(),
              ),
            ),
          ),
          UniversalPlatform.isWeb ? SizedBox.shrink() : ToggleButtons(
              renderBorder: false,
              children: [
                LangameButton(
                  FontAwesomeIcons.keyboard,
                  beta: true,
                  onPressed: () =>
                      setState(() => _textAudioToggles = [true, false]),
                  text: 'Text',
                  layer: 1,
                  highlighted: _textAudioToggles[0],
                ),
                LangameButton(
                  FontAwesomeIcons.microphone,
                  beta: true,
                  onPressed: () =>
                      setState(() => _textAudioToggles = [false, true]),
                  text: 'Audio',
                  layer: 1,
                  highlighted: _textAudioToggles[1],
                ),
              ],
              isSelected: _textAudioToggles),
          isAudio
              ? DateTimePicker(
                  timeFieldWidth: AppSize.safeBlockHorizontal * 50,
                  type: DateTimePickerType.dateTimeSeparate,
                  dateMask: 'd MMM, yyyy',
                  initialValue: DateTime.now().toString(),
                  firstDate: DateTime(2021),
                  lastDate: DateTime(2022),
                  icon: Icon(Icons.event),
                  dateLabelText: 'Date',
                  style: Theme.of(context).textTheme.headline6,
                  timeLabelText: 'Hour',
                  onChanged: (val) => nlp.setSelectedDate(DateTime.parse(val)),
                )
              : SizedBox.shrink(),
          LangameButton(
            FontAwesomeIcons.grinTongue,
            onPressed: () => onPressedNewLangame(cp, nlp),
            text: 'Go',
            highlighted: true,
            layer: 1,
            padding: EdgeInsets.symmetric(
                vertical: 10, horizontal: AppSize.safeBlockHorizontal * 20),
          ),
        ]);
  }

  void onPressedNewLangame(ContextProvider cp, NewLangameProvider nlp) async {
    var ap = Provider.of<AuthenticationProvider>(context, listen: false);
    var tp = Provider.of<TagProvider>(context, listen: false);

    if (ap.user!.credits == 0) {
      cp.showSnackBar(
          'You don\'t have any credits left 😥, wait until tomorrow to get some again!');
      return;
    }
    var topics = tp.selectedTopics;
    if (tp.selectedTopics.isEmpty) {
      topics = [tp.availableTopics.pickAny()!].toSet();
    }

    if (nlp.shoppingList.length == 0) {
      cp.showSnackBar('You can\'t play Langame alone 😉' +
          (nlp.shoppingList.length == 0 ? ', please add a friend!' : ''));
      return;
    }

    if (isText && nlp.shoppingList.length > 1) {
      cp.showSnackBar('Only one-to-one Langames are supported yet!');
      return;
    }

    var lp = Provider.of<LangameProvider>(context, listen: false);
    var fp = Provider.of<FunnyProvider>(context, listen: false);
    cp.showLoadingDialog();
    var createLangame = await lp.createLangame(
      nlp.shoppingList,
      topics.toList(),
      nlp.selectedDate ?? DateTime.now(),
      isText: isText,
    );
    if (createLangame.error != null ||
        createLangame.result == null ||
        createLangame.result!.data() == null ||
        !createLangame.result!.data()!.hasChannelName() ||
        createLangame.result!.data()!.channelName.isEmpty) {
      cp.dialogComplete();
      var msg = '${fp.getFailingRandom()}, please retry later';
      cp.showFailureDialog(createLangame.error != null
          ? createLangame.error is LangameException
              ? (createLangame.error as LangameException).cause
              : createLangame.error.toString()
          : msg);
      await Future.delayed(Duration(seconds: 2));
      cp.dialogComplete();
      return;
    }

    var snap = createLangame.result!.data()!;
    if (isText) {
      cp.dialogComplete();
      cp.push(LangameTextView(snap));
      return;
    }

    if (kIsWeb) {
      cp.dialogComplete();
      cp.pushReplacement(LangameAudioView(snap.channelName, false));
      return;
    }

    var dlp = Provider.of<DynamicLinksProvider>(context, listen: false);
    var createDynamicLink = await dlp.createDynamicLink(snap.channelName, true);
    cp.dialogComplete();
    if (createDynamicLink.error != null) {
      cp.showFailureDialog('${fp.getFailingRandom()}, please retry later');
      await Future.delayed(Duration(seconds: 2));
      cp.dialogComplete();
      return;
    }
    // We ignore the result and do not wait
    lp.addLink(createLangame.result!.id,
        dlp.getChannelNameFromLink(createDynamicLink.result!));
    cp.showCustomDialog(
        stateless: [
          Text(
              'Copy this link and send it to people you want to meet with. '
              'Be sure to save it so you can use it later, too.',
              style: Theme.of(context).textTheme.caption),
          Divider(),
          ListTile(
            onTap: () => FlutterClipboard.copy(createDynamicLink.result!).then(
                (v) => cp.showSnackBar(
                    '${createDynamicLink.result!} copied to clipboard!')),
            tileColor: getBlackAndWhite(context, 2, reverse: true),
            title: Text(
              createDynamicLink.result!.replaceAll('https://', ''),
              style: Theme.of(context).textTheme.headline6,
            ),
            leading: IconButton(
              icon: Icon(FontAwesomeIcons.shareAlt,
                  color: isLightThenDark(context, reverse: false)),
              onPressed: () => Share.share(
                'Join my Langame to talk about ${topics.join(',')} at ${createDynamicLink.result!}',
                subject:
                    'Join my Langame to talk about ${topics.join(',')}',
              ),
            ),
            trailing: Icon(FontAwesomeIcons.copy,
                color: isLightThenDark(context, reverse: false)),
          ),
          LangameButton(
            FontAwesomeIcons.calendarCheck,
            onPressed: () {
              cp.showSnackBar('Coming soon');
              var cap =
                  Provider.of<CrashAnalyticsProvider>(context, listen: false);
              cap.logNewFeatureClick('new_langame_add_to_calendar');
            },
            text: 'Add to calendar',
            layer: 2,
            // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 100),
          ),
          Divider(),
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            // Any case, when 2 player are in, start.
            LangameButton(FontAwesomeIcons.bell, onPressed: () {
              // USE CASE: didn't select anybody, any date
              // - a langame is created, anyone with the link can join anytime
              // USE CASE: selected X, date Y
              // - a langame is created, anyone with the link can join anytime,
              // X is notified of date Y
              cp.push(LangameListView());
            }, text: 'Join later', layer: 2),
            LangameButton(FontAwesomeIcons.hourglass, onPressed: () {
              // USE CASE: didn't select anybody, any date
              // - a langame is created, anyone with the link can join anytime
              // USE CASE: selected X, date Y
              // - a langame is created, anyone with the link can join anytime,
              // X is notified of date Y and of presence of self in lg
              cp.pushReplacement(LangameAudioView(snap.channelName, false));
            }, text: 'Join now', highlighted: true),
          ])
        ],
        canBack: true,
        title: Text('Here is the link for your Langame',
            style: Theme.of(context).textTheme.headline4));
  }
}
