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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
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
                        width: AppSize.blockSizeHorizontal * 70,
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
                var channelName = await _handleFloatingPressed(l);
                if (channelName == null) {
                  return;
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LangameView(channelName, false)),
                );
              },
              label: const Text('Join now'),
              icon: const Icon(Icons.phone_in_talk_outlined),
              backgroundColor: Colors.grey,
            ),
            FloatingActionButton.extended(
              heroTag: 'join_later',
              onPressed: () async {
                var channelName = await _handleFloatingPressed(l);
                if (channelName == null) return;
                Navigator.pop(context);
              },
              label: const Text('Join later'),
              icon: const Icon(Icons.send_outlined),
              backgroundColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _handleFloatingPressed(LangameProvider l) async {
    if (selectedTopics.isEmpty) {
      showBasicSnackBar(context, 'You must select at least one topics');
      return null;
    }
    if (selectedTopics.length > 1) {
      // TODO: better UX
      showBasicSnackBar(context, 'For now, only 1 topic at once is supported');
      return null;
    }

    showBasicSnackBar(context,
        'Sent Langame to ${l.shoppingList.map((e) => e.displayName).join(', ')}');
    var res = await Provider.of<AuthenticationProvider>(context, listen: false)
        .send(l.shoppingList, selectedTopics, now: true);

    setState(selectedTopics.clear);

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
        backgroundColor: Theme.of(context).colorScheme.primary,
        backdropColor: Theme.of(context).colorScheme.primary,
        hint: 'Search topics...',
        leadingActions: [
          BackButton(color: Colors.white),
        ],
        automaticallyImplyBackButton: false,
        hintStyle: TextStyle(color: Colors.white),
        queryStyle: TextStyle(color: Colors.white),
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
        transitionDuration: const Duration(milliseconds: 800),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        width: isPortrait ? 600 : 500,
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
            color: Colors.white,
            showIfClosed: true,
          ),
        ],
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: Colors.accents.map((color) {
                  return Container(height: 112, color: color);
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
