import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/new_langame_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/views/buttons/button.dart';
import 'package:langame/views/users/user_tile.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

import 'app_bars/app_bars.dart';
import 'colors/colors.dart';
import 'users/profile.dart';
import 'users/shopping_list.dart';

class SearchPageView extends StatefulWidget {
  final void Function(int, {Curve? curve}) _goToPage;

  SearchPageView(this._goToPage);

  @override
  _State createState() => _State();
}

class SearchResultsListView extends StatefulWidget {
  final void Function(int, {Curve? curve}) _goToPage;

  const SearchResultsListView(this._goToPage);

  @override
  _SearchResultsListViewState createState() => _SearchResultsListViewState();
}

class _SearchResultsListViewState extends State<SearchResultsListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PreferenceProvider, NewLangameProvider>(
        builder: (c, p, lp, _) {
      if (p.selectedUser == null) {
        return p.preference.userRecommendations
            ? Column(
                children: [
                  Text('Recommendations',
                      style: Theme.of(context).textTheme.headline5),
                  lp.recommendations.length > 0
                      ? Expanded(
                          child: ListView(
                              children: lp.recommendations
                                  .map((e) => buildUserTile(
                                      context, lp, e, widget._goToPage))
                                  .toList()),
                        )
                      : Column(children: [
                          Image.asset('images/logo-colourless.png'),
                          Text(
                              'After playing some Langames, you will have some recommendations!',
                              style: Theme.of(context).textTheme.caption,
                              textAlign: TextAlign.center),
                        ]),
                ],
              )
            : Image.asset('images/logo-colourless.png');
      }

      var cp = Provider.of<ContextProvider>(context, listen: false);
      return Column(children: [
        Profile(p.selectedUser!),
        Spacer(),
        LangameButton(
          lp.shoppingList.any((e) => e.uid == p.selectedUser!.uid)
              ? Icons.remove_shopping_cart_outlined
              : Icons.add_shopping_cart_outlined,
          text: lp.shoppingList.any((e) => e.uid == p.selectedUser!.uid)
              ? 'Remove'
              : 'Add',
          highlighted: true,
          onPressed: lp.shoppingList.any((e) => e.uid == p.selectedUser!.uid)
              ? onRemoveFromShoppingList(
                  p.selectedUser!, lp, cp, widget._goToPage)
              : onAddToShoppingList(p.selectedUser!, lp, cp, widget._goToPage),
        ),
        Spacer(),
      ]);
    });
  }
}

