import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/local_storage_provider.dart';
import 'package:langame/providers/profile_provider.dart';
import 'package:langame/views/profile.dart';
import 'package:langame/views/send_langame.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

import 'buttons/button.dart';
import 'image.dart';
import 'notifications.dart';

class FriendsView extends StatefulWidget {
  @override
  _FriendsViewState createState() => _FriendsViewState();
}

/// Main page of Langame (temporary name...)
class _FriendsViewState extends State<FriendsView> {
  int _selectedIndex = 0;
  late FloatingSearchBarController _searchBarController;
  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  @override
  void initState() {
    super.initState();
    _searchBarController = FloatingSearchBarController();
  }

  @override
  void dispose() {
    Provider.of<LocalStorageProvider>(context, listen: false)
        .saveSearchHistory();
    _searchBarController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  PreferredSizeWidget? _buildAppBar() {
    return AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: InkWell(
            child: Consumer<AuthenticationProvider>(builder: (context, p, c) {
          return Badge(
            badgeContent: Text('${p.notifications.length}'),
            child: Icon(Icons.notifications),
            padding: const EdgeInsets.all(3.0),
            position: BadgePosition.topStart(top: 7, start: 10),
          );
        }), onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotificationsView()),
          );
        }),
        actions: <Widget>[
          Consumer2<AuthenticationProvider, ProfileProvider>(builder:
              (context, authenticationProvider, profileProvider, child) {
            if (authenticationProvider.user != null) {
              return InkWell(
                  onTap: () {
                    profileProvider.profileShown =
                        !profileProvider.profileShown;
                  },
                  child: buildCroppedRoundedNetworkImage(
                      authenticationProvider.user!.photoUrl));
            } else {
              return IconButton(
                  icon: Icon(Icons.account_circle), onPressed: () {});
            }
          })
        ]);
  }

  Widget _buildPageView() {
    return PageView(
      onPageChanged: (i) => setState(() {
        _selectedIndex = i;
      }),
      controller: _pageController,
      children: [
        Center(
            child: Text('No friends? =>',
                style: Theme.of(context).textTheme.headline3)),
        Consumer2<LocalStorageProvider, AuthenticationProvider>(
          builder: (context, lsp, ap, _) => FloatingSearchBar(
            queryStyle: Theme.of(context).textTheme.headline6,
            controller: _searchBarController,
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
            title: Text(
              lsp.selectedTag ?? 'Search for new faces',
              style: Theme.of(context).textTheme.headline6,
            ),
            hint: 'Search and find out...',
            actions: [
              FloatingSearchBarAction.searchToClear(),
            ],
            onQueryChanged: (query) async {
              if (query.isEmpty) {
                lsp.resetFilteredSearchTagHistory();
                return;
              }
              ap.getLangameUsersStartingWithTag(query).then((v) =>
                  lsp.filteredTagSearchHistory = v.map((e) => e.tag!).toList());
            },
            onSubmitted: (query) {
              lsp.addSearchHistory(query);
              _searchBarController.close();
              ap.getLangameUsersStartingWithTag(query).then((users) {
                if (users.length == 1) {
                  lsp.selectedTag = query;
                  lsp.selectedUser = users.first;
                } else {
                  // TODO: should notify "no user found" or several found ...
                  lsp.selectedTag = null;
                  lsp.selectedUser = null;
                }
              });
            },
            builder: (context, transition) => _buildExpandableBody(lsp, ap),
          ),
        )
      ],
    );
  }

  Widget _buildExpandableBody(
      LocalStorageProvider lsp, AuthenticationProvider ap) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Material(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Theme.of(context).primaryColor,
        elevation: 4,
        child: Builder(builder: (context) {
          // Both query and history empty
          if (lsp.filteredTagSearchHistory.isEmpty &&
              _searchBarController.query.isEmpty) {
            return Container(
              height: 56,
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                'Start searching',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline6,
              ),
            );
          } else if (lsp.filteredTagSearchHistory.isEmpty) {
            return ListTile(
              title: Text(_searchBarController.query,
                  style: Theme.of(context).textTheme.headline6),
              leading: const Icon(Icons.search),
              onTap: () {
                ap
                    .getLangameUsersStartingWithTag(_searchBarController.query)
                    .then((users) {
                  lsp.addSearchHistory(_searchBarController.query);
                  _searchBarController.close();
                  if (users.length == 1) {
                    lsp.selectedTag = _searchBarController.query;
                    lsp.selectedUser = users.first;
                    setState(() {});
                  } else {
                    // TODO: should notify "no user found" or several found ...
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
              children: lsp.filteredTagSearchHistory
                  .map(
                    (tag) => ListTile(
                      tileColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                      title: Text(tag,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline6),
                      leading: const Icon(Icons.history),
                      trailing: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          lsp.deleteSearchHistory(tag);
                        },
                      ),
                      onTap: () {
                        _searchBarController.close();
                        ap.getLangameUsersStartingWithTag(tag).then((users) {
                          if (users.length == 1) {
                            lsp.selectedTag = users.first.tag;
                            lsp.selectedUser = users.first;
                            lsp.addSearchHistory(users.first.tag!);

                            /// Place first
                            lsp.placeFirstSearchHistory(users.first.tag!);
                          } else {
                            // TODO: should notify "no user found" or several found ...
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

  void _onBottomBarItemTapped(int index) {
    setState(() {
      // selectedTag = null;
      // selectedUser = null;
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(seconds: 1), curve: Curves.easeOutBack);
    });
  }

  Widget _buildBottomNavigationBar() {
    final theme = Theme.of(context);
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      selectedItemColor: theme.colorScheme.secondary,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          backgroundColor: theme.colorScheme.primary,
          icon: Icon(Icons.home_outlined, color: theme.colorScheme.secondary),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          backgroundColor: theme.colorScheme.primary,
          icon: Icon(Icons.search_outlined, color: theme.colorScheme.secondary),
          label: 'Search',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onBottomBarItemTapped,
    );
  }
}

class SearchResultsListView extends StatefulWidget {
  @override
  _SearchResultsListViewState createState() => _SearchResultsListViewState();
}

class _SearchResultsListViewState extends State<SearchResultsListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LocalStorageProvider>(builder: (c, p, _) {
      if (p.selectedUser == null) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search,
                size: 64,
              ),
              Text(
                'Start searching',
                style: Theme.of(context).textTheme.headline5,
              )
            ],
          ),
        );
      }

      return Column(children: [
        Profile(p.selectedUser!),
        Spacer(),
        StretchableButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SendLangameView(p.selectedUser!)),
            );
          },
          borderRadius: 2,
          splashColor: Theme.of(context).colorScheme.secondaryVariant,
          buttonPadding: 4,
          buttonColor: Theme.of(context).colorScheme.secondary,
          children: [
            Text('Send a Langame'),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              child: Image.asset('images/logo.png',
                  width: AppSize.blockSizeHorizontal * 12),
            ),
          ],
        ),
        SizedBox(height: AppSize.safeBlockVertical * 10)
      ]);
    });
  }
}
