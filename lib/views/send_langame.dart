import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/helpers/toast.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/langame_provider.dart';
import 'package:langame/providers/topic_provider.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

import 'buttons/button.dart';
import 'colors/colors.dart';
import 'langame.dart';

class SendLangameView extends StatefulWidget {
  SendLangameView();

  @override
  _SendLangameState createState() => _SendLangameState();
}

class _SendLangameState extends State<SendLangameView>
    with AfterLayoutMixin<SendLangameView> {
  List<Topic> selectedTopics = [];
  String filter = '';
  _SendLangameState();

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .analytics
        .setCurrentScreen(screenName: 'send_langame');
    Provider.of<TopicProvider>(context, listen: false).getAllTopics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          _buildSearchBar(),
        ],
      ),
      body: Consumer<LangameProvider>(
        builder: (context, l, child) {
          return Column(children: [
            Row(
                children: l.shoppingList
                    .map((e) => _buildPlayerCard(e, l.remove))
                    .toList()),
            Consumer<TopicProvider>(
              builder: (context, t, child) {
                List<Topic> filteredTopics = t.topics
                    .where((e) => e.content
                        .toLowerCase()
                        .startsWith(filter.toLowerCase()))
                    .toList();
                return Container(
                  height: AppSize.safeBlockVertical * 70,
                  child: GridView.builder(
                    itemCount: filteredTopics.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 0,
                    ),
                    itemBuilder: (context, int i) => ToggleButton(
                        onChange: (bool selected) {
                          if (selected)
                            selectedTopics.add(filteredTopics[i]);
                          else
                            selectedTopics.removeWhere(
                                (e) => e.content == filteredTopics[i].content);
                        },
                        width: AppSize.blockSizeHorizontal * 50,
                        textUnselected: filteredTopics[i].content,
                        textSelected: filteredTopics[i].content),
                  ),
                );
              },
            ),
          ]);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Consumer<LangameProvider>(
        builder: (context, l, child) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton.extended(
              heroTag: 'join_now',
              onPressed: () async {
                var channelName = await _handleFloatingPressed(l, now: true);
                if (channelName == null) {
                  setState(selectedTopics.clear);
                  return;
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LangameView(channelName, false)),
                );
              },
              label: const Text('Now', style: TextStyle(color: Colors.white)),
              icon:
                  const Icon(Icons.phone_in_talk_outlined, color: Colors.white),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            FloatingActionButton.extended(
              heroTag: 'join_later',
              onPressed: () async {
                var channelName = await _handleFloatingPressed(l, now: false);
                if (channelName == null) {
                  setState(selectedTopics.clear);
                  return;
                }
                Navigator.pop(context);
              },
              label: Text('Later', style: TextStyle(color: Colors.white)),
              icon: Icon(Icons.send_outlined, color: Colors.white),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _handleFloatingPressed(LangameProvider l,
      {bool now = true}) async {
    if (selectedTopics.isEmpty) {
      showBasicSnackBar(context, 'You must select at least one topics');
      return null;
    }
    if (selectedTopics.length > 1) {
      // TODO: better UX
      showBasicSnackBar(context, 'For now, only 1 topic at once is supported');
      return null;
    }

    // showBasicSnackBar(context,
    //     'Sent Langame to ${l.shoppingList.map((e) => e.displayName).join(', ')}');
    var res = await Provider.of<AuthenticationProvider>(context, listen: false)
        .send(l.shoppingList, selectedTopics, now: now);

    return res.result;
  }

  Widget _buildPlayerCard(
      lg.User player, void Function(lg.User player) remove) {
    return Expanded(
      child: ListTile(
        title: Text(player.displayName),
        trailing: IconButton(
          icon: Icon(Icons.clear_outlined),
          onPressed: () {
            remove(player);
          },
        ),
      ),
    );
  }

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
          BackButton(color: isLightThenBlack(context)),
        ],
        automaticallyImplyBackButton: false,
        hintStyle: TextStyle(color: isLightThenBlack(context)),
        queryStyle: TextStyle(color: isLightThenBlack(context)),
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
            color: isLightThenBlack(context),
            showIfClosed: true,
          ),
        ],
        builder: (context, transition) {
          return SizedBox.shrink();
        },
      ),
    );
  }
}
