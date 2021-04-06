import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/topic.dart';
import 'package:langame/models/user.dart';
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

  _SendLangameState();

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<TopicProvider>(context, listen: false).getAllTopics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Send Langame ...'),
        ),
        body: Consumer<LangameProvider>(
          builder: (context, l, child) {
            return Column(children: [
              Row(
                  children: l.shoppingList
                      .map((e) => _buildPlayerCard(e, l.remove))
                      .toList()),
              _buildSearchBar(),
              Consumer<TopicProvider>(
                builder: (context, t, child) {
                  return GroupedListView<Topic, String>(
                    elements: t.topics,
                    groupBy: (element) => element.groups.first,
                    groupSeparatorBuilder: (String groupByValue) =>
                        Text(groupByValue),
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
                  );
                },
              ),
            ]);
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // TODO: send langame
          },
          label: const Text('Send invitation'),
          icon: const Icon(Icons.send_outlined),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ));
  }

  Widget _buildPlayerCard(
      LangameUser player, void Function(LangameUser player) remove) {
    return ListTile(
      title: Text(player.displayName!),
      trailing: IconButton(
        icon: Icon(Icons.clear_outlined),
        onPressed: () {
          remove(player);
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
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
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
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
    );
  }
}