class _State extends State<SearchPageView>
    with AfterLayoutMixin<SearchPageView> {
  final FloatingSearchBarController _searchBarController =
      FloatingSearchBarController();

  _State();

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('search_page_view');
  }

  @override
  Widget build(BuildContext context) => _buildSearchPageView();

  @override
  void dispose() {
    _searchBarController.dispose();
    super.dispose();
  }

  Widget _buildExpandableBody(
      PreferenceProvider lsp, AuthenticationProvider ap) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Material(
        color: getBlackAndWhite(context, 1, reverse: true),
        elevation: 4,
        child: Builder(builder: (context) {
          // Both query and history empty
          if (lsp.filteredUserSearchHistory.isEmpty &&
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
                      width: AppSize.safeBlockHorizontal * 20,
                      height: AppSize.safeBlockVertical * 5,
                    ),
                  ]),
            );
          } else if (lsp.filteredUserSearchHistory.isEmpty) {
            return ListTile(
              title: Text(_searchBarController.query,
                  style: Theme.of(context).textTheme.headline6),
              leading: const Icon(Icons.search),
              onTap: () {
                ap.getUserTag(_searchBarController.query).then((users) {
                  lsp.addUserSearchHistory(_searchBarController.query);
                  _searchBarController.close();
                  if (users.result?.length == 1) {
                    lsp.selectedTag = _searchBarController.query;
                    lsp.selectedUser = users.result?.first;
                    setState(() {});
                  } else {
                    lsp.selectedTag = null;
                    lsp.selectedUser = null;
                  }
                });
              },
            );
          } else {
            // What is shown in search result thing
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: lsp.filteredUserSearchHistory
                  .map(
                    (tag) => ListTile(
                      tileColor: getBlackAndWhite(context, 1, reverse: true),

                      title: Text(tag,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline6!.merge(
                              TextStyle(
                                  color: getBlackAndWhite(context, 0,
                                      reverse: false)))),
                      //leading: Icon(Icons.history, color: Colors.black),
                      trailing: IconButton(
                        icon: Icon(Icons.clear,
                            color:
                                getBlackAndWhite(context, 0, reverse: false)),
                        onPressed: () {
                          lsp.deleteUserSearchHistory(tag);
                        },
                      ),
                      onTap: () {
                        _searchBarController.close();
                        ap.getUserTag(tag).then((users) {
                          if (users.result != null &&
                              users.result!.length == 1) {
                            lsp.selectedTag = users.result?.first.tag;
                            lsp.selectedUser = users.result?.first;
                            lsp.addUserSearchHistory(users.result!.first.tag);

                            /// Place first
                            lsp.placeFirstUserSearchHistory(
                                users.result!.first.tag);
                          } else {
                            lsp.selectedTag = null;
                            lsp.selectedUser = null;
                            final snackBar =
                                SnackBar(content: Text('$tag not found!'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        });
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

  Widget _buildSearchPageView() => Scaffold(
      appBar: buildAppBar(context, 'Search people'),
      body: Consumer2<PreferenceProvider, AuthenticationProvider>(
        builder: (context, lsp, ap, _) => FloatingSearchBar(
          queryStyle: Theme.of(context).textTheme.headline6!.merge(TextStyle(
              decorationColor: getBlackAndWhite(context, 1, reverse: true),
              backgroundColor: getBlackAndWhite(context, 1, reverse: true),
              color: getBlackAndWhite(context, 0))),
          backdropColor: getBlackAndWhite(context, 0, reverse: true),
          backgroundColor: getBlackAndWhite(context, 1, reverse: true),
          scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
          accentColor: getBlackAndWhite(context, 1, reverse: true),
          shadowColor: getBlackAndWhite(context, 1, reverse: true),
          controller: _searchBarController,
          automaticallyImplyBackButton: false,
          body: FloatingSearchBarScrollNotifier(
            child: Container(
              // Padding top of default FloatingSearchBar height (48) + app size * 5
              padding: EdgeInsets.only(top: 48 + AppSize.safeBlockVertical * 5),
              constraints: BoxConstraints.expand(),
              child: SearchResultsListView(widget._goToPage),
            ),
          ),
          transition: CircularFloatingSearchBarTransition(),
          physics: BouncingScrollPhysics(),
          title: Text(
            lsp.selectedTag ?? 'Search for people',
            style: Theme.of(context).textTheme.headline6,
          ),
          hint: 'Search...',
          actions: [
            FloatingSearchBarAction.searchToClear(
              color: getBlackAndWhite(context, 0, reverse: false),
            ),
          ],
          onQueryChanged: (query) async {
            if (query.isEmpty) {
              lsp.resetFilteredSearchTagHistory();
              return;
            }
            ap.getUserTag(query).then((v) => lsp.filteredUserSearchHistory =
                v.result != null ? v.result!.map((e) => e.tag).toList() : []);
          },
          onSubmitted: (query) {
            lsp.addUserSearchHistory(query);
            _searchBarController.close();
            ap.getUserTag(query).then((users) {
              if (users.result != null && users.result!.length > 0) {
                lsp.selectedTag = query;
                lsp.selectedUser = users.result!.first;
              }
            });
          },
          builder: (context, transition) => _buildExpandableBody(lsp, ap),
        ),
      ));
}
