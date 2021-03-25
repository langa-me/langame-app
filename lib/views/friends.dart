import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/user.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/profile_provider.dart';
import 'package:langame/views/notifications.dart';
import 'package:langame/views/profile.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

import 'image.dart';
import 'overlay.dart';
import 'painters/circle.dart';
import 'topic.dart';

class FriendsView extends StatefulWidget {
  @override
  _FriendsViewState createState() => _FriendsViewState();
}

/// Main page of Langame (temporary name...)
class _FriendsViewState extends State<FriendsView> {
  LangameUser? _user;

  int _selectedIndex = 0;
  static const historyLength = 5;

  List<String> _searchHistory = [
    'fuchsia',
    'flutter',
    'widgets',
    'resocoder',
  ];

  List<String> filteredSearchHistory = [];

  String? selectedTerm;

  late FloatingSearchBarController controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filterSearchTerms(filter: null).then((v) => filteredSearchHistory);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
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
              _user = authenticationProvider.user;
              if (_user != null) {
                return InkWell(
                    onTap: () {
                      profileProvider.profileShown =
                          !profileProvider.profileShown;
                    },
                    child: buildCroppedRoundedNetworkImage(_user!.photoUrl!));
              } else {
                return IconButton(
                    icon: Icon(Icons.account_circle), onPressed: () {});
              }
            })
          ]),
      bottomNavigationBar: _buildBottomNavigationBar(theme),
      body: _buildBody(theme),
    );
  }

  Widget _buildBody(ThemeData theme) {
    /// Friends tab
    if (_selectedIndex == 1) {
      return _buildSearchFriends();
    }

    /// Home tab
    return Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
      return AnchoredOverlay(
        showOverlay: profileProvider.profileShown,
        overlayBuilder: (context, offset) {
          return CenterAbout(
            position: Offset(offset.dx, offset.dy),
            child: Dismissible(
                direction: DismissDirection.vertical,
                key: const Key('key'),
                onDismissed: (_) {
                  profileProvider.profileShown = false;
                },
                child: Column(children: [
                  _user != null ? Profile(_user!) : Scaffold(),
                ])),
          );
        },
        child: GestureDetector(
          onTap: () {
            profileProvider.profileShown = false;
          },
          child: Consumer<AuthenticationProvider>(builder: (context, a, child) {
            var noLangameRelations = Center(
                // TODO: animate search, show random ppl
                child: Text('No friends on Langame yet?\nInvite them!',
                    style: theme.textTheme.headline5,
                    textAlign: TextAlign.center));
            if (a.relations == null) {
              return noLangameRelations;
            }
            // Filter-out external relations
            var langameRelations =
                a.relations!.relations.where((e) => e.other.isALangameUser);
            if (langameRelations.length == 0) {
              return noLangameRelations;
            }
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 4);
              },
              itemCount: a.relations!.relations.length,
              padding: EdgeInsets.all(4.0),
              itemBuilder: (context, index) {
                return _buildFriendTile(index, a, theme);
              },
            );
          }),
        ),
      );
    });
  }

  Future<List<String>> filterSearchTerms({
    String? filter,
  }) async {
    if (filter != null && filter.isNotEmpty) {
      List<LangameUser> r =
          await Provider.of<AuthenticationProvider>(context, listen: false)
              .getLangameUsersStartingWithTag(filter);
      return r.map((e) => e.tag!).toList();
    }
    return _searchHistory.reversed.toList();
    //   return _searchHistory.reversed
    //       .where((term) => term.startsWith(filter))
    //       .toList();
    // } else {
    //   return _searchHistory.reversed.toList();
    // }
  }

  void addSearchTerm(String term) async {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }

    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }

    filteredSearchHistory = await filterSearchTerms();
  }

  void deleteSearchTerm(String term) async {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = await filterSearchTerms();
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  Widget _buildSearchFriends() {
    return FloatingSearchBar(
      controller: controller,
      body: FloatingSearchBarScrollNotifier(
        child: SearchResultsListView(
          searchTerm: selectedTerm,
        ),
      ),
      transition: CircularFloatingSearchBarTransition(),
      physics: BouncingScrollPhysics(),
      title: Text(
        selectedTerm ?? 'Search for new faces',
        style: Theme.of(context).textTheme.headline6,
      ),
      hint: 'Search and find out...',
      actions: [
        FloatingSearchBarAction.searchToClear(),
      ],
      onQueryChanged: (query) {
        filterSearchTerms(filter: query).then((v) {
          setState(() {
            filteredSearchHistory = v;
          });
        });
      },
      onSubmitted: (query) {
        setState(() {
          addSearchTerm(query);
          selectedTerm = query;
        });
        controller.close();
      },
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Theme.of(context).colorScheme.primary,
            elevation: 4,
            child: Builder(
              builder: (context) {
                if (filteredSearchHistory.isEmpty && controller.query.isEmpty) {
                  return Container(
                    height: 56,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'Start searching',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  );
                } else if (filteredSearchHistory.isEmpty) {
                  return ListTile(
                    title: Text(controller.query),
                    leading: const Icon(Icons.search),
                    onTap: () {
                      setState(() {
                        addSearchTerm(controller.query);
                        selectedTerm = controller.query;
                      });
                      controller.close();
                    },
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: filteredSearchHistory
                        .map(
                          (term) => ListTile(
                            title: Text(term,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline6),
                            leading: const Icon(Icons.history),
                            trailing: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  deleteSearchTerm(term);
                                });
                              },
                            ),
                            onTap: () {
                              setState(() {
                                putSearchTermFirst(term);
                                selectedTerm = term;
                              });
                              controller.close();
                            },
                          ),
                        )
                        .toList(),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  void _onBottomBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBottomNavigationBar(ThemeData theme) {
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
          icon: Icon(Icons.search_outlined, color: theme.colorScheme.secondary),
          label: 'Search',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onBottomBarItemTapped,
    );
  }

  Widget _buildFriendTile(
      int index, AuthenticationProvider a, ThemeData theme) {
    var o = a.relations!.relations[index].other;
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TopicView(o)),
        );
      },
      leading: InkWell(
          onTap: () {
            print('should show profile');
          },
          child: buildCroppedRoundedNetworkImage(o.photoUrl ??
              'https://c.files.bbci.co.uk/16620/production/_91408619_55df76d5-2245-41c1-8031-07a4da3f313f.jpg')),
      title: Row(children: [
        CustomPaint(painter: o.status == Status.ONLINE ? DrawCircle() : null),
        SizedBox(width: 10),
        Text('${o.displayName}', style: theme.textTheme.button),
      ]),
      tileColor: Color.lerp(a.relations!.relations[index].level.toColor(),
          theme.colorScheme.primary, 0.5),
    );
  }
}

class SearchResultsListView extends StatelessWidget {
  final String? searchTerm;

  const SearchResultsListView({
    Key? key,
    this.searchTerm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (searchTerm == null) {
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

    final fsb = FloatingSearchBar.of(context);

    return ListView(
      padding:
          EdgeInsets.only(top: fsb!.style.height + fsb.style.margins.vertical),
      children: List.generate(
        50,
        (index) => ListTile(
          title: Text('$searchTerm search result'),
          subtitle: Text(index.toString()),
        ),
      ),
    );
  }
}
