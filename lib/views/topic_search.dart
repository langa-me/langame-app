import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/new_langame_provider.dart';
import 'package:langame/providers/tag_provider.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

import 'buttons/button.dart';
import 'colors/colors.dart';

class TopicSearchView extends StatefulWidget {
  TopicSearchView();

  @override
  _TopicSearchViewState createState() => _TopicSearchViewState();
}

class _TopicSearchViewState extends State<TopicSearchView>
    with AfterLayoutMixin<TopicSearchView> {
  String filter = '';
  bool sort = true;
  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('topic_search');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: LangameButton(
            () {
              var cp = Provider.of<ContextProvider>(context, listen: false);
              cp.pop();
            },
            'Done',
            FontAwesomeIcons.checkCircle,
          ),
        ),
        body: Column(
          children: [
            _buildSearchBar(),
            Container(
              height: AppSize.safeBlockVertical * 70,
              child: Consumer2<NewLangameProvider, TagProvider>(
                  builder: (context, nlp, tp, child) {
                var topicsSorted = tp.topics.values
                    .where((tag) => tag.topic.content
                        .toLowerCase()
                        .startsWith(filter.toLowerCase()))
                    .toList();
                // if (sort) {
                //   topicsSorted.sort((a, b) {
                //     if (nlp.selectedTopics.contains(a)) return 1;
                //     if (nlp.selectedTopics.contains(b)) return 1;
                //     return -1;
                //   });
                //   WidgetsBinding.instance!.addPostFrameCallback(
                //       (_) => setState(() => sort = false));
                // }
                return ListView(
                  children: topicsSorted
                      .map((e) => Align(
                            child: ToggleButton(
                              width: AppSize.safeBlockHorizontal * 80,
                                selected: nlp.selectedTopics.contains(e),
                                onChange: (bool selected) {
                                  setState(() {
                                    if (selected)
                                      nlp.addTopic(e);
                                    else
                                      nlp.removeTopic(e);
                                  });
                                  // if (nlp.selectedTopics.length > 1) {
                                  //   var cp = Provider.of<ContextProvider>(
                                  //       context,
                                  //       listen: false);
                                  //   cp.showSnackBar(
                                  //       'Only one topic at a time is supported for now');
                                  // }
                                },
                                textUnselected:
                                    '${e.topic.emojis.join('')}\n${e.topic.content}',
                                textSelected: '${e.topic.emojis.join('')}\n${e.topic.content}'),
                          ))
                      .toList(),
                );
              }),
            ),
          ],
        ),
      );

  Widget _buildSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Expanded(
        child: FloatingSearchBar(
      border: BorderSide(),
      // shadowColor: Colors.transparent,
      // accentColor: Colors.transparent,
      // iconColor: Colors.transparent,
      // elevation: 0,
      // backgroundColor: Colors.transparent,
      // backdropColor: Colors.transparent,
      hint: 'Search topics...',
      leadingActions: [
        BackButton(color: isLightThenDark(context)),
      ],
      automaticallyImplyBackButton: false,
      hintStyle: TextStyle(fontSize: 14, color: isLightThenDark(context)),
      queryStyle: TextStyle(fontSize: 14, color: isLightThenDark(context)),
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      // width: AppSize.safeBlockHorizontal * 80,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
        setState(() {
          filter = query;
        });
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction.searchToClear(
          color: isLightThenDark(context),
          showIfClosed: true,
        ),
      ],
      builder: (context, transition) {
        return SizedBox.shrink();
      },
    ));
  }
}
