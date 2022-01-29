import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/views/users/user_search_result_list.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

import '../app_bars/app_bars.dart';
import '../colors/colors.dart';

class UserSearchPage extends StatefulWidget {
  UserSearchPage();

  @override
  _State createState() => _State();
}

class _State extends State<UserSearchPage> {
  final FloatingSearchBarController _searchBarController =
      FloatingSearchBarController();

  _State();

  @override
  void initState() {
    super.initState();
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('user_search_page');
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb &&
        WidgetsBinding.instance!.window.viewInsets.bottom == 0.0 &&
        !_searchBarController.isClosed) {
      //Keyboard is not visible, so we can close the search bar.
      _searchBarController.close();
    }
    return Scaffold(
        backgroundColor: getBlackAndWhite(context, 0, reverse: true),
        appBar: buildAppBar(context, ''),
        body: Consumer2<PreferenceProvider, AuthenticationProvider>(
          builder: (context, lsp, ap, _) => FloatingSearchBar(
            queryStyle: Theme.of(context).textTheme.headline6!.merge(TextStyle(
                decorationColor: getBlackAndWhite(context, 1, reverse: true),
                backgroundColor: getBlackAndWhite(context, 1, reverse: true),
                color: getBlackAndWhite(context, 0))),
            clearQueryOnClose: false,
            width: AppSize.safeBlockHorizontal * 90,
            backdropColor: getBlackAndWhite(context, 0, reverse: true),
            backgroundColor: getBlackAndWhite(context, 1, reverse: true),
            scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
            accentColor: getBlackAndWhite(context, 1, reverse: true),
            shadowColor: getBlackAndWhite(context, 1, reverse: true),
            controller: _searchBarController,
            automaticallyImplyBackButton: false,
            onFocusChanged: (focused) => !focused ? _searchBarController.close() : null,

            openAxisAlignment: 0.0,
            body: FloatingSearchBarScrollNotifier(
              child: Container(
                // Padding top of default FloatingSearchBar height (48) + app size * 5
                padding:
                    EdgeInsets.only(top: 48 + AppSize.safeBlockVertical * 5),
                constraints: BoxConstraints.expand(),
                child: SearchResultsListView(),
              ),
            ),
            transition: CircularFloatingSearchBarTransition(),
            physics: BouncingScrollPhysics(),
            hint: 'Search someone\'s tag',
            actions: [
              FloatingSearchBarAction.searchToClear(
                color: getBlackAndWhite(context, 0, reverse: false),
              ),
            ],
            onQueryChanged: (query) async {
              if (query.isEmpty) {
                lsp.resetFilteredSearchTagHistory();
                lsp.selectedUser = null;
                return;
              }
              ap.getUserTag(query).then((v) => lsp.filteredUserSearchHistory =
                  v.result != null ? v.result!.map((e) => e.tag).toList() : []);
            },
            onSubmitted: (query) {
              _searchBarController.close();
              if (query.isEmpty) {
                lsp.resetFilteredSearchTagHistory();
                lsp.selectedTag = null;
                lsp.selectedUser = null;
                return;
              }
              lsp.addUserSearchHistory(query);
              ap.getUserTag(query).then((users) {
                if (users.result != null && users.result!.length > 0) {
                  lsp.selectedTag = query;
                  lsp.selectedUser = users.result!.first;
                } else {
                  lsp.selectedTag = null;
                  lsp.selectedUser = null;
                }
              });
            },
            builder: (context, transition) => _buildExpandableBody(lsp, ap),
          ),
        ));
  }

  @override
  void dispose() {
    _searchBarController.dispose();
    super.dispose();
  }

  Widget _buildExpandableBody(
      PreferenceProvider lsp, AuthenticationProvider ap) {
    final cp = Provider.of<ContextProvider>(context, listen: false);
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
              width: AppSize.safeBlockHorizontal * 90,
              alignment: Alignment.center,
              padding: EdgeInsets.all(12),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset(
                      isLight(context)
                          ? 'images/search-by-algolia-light-background.svg'
                          : 'images/search-by-algolia-dark-background.svg',
                      width: AppSize.safeBlockHorizontal *
                          (AppSize.isLargeWidth ? 10 : 40),
                      height: AppSize.safeBlockVertical *
                          (AppSize.isLargeWidth ? 3 : 5),
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
                            cp.showSnackBar('$tag not found!');
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
}
