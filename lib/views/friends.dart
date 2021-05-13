import 'package:after_layout/after_layout.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/langame_provider.dart';
import 'package:langame/providers/message_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/providers/relation_provider.dart';
import 'package:langame/views/profiles/profile.dart';
import 'package:langame/views/send_langame.dart';
import 'package:langame/views/settings.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

import 'colors/colors.dart';
import 'dialogs/dialogs.dart';
import 'images/image.dart';
import 'notifications.dart';

class FriendsView extends StatefulWidget {
  @override
  _FriendsViewState createState() => _FriendsViewState();
}

/// Main page of Langame (temporary name...)
class _FriendsViewState extends State<FriendsView>
    with AfterLayoutMixin<FriendsView> {
  int _selectedIndex = 0;
  late FloatingSearchBarController _searchBarController;
  PageController _pageController = PageController(
    initialPage: 0,
  );
  GlobalKey _toolTipKey = GlobalKey();

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<CrashAnalyticsProvider>(context, listen: false)
        .setCurrentScreen('send_langame');
    var mp = Provider.of<MessageProvider>(context, listen: false);
    mp.fetchNotifications();
    var rp = Provider.of<RelationProvider>(context, listen: false);
    rp.getUserRecommendations();
    rp.getRecentInteractions();
    _searchBarController = FloatingSearchBarController();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => basicOnWillPopScope(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(),
        floatingActionButton: _buildFloatingButtons(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: _buildPageView(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  @override
  void dispose() {
    // TODO:
    // Provider.of<LocalStorageProvider>(context, listen: false)
    //     .saveSearchHistory();
    _searchBarController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  PreferredSizeWidget? _buildAppBar() {
    var cp = Provider.of<ContextProvider>(context, listen: false);
    Widget notifications = InkWell(
        child: Consumer<MessageProvider>(builder: (context, p, c) {
          return Badge(
            badgeColor: Theme.of(context).colorScheme.secondary,
            badgeContent: Text(
              '${p.notifications.length}',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            child: Icon(
              Icons.notifications_outlined,
              color: isLightThenBlack(context),
            ),
            padding: const EdgeInsets.all(3.0),
            position: BadgePosition.topStart(top: 7, start: 10),
          );
        }),
        onTap: () => cp.push(NotificationsView()));
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: notifications,
      actions: [
        // kReleaseMode
        //     ? SizedBox.shrink()
        //     : IconButton(
        //         onPressed: () => cp.push(MultiplayerPainting('foo')),
        //         icon: Icon(
        //           Icons.format_paint_outlined,
        //           color: isLightThenBlack(context),
        //         ),
        //       ),
        IconButton(
          onPressed: () => cp.push(SettingsView()),
          icon: Icon(
            Icons.settings_outlined,
            color: isLightThenBlack(context),
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingButtons() => Consumer<LangameProvider>(
        builder: (context, l, child) => FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          onPressed: () => l.shoppingList.length > 0
              ? Provider.of<ContextProvider>(context, listen: false)
                  .push(SendLangameView())
              : null,
          child: Badge(
            badgeContent: Text(
              '${l.shoppingList.length}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Icon(Icons.shopping_cart_outlined, color: Colors.black),
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
        Consumer<RelationProvider>(
          builder: (context, r, _) => Flex(direction: Axis.vertical, children: [
            Expanded(
                child: Column(children: [
              Expanded(child: _buildLatestInteractions(r)),
              Expanded(child: _buildRecommendations(r)),
            ]))
          ]),
        ),
        Consumer2<PreferenceProvider, AuthenticationProvider>(
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
              lsp.selectedTag ?? 'Search for people',
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
                  lsp.filteredTagSearchHistory = v.map((e) => e.tag).toList());
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

  Widget _buildUserTile(LangameProvider lp, User u, InteractionLevel? l) =>
      ListTile(
        subtitle:
            l != null ? l.toFaIcon() : FaIcon(FontAwesomeIcons.questionCircle),
        title: Text('${u.displayName}'),
        leading: buildCroppedRoundedNetworkImage(u.photoUrl),
        trailing: MaterialButton(
          // TODO: might use ToggleButton instead? (with icon)
          onPressed: lp.shoppingList.any((e) => e.uid == u.uid)
              ? _onRemoveFromShoppingList(context, u, lp)
              : _onAddToShoppingList(context, u, lp),
          splashColor: Theme.of(context).colorScheme.secondaryVariant,
          color: Theme.of(context).colorScheme.secondary,
          shape: CircleBorder(),
          child: Icon(
            lp.shoppingList.any((e) => e.uid == u.uid)
                ? Icons.remove_shopping_cart_outlined
                : Icons.add_shopping_cart_outlined,
            color: Colors.black,
          ),
        ),
      );

  Widget _buildRecommendations(RelationProvider r) =>
      Consumer<PreferenceProvider>(
        builder: (context, pp, c) => !pp.preference.unknownPeopleRecommendations
            ? SizedBox.shrink()
            : Container(
                height: AppSize.safeBlockVertical * 40,
                child: Column(
                  children: [
                    ListTile(
                      // tileColor: Theme.of(context).colorScheme.primaryVariant,
                      title: Text(
                        'Recommendations',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      leading: Switch(
                          value: pp.preference.unknownPeopleRecommendations,
                          onChanged: (v) {
                            Provider.of<ContextProvider>(context, listen: false)
                                .showSnackBar(
                                    'Understood, you can still reactivate recommendations in settings later');
                            pp.setRecommendations(
                                !pp.preference.unknownPeopleRecommendations);
                          }),
                      trailing: Stack(children: [
                        Tooltip(
                          key: _toolTipKey,
                          message: 'Recommendations feature is experimental',
                        ),
                        IconButton(
                          icon: Icon(Icons.help_outline_outlined),
                          onPressed: () {
                            final dynamic tooltip = _toolTipKey.currentState;
                            tooltip.ensureTooltipVisible();
                          },
                        ),
                      ]),
                    ),
                    Divider(thickness: 3),
                    Expanded(
                      child: Container(
                        height: AppSize.safeBlockVertical * 40,
                        child: Consumer<LangameProvider>(
                          builder: (c, lp, child) => ListView.builder(
                            itemCount: r.userRecommendations.length,
                            itemBuilder: (context, index) => FutureBuilder<
                                    LangameResponse<InteractionLevel?>>(
                                future: r.getInteraction(
                                    r.userRecommendations[index].uid),
                                builder: (ctx, s) => _buildUserTile(
                                    lp,
                                    r.userRecommendations[index],
                                    s.hasData &&
                                            s.data != null &&
                                            s.data!.result != null
                                        ? s.data!.result
                                        : null)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      );

  Widget _buildLatestInteractions(RelationProvider r) => Container(
        height: AppSize.safeBlockVertical * 40,
        child: Column(
          children: [
            ListTile(
              // tileColor: Theme.of(context).colorScheme.primaryVariant,
              title: Text(
                'Recent',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Divider(thickness: 3),
            Expanded(
              child: Container(
                height: AppSize.safeBlockVertical * 40,
                child: Consumer<LangameProvider>(
                  builder: (c, lp, child) => r.recentInteractions.length == 0
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('No recent interactions, launch a Langame!',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline4),
                              SizedBox(height: AppSize.safeBlockVertical * 5),
                              Text(
                                  'Invite your friends for a great conversation',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.caption),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: r.recentInteractions.length,
                          itemBuilder: (context, index) => _buildUserTile(
                              lp,
                              r.recentInteractions.elementAt(index).item1,
                              r.recentInteractions.elementAt(index).item2),
                        ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildExpandableBody(
      PreferenceProvider lsp, AuthenticationProvider ap) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Material(
        color: Colors.white,
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
                style: TextStyle(color: Colors.black, fontSize: 20),
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
                      tileColor: Colors.white,
                      title: Text(tag,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black)),
                      //leading: Icon(Icons.history, color: Colors.black),
                      trailing: IconButton(
                        icon: Icon(Icons.clear, color: Colors.black),
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
                            lsp.addSearchHistory(users.first.tag);

                            /// Place first
                            lsp.placeFirstSearchHistory(users.first.tag);
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
      elevation: 0,
      backgroundColor: Colors.transparent,
      type: BottomNavigationBarType.shifting,
      selectedItemColor: theme.colorScheme.secondary,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          backgroundColor: Colors.transparent,
          icon: Icon(Icons.home_outlined,
              color: _selectedIndex == 0
                  ? Theme.of(context).colorScheme.secondary
                  : isLightThenBlack(context)),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.transparent,
          icon: Icon(Icons.search_outlined,
              color: _selectedIndex == 1
                  ? Theme.of(context).colorScheme.secondary
                  : isLightThenBlack(context)),
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
    return Consumer2<PreferenceProvider, LangameProvider>(
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
        OutlinedButton.icon(
          // TODO: might use ToggleButton instead? (with icon)
          onPressed: lp.shoppingList.any((e) => e.uid == p.selectedUser!.uid)
              ? _onRemoveFromShoppingList(context, p.selectedUser!, lp)
              : _onAddToShoppingList(context, p.selectedUser!, lp),
          style: ElevatedButton.styleFrom(
            primary: isLightThenBlack(context, reverse: true),
            side: BorderSide(
                width: 2.0, color: Theme.of(context).colorScheme.secondary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
          label: Text(
              lp.shoppingList.any((e) => e.uid == p.selectedUser!.uid)
                  ? 'Remove'
                  : 'Add',
              style: TextStyle(color: isLightThenBlack(context))),
          icon: Icon(
            lp.shoppingList.any((e) => e.uid == p.selectedUser!.uid)
                ? Icons.remove_shopping_cart_outlined
                : Icons.add_shopping_cart_outlined,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        Spacer(),
      ]);
    });
  }
}

void Function() _onAddToShoppingList(
    BuildContext ctx, User u, LangameProvider lp) {
  return () {
    var msg = 'The Langame is full!';
    if (lp.shoppingList.length < 4) {
      lp.add(u);
      msg = '${u.displayName} has been added to current Langame';
    }
    final snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
  };
}

void Function() _onRemoveFromShoppingList(
    BuildContext ctx, User u, LangameProvider lp) {
  return () {
    lp.remove(u);
    final snackBar = SnackBar(
        content:
            Text('${u.displayName} has been removed from current Langame'));
    ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
  };
}
