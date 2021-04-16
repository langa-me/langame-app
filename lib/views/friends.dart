import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/langame_provider.dart';
import 'package:langame/providers/local_storage_provider.dart';
import 'package:langame/views/profiles/profile.dart';
import 'package:langame/views/send_langame.dart';
import 'package:langame/views/settings.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

import 'buttons/button.dart';
import 'images/image.dart';
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
      floatingActionButton: _buildFloatingButtons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<CrashAnalyticsProvider>(context, listen: false).analytics.setCurrentScreen(screenName: 'friends');
    Provider.of<AuthenticationProvider>(context, listen: false)
        .fetchNotifications();
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
    Widget notifications = InkWell(
        child: Consumer<AuthenticationProvider>(builder: (context, p, c) {
      return Badge(
        badgeContent: Text(
          '${p.notifications.length}',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        child: Icon(
          Icons.notifications_outlined,
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(3.0),
        position: BadgePosition.topStart(top: 7, start: 10),
      );
    }), onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NotificationsView()),
      );
    });
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      leading: notifications,
      actions: [
        IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsView()),
          ),
          icon: Icon(
            Icons.settings_outlined,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingButtons() => Consumer<LangameProvider>(
        builder: (context, l, child) => l.shoppingList.length == 0
            ? SizedBox.shrink()
            : FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SendLangameView(),
                  ),
                ),
                child: Badge(
                  badgeContent: Text(
                    '${l.shoppingList.length}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Icon(Icons.shopping_cart_outlined),
                  padding: const EdgeInsets.all(3.0),
                  position: BadgePosition.topStart(top: 7, start: 10),
                ),
              ),
      );

  Widget _buildPageView() {
    return PageView(
      onPageChanged: (i) => setState(() {
        _selectedIndex = i;
      }),
      controller: _pageController,
      children: [
        Consumer<AuthenticationProvider>(
          builder: (context, a, _) =>
              a.relations == null || a.relations!.relations.length == 0
                  ? Center(
                      child: Text(
                        'In the future, you will see your friends, or people with whom you interacted with here',
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: a.relations!.relations.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              '${a.relations!.relations[index].other.displayName}'),
                          leading: buildCroppedRoundedNetworkImage(
                              a.relations!.relations[index].other.photoUrl),
                        );
                      },
                    ),
        ),
        Consumer2<LocalStorageProvider, AuthenticationProvider>(
          builder: (context, lsp, ap, _) => FloatingSearchBar(
            queryStyle: Theme.of(context).textTheme.headline6,
            controller: _searchBarController,
            automaticallyImplyBackButton: false,
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
          icon: Icon(Icons.home_outlined,
              color: _selectedIndex == 0
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.white),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          backgroundColor: theme.colorScheme.primary,
          icon: Icon(Icons.search_outlined,
              color: _selectedIndex == 1
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.white),
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
    return Consumer2<LocalStorageProvider, LangameProvider>(
        builder: (c, p, lp, _) {
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
          // TODO: might use ToggleButton instead? (with icon)
          onPressed: lp.shoppingList.any((e) => e.uid == p.selectedUser!.uid)
              ? _onRemoveFromShoppingList(p, lp)
              : _onAddToShoppingList(p, lp),
          borderRadius: 1,
          splashColor: Theme.of(context).colorScheme.secondaryVariant,
          buttonPadding: 4,
          buttonColor: Theme.of(context).colorScheme.secondary,
          children: [
            Text(
                lp.shoppingList.any((e) => e.uid == p.selectedUser!.uid)
                    ? 'Remove'
                    : 'Add',
                style: TextStyle(color: Colors.black)),
            Container(
              margin: EdgeInsets.all(10),
              child: Icon(
                lp.shoppingList.any((e) => e.uid == p.selectedUser!.uid)
                    ? Icons.remove_shopping_cart_outlined
                    : Icons.add_shopping_cart_outlined,
                size: AppSize.blockSizeHorizontal * 5,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Spacer(),
      ]);
    });
  }

  void Function() _onAddToShoppingList(
      LocalStorageProvider p, LangameProvider lp) {
    return () {
      lp.add(p.selectedUser!);
      final snackBar = SnackBar(
          content: Text(
              '${p.selectedUser!.displayName} has been added to current Langame'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    };
  }

  void Function() _onRemoveFromShoppingList(
      LocalStorageProvider p, LangameProvider lp) {
    return () {
      lp.remove(p.selectedUser!);
      final snackBar = SnackBar(
          content: Text(
              '${p.selectedUser!.displayName} has been removed from current Langame'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    };
  }
}
