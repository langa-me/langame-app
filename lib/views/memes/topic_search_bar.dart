import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/helpers/random.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/tag_provider.dart';
import 'package:langame/views/colors/colors.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

class TopicSearchWidget extends StatefulWidget {
  TopicSearchWidget();

  @override
  _State createState() => _State();
}

class _State extends State<TopicSearchWidget> {
  final FloatingSearchBarController _searchBarController =
      FloatingSearchBarController();
  String searchTopicExample = '';

  @override
  Widget build(BuildContext context) {
    if (WidgetsBinding.instance!.window.viewInsets.bottom == 0.0 &&
        !_searchBarController.isClosed) {
      //Keyboard is not visible, so we can close the search bar.
      _searchBarController.close();
    }
    return _buildFloatingSearchBar();
  }

  Widget _buildFloatingSearchBar() {
    var tp = Provider.of<TagProvider>(context);
    if (searchTopicExample.isEmpty && tp.availableTopics.length > 0) {
      searchTopicExample = tp.availableTopics.pickAny()!;
    }

    return FloatingSearchBar(
      controller: _searchBarController,
      hint: 'Try $searchTopicExample...',
      queryStyle: Theme.of(context).textTheme.headline6!.merge(TextStyle(
          decorationColor: getBlackAndWhite(context, 1, reverse: true),
          backgroundColor: getBlackAndWhite(context, 1, reverse: true),
          color: getBlackAndWhite(context, 0))),
      backdropColor: getBlackAndWhite(context, 0, reverse: true),
      backgroundColor: getBlackAndWhite(context, 1, reverse: true),
      scrollPadding: const EdgeInsets.only(top: 8, bottom: 32),
      accentColor: getBlackAndWhite(context, 1, reverse: true),
      shadowColor: getBlackAndWhite(context, 1, reverse: true),
      transitionDuration: const Duration(milliseconds: 400),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: tp.selectedTopics.isEmpty ? 0.0 : -1.0,
      openAxisAlignment: tp.selectedTopics.isEmpty ? 0 : -1.0,
      width: !AppSize.isLargeWidth
          ? AppSize.safeBlockHorizontal * 48
          : AppSize.safeBlockHorizontal * 38,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
        tp.query(query);
      },
      onFocusChanged: (focused) =>
          !focused ? _searchBarController.close() : null,
      onSubmitted: (_) => _searchBarController.close(),
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction.searchToClear(
          color: getBlackAndWhite(context, 0, reverse: false),
        ),
      ],
      builder: (context, transition) => _buildExpandableBody(tp),
    );
  }

  Widget _buildExpandableBody(TagProvider tp) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Material(
        color: getBlackAndWhite(context, 1, reverse: true),
        elevation: 4,
        child: Builder(builder: (context) {
          // Both query and history empty
          if (tp.filteredTopicSearchHistory.isEmpty &&
              _searchBarController.query.isEmpty) {
            return Container(
              height: AppSize.safeBlockVertical * 10,
              width: double.infinity,
              alignment: Alignment.center,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset(
                        isLight(context)
                            ? 'images/search-by-algolia-light-background.svg'
                            : 'images/search-by-algolia-dark-background.svg',
                        width: AppSize.safeBlockHorizontal * 10,
                        height: AppSize.safeBlockVertical * 3,
                        ),
                  ]),
            );
          } else if (tp.filteredTopicSearchHistory.isEmpty) {
            return ListTile(
              title: Text(_searchBarController.query,
                  style: Theme.of(context).textTheme.headline6),
              leading: const Icon(Icons.search),
              onTap: () {},
            );
          } else {
            // What is shown in search result thing
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: tp.filteredTopicSearchHistory
                  .map(
                    (topic) => ListTile(
                      tileColor: getBlackAndWhite(context, 1, reverse: true),
                      title: Text(topic,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline6!.merge(
                              TextStyle(
                                  color: getBlackAndWhite(context, 0,
                                      reverse: false)))),
                      onTap: () {
                        _searchBarController.close();
                        if (tp.selectedTopics.length >= 3) {
                          Provider.of<ContextProvider>(context, listen: false)
                              .showSnackBar('Three topics at most is allowed');
                          return;
                        }
                        tp.addToSelectedTopic(topic);
                      },
                    ),
                  )
                  .toList(),
            );
          }
        }),
      ),
    );
  }
}
