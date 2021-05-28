import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/dynamic_links_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/providers/langame_provider.dart';
import 'package:langame/providers/message_provider.dart';
import 'package:langame/providers/new_langame_provider.dart';
import 'package:langame/providers/relation_provider.dart';
import 'package:langame/views/buttons/button.dart';
import 'package:langame/views/langame.dart';
import 'package:langame/views/running_langames_view.dart';
import 'package:langame/views/texts/texts.dart';
import 'package:langame/views/topic_search.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

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

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('send_langame');
  }

  @override
  Widget build(BuildContext context) {
    var nlp = Provider.of<NewLangameProvider>(context);
    var cp = Provider.of<ContextProvider>(context);
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      TextDivider('Topic'),
      LangameButton(
          () => cp.push(TopicSearchView()),
          nlp.selectedTopics.isEmpty
              ? 'Select a topic'
              : nlp.selectedTopics.first.content,
          FontAwesomeIcons.graduationCap,
          padding: EdgeInsets.symmetric(
              vertical: 10, horizontal: AppSize.safeBlockHorizontal * 20)),
      TextDivider('Invite'),
      Container(
        // height: AppSize.safeBlockVertical * 40,
        width: AppSize.safeBlockHorizontal * 100,
        child: Consumer2<NewLangameProvider, RelationProvider>(
          builder: (c, nlp, rp, child) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: nlp.shoppingList.isEmpty
                ? [
                    LangameButton(
                        () => widget._goToPage(3, curve: Curves.bounceIn),
                        'Add people',
                        FontAwesomeIcons.userPlus,
                        padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: AppSize.safeBlockHorizontal * 5)),
                    Text(
                        'Your friends can also join later using a link for example',
                        style: Theme.of(context).textTheme.caption!.merge(
                            TextStyle(
                                color:
                                    isLightThenDark(context, reverse: false)))),
                  ]
                : nlp.shoppingList
                    .map(
                      (e) => FutureBuilder<LangameResponse<InteractionLevel?>>(
                        future: rp.getInteraction(e.uid),
                        builder: (ctx, s) => BuildUserTile(
                          context,
                          nlp,
                          e,
                          s.hasData && s.data != null && s.data!.result != null
                              ? s.data!.result
                              : null,
                          widget._goToPage,
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
      ),
      DateTimePicker(
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
        onSaved: (val) => val ?? nlp.setSelectedDate(DateTime.parse(val!)),
      ),
      // SizedBox(height: AppSize.safeBlockVertical * 6),
      LangameButton(() => onPressedNewLangame(cp, nlp), 'New Langame',
          FontAwesomeIcons.comments,
          padding: EdgeInsets.symmetric(
              vertical: 10, horizontal: AppSize.safeBlockHorizontal * 20)),
      // SizedBox(height: AppSize.safeBlockVertical * 5),
    ]);
  }

  void onPressedNewLangame(ContextProvider cp, NewLangameProvider nlp) async {
    if (nlp.selectedTopics.isEmpty) {
      cp.showSnackBar('You must select at least one topics');
      return;
    }
    var cap = Provider.of<CrashAnalyticsProvider>(context, listen: false);
    if (nlp.selectedTopics.length > 1) {
      cp.showSnackBar('For now, only 1 topic at once is supported');
      cap.logNewFeatureClick('new_langame_multiple_topics');
      return;
    }

    var lp = Provider.of<LangameProvider>(context, listen: false);
    var fp = Provider.of<FunnyProvider>(context, listen: false);
    cp.showLoadingDialog(fp.getLoadingRandom());
    var createLangame = await lp.createLangame(nlp.shoppingList,
        nlp.selectedTopics, nlp.selectedDate ?? DateTime.now());
    if (createLangame.error != null) {
      cp.dialogComplete();
      cp.showFailureDialog('${fp.getFailingRandom()}, please retry later');
      await Future.delayed(Duration(seconds: 2));
      cp.dialogComplete();
      return;
    }
    DocumentSnapshot<Langame> snap;
    try {
      snap = await createLangame.result!
          .where((c) => c.data() != null && c.data()!.hasChannelName())
          .first
          .timeout(Duration(seconds: 5));
    } on TimeoutException {
      cp.dialogComplete();
      cp.showFailureDialog('${fp.getFailingRandom()}, please retry later');
      await Future.delayed(Duration(seconds: 2));
      cp.dialogComplete();
      return;
    }
    // TODO: somehow has error? but it should be filtered just above
    if (!snap.data()!.hasChannelName()) {
      cp.dialogComplete();
      cp.showFailureDialog('${fp.getFailingRandom()}, please retry later');
      await Future.delayed(Duration(seconds: 2));
      cp.dialogComplete();
      return;
    }
    var dlp = Provider.of<DynamicLinksProvider>(context, listen: false);
    var createDynamicLink =
        await dlp.createDynamicLink('play/${snap.data()!.channelName}', false);
    cp.dialogComplete();
    if (createDynamicLink.error != null) {
      cp.showFailureDialog('${fp.getFailingRandom()}, please retry later');
      await Future.delayed(Duration(seconds: 2));
      cp.dialogComplete();
      return;
    }
    cp.showCustomDialog(
      [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              border: Border.all(
                color: isLightThenDark(context),
                width: 5,
              ),
              color: variantIsLightThenDark(context, reverse: true),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          height: AppSize.blockSizeVertical * 90,
          width: AppSize.blockSizeHorizontal * 90,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Here is the link for your Langame',
                  style: Theme.of(context).textTheme.headline4!.merge(TextStyle(
                      color: isLightThenDark(context, reverse: false)))),
              Divider(),
              Text(
                  'Copy this link and send it to people you want to meet with. '
                  'Be sure to save it so you can use it later, too.',
                  style: Theme.of(context).textTheme.caption!.merge(TextStyle(
                      color: isLightThenDark(context, reverse: false)))),
              Divider(),
              ListTile(
                onTap: () => FlutterClipboard.copy(createDynamicLink.result!)
                    .then((v) => cp.showSnackBar(
                        '${createDynamicLink.result!} copied to clipboard!')),
                tileColor: Theme.of(context).colorScheme.primaryVariant,
                title: Text(
                  createDynamicLink.result!,
                  style: TextStyle(
                      color: isLightThenDark(context, reverse: false)),
                ),
                leading: IconButton(
                  icon: Icon(FontAwesomeIcons.shareAlt,
                      color: isLightThenDark(context, reverse: false)),
                  onPressed: () => Share.share(
                      'Join my Langame to talk about ${nlp.selectedTopics.join(',')} at ${createDynamicLink.result!}',
                      subject:
                          'Join my Langame to talk about ${nlp.selectedTopics.join(',')}',
                      sharePositionOrigin: Rect.fromCenter(
                          center: Offset(AppSize.screenWidth / 2,
                              AppSize.screenHeight / 2),
                          height: 0,
                          width: 0)),
                ),
                trailing: Icon(FontAwesomeIcons.copy,
                    color: isLightThenDark(context, reverse: false)),
              ),
              LangameButton(
                () {
                  cp.showSnackBar('Coming soon');
                  var cap = Provider.of<CrashAnalyticsProvider>(context,
                      listen: false);
                  cap.logNewFeatureClick('new_langame_add_to_calendar');
                },
                'Add to calendar',
                FontAwesomeIcons.calendarCheck,
                // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 100),
              ),
              Divider(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                // Any case, when 2 player are in, start.
                LangameButton(() {
                  // USE CASE: didn't select anybody, any date
                  // - a langame is created, anyone with the link can join anytime
                  // USE CASE: selected X, date Y
                  // - a langame is created, anyone with the link can join anytime,
                  // X is notified of date Y
                  cp.push(RunningLangamesView());
                }, 'Join later', FontAwesomeIcons.bell),
                LangameButton(() {
                  // USE CASE: didn't select anybody, any date
                  // - a langame is created, anyone with the link can join anytime
                  // USE CASE: selected X, date Y
                  // - a langame is created, anyone with the link can join anytime,
                  // X is notified of date Y and of presence of self in lg
                  cp.pushReplacement(
                      LangameView(snap.data()!.channelName, false));
                }, 'Join now', FontAwesomeIcons.hourglass),
              ])
            ],
          ),
        ),
      ],
      canBack: true,
      backgroundColor: Colors.transparent,
    );
  }
}
