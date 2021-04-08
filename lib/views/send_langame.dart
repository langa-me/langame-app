import 'package:after_layout/after_layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/topic.dart';
import 'package:langame/models/user.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/funny_sentence_provider.dart';
import 'package:langame/providers/langame_provider.dart';
import 'package:langame/providers/topic_provider.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

import 'buttons/button.dart';

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
    Provider.of<TopicProvider>(context, listen: false).getAllTopics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          actions: [
            _buildSearchBar(),
          ]),
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
                    .where((e) =>
                        e.name.toLowerCase().startsWith(filter.toLowerCase()))
                    .toList();
                return Expanded(
                  child: GroupedListView<Topic, String>(
                    elements: filteredTopics,
                    groupBy: (element) => element.groups.first,
                    groupSeparatorBuilder: (String groupByValue) => Container(
                      decoration: new BoxDecoration(
                          color: Theme.of(context).colorScheme.secondaryVariant,
                          borderRadius: new BorderRadius.only(
                            bottomLeft: const Radius.circular(40.0),
                            topRight: const Radius.circular(40.0),
                          )),
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        groupByValue,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    itemBuilder: (context, Topic t) {
                      return Center(
                        child: ToggleButton(
                            onChange: (bool selected) {
                              if (selected)
                                selectedTopics.add(t);
                              else
                                selectedTopics
                                    .removeWhere((e) => e.name == t.name);
                            },
                            width: AppSize.blockSizeHorizontal * 70,
                            textUnselected: t.name,
                            textSelected: t.name),
                      );
                    },
                  ),
                );
              },
            ),
          ]);
        },
      ),
      floatingActionButton: Consumer<LangameProvider>(
        builder: (context, l, child) => FloatingActionButton.extended(
          onPressed: () async {
            var res = await Provider.of<AuthenticationProvider>(context,
                    listen: false)
                .send(l.shoppingList, selectedTopics);
            res.thenShowToast(
                'Sent Langame to ${l.shoppingList.map((e) => e.displayName).join(', ')}',
                kReleaseMode
                    ? Provider.of<FunnyProvider>(context, listen: false)
                        .getFailingRandom()
                    : res.error.toString(),
                onSucceed: () => Navigator.pop(
                    context)); // TODO: offer to join the langame now
          },
          label: const Text('Send invitation'),
          icon: const Icon(Icons.send_outlined),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }

  Widget _buildPlayerCard(
      LangameUser player, void Function(LangameUser player) remove) {
    return Expanded(
      child: ListTile(
        title: Text(player.displayName!),
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
