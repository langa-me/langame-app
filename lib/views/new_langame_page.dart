import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/helpers/random.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/providers/langame_provider.dart';
import 'package:langame/providers/new_langame_provider.dart';
import 'package:langame/providers/tag_provider.dart';
import 'package:langame/views/buttons/button.dart';
import 'package:langame/views/colors/colors.dart';
import 'package:langame/views/langames/langame_text.dart';
import 'package:langame/views/topics/topic_search_bar.dart';
import 'package:langame/views/users/user_search_page.dart';
import 'package:provider/provider.dart';

import 'app_bars/app_bars.dart';
import 'users/user_tile.dart';

class NewLangamePage extends StatefulWidget {
  NewLangamePage();

  @override
  _SendLangameState createState() => _SendLangameState();
}

class _SendLangameState extends State<NewLangamePage>
    with AfterLayoutMixin<NewLangamePage> {
  _SendLangameState();

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('new_langame_page_view');
    Provider.of<TagProvider>(context, listen: false).setDefaultTopics();
  }

  @override
  Widget build(BuildContext context) {
    var nlp = Provider.of<NewLangameProvider>(context);
    var cp = Provider.of<ContextProvider>(context);
    var tp = Provider.of<TagProvider>(context);
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      backgroundColor: getBlackAndWhite(context, 0, reverse: true),
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(context, 'Start a new Langame'),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                Container(
                  width: AppSize.safeBlockHorizontal * 90,
                  child: Wrap(
                    children: tp.selectedTopics
                        .map((e) => LangameButton(FontAwesomeIcons.times,
                            // fixedSize: Size(AppSize.safeBlockHorizontal * 20, AppSize.safeBlockVertical * 5),
                            layer: 1,
                            text: e,
                            onPressed: () => tp.removeFromSelectedTopic(e)))
                        .toList(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AppSize.safeBlockVertical * 5,
            ),
            Container(
              width: AppSize.safeBlockHorizontal * 90,
              child: Consumer<NewLangameProvider>(
                builder: (c, nlp, child) => ListView(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: nlp.shoppingList.isEmpty
                      ? [
                          ListTile(
                            leading: Icon(FontAwesomeIcons.plusCircle),
                            title: Text('Add people...',
                                style: Theme.of(context).textTheme.headline6),
                            onTap: () => cp.push(
                              UserSearchPage(),
                            ),
                          )
                          // LangameButton(
                          //   FontAwesomeIcons.userPlus,
                          //   text: 'Invite',
                          //   onPressed: () => cp.push(UserSearchPage()),
                          //   layer: 0,
                          //   border: false,
                          //   fixedSize: Size(
                          //       AppSize.safeBlockHorizontal * 100,
                          //       AppSize.safeBlockVertical * 10,
                          //   ),
                          // ),
                        ]
                      : nlp.shoppingList
                          .map(
                            (e) => buildUserTile(
                              context,
                              e,
                            ),
                          )
                          .toList(),
                ),
              ),
            ),
            Spacer(),
            LangameButton(
              FontAwesomeIcons.checkCircle,
              onPressed: () => onPressedNewLangame(cp, nlp),
              text: 'Start a new Langame',
              highlighted: true,
              layer: 1,
              padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: AppSize.safeBlockHorizontal *
                      (AppSize.isLargeWidth ? 5 : 20)),
            ),
            SizedBox(
              height: AppSize.safeBlockVertical * 5,
            ),
          ]),
    );
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

    if (nlp.shoppingList.length > 1) {
      cp.showSnackBar('Only one-to-one Langames are supported yet!');
      return;
    }

    var lp = Provider.of<LangameProvider>(context, listen: false);
    var fp = Provider.of<FunnyProvider>(context, listen: false);
    cp.showLoadingDialog();
    var createLangame = await lp.createLangame(
      nlp.shoppingList,
      topics.toList(),
    );
    if (createLangame.error != null ||
        createLangame.result == null ||
        createLangame.result!.data() == null) {
      cp.dialogComplete();
      var msg = '${fp.getFailingRandom()}, please retry later';
      cp.showFailureDialog(msg);
      await Future.delayed(Duration(seconds: 2));
      cp.dialogComplete();
      return;
    }

    var snap = createLangame.result!.data()!;
    cp.dialogComplete();
    snap.id = createLangame.result!.id;
    // TODO: Any better way to enter the Langame with having as ancestor the main page?
    cp.pop();
    cp.push(LangameTextView(snap));
  }
}
