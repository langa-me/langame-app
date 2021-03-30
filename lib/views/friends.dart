import 'dart:async';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/extension.dart';
import 'package:langame/models/user.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/profile_provider.dart';
import 'package:langame/views/notifications.dart';
import 'package:langame/views/profile.dart';
import 'package:langame/views/send_langame.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

import 'buttons/button.dart';
import 'image.dart';
import 'overlay.dart';
import 'painters/circle.dart';

class FriendsView extends StatefulWidget {
  @override
  _FriendsViewState createState() => _FriendsViewState();
}

/// Main page of Langame (temporary name...)
class _FriendsViewState extends State<FriendsView> {
  LangameUser? _user;

  int _selectedIndex = 0;
  static const historyLength = 5;

  List<String> _searchTagHistory = [];
  List<LangameUser> _searchUserHistory = [];

  List<String> filteredTagSearchHistory = [];
  List<LangameUser> filteredUserSearchHistory = [];

  String? selectedTag;
  LangameUser? selectedUser;

  late FloatingSearchBarController controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filterSearchTags(filter: null).then((v) {
      filteredUserSearchHistory = v;
      filteredTagSearchHistory = v.map((e) => e.tag!).toList();
    });
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
                  _user != null ? Profile(_user!, isSelf: true) : Scaffold(),
                ])),
          );
        },
        child: GestureDetector(
          // TODO: maybe pageview instead
          onHorizontalDragEnd: (details) {
            _onBottomBarItemTapped(_selectedIndex + 1);
          },
          onTap: () {
            profileProvider.profileShown = false;
          },
          child: Consumer<AuthenticationProvider>(builder: (context, a, child) {
            var noLangameRelations = Align(
              child: Text('No friends on Langame yet?\nInvite them!',
                  style: theme.textTheme.headline5,
                  textAlign: TextAlign.center),
            );
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

  Future<List<LangameUser>> filterSearchTags({
    String? filter,
  }) async {
    if (filter != null && filter.isNotEmpty) {
      return await Provider.of<AuthenticationProvider>(context, listen: false)
          .getLangameUsersStartingWithTag(filter);
    }
    return _searchUserHistory.reversed.toList();
  }

  void addSearchTag(String tag) async {
    if (_searchTagHistory.contains(tag)) {
      putSearchTagFirst(tag);
      return;
    }

    _searchTagHistory.add(tag);
    _searchUserHistory
        .add(filteredUserSearchHistory.firstWhere((e) => e.tag == tag));
    if (_searchTagHistory.length > historyLength) {
      _searchTagHistory.removeRange(
          0, _searchTagHistory.length - historyLength);
      _searchUserHistory.removeRange(
          0, _searchUserHistory.length - historyLength);
    }

    filteredUserSearchHistory = await filterSearchTags();
    filteredTagSearchHistory =
        filteredUserSearchHistory.map((e) => e.tag!).toList();
  }

  void deleteSearchTag(String tag) async {
    _searchTagHistory.removeWhere((t) => t == tag);
    _searchUserHistory.removeWhere((t) => t.tag == tag);
    filteredUserSearchHistory = await filterSearchTags();
    filteredTagSearchHistory =
        filteredUserSearchHistory.map((e) => e.tag!).toList();
  }

  void putSearchTagFirst(String tag) {
    deleteSearchTag(tag);
    addSearchTag(tag);
  }

  Widget _buildSearchFriends() {
    return FloatingSearchBar(
      queryStyle: Theme.of(context).textTheme.headline6,
      controller: controller,
      body: FloatingSearchBarScrollNotifier(
        child: Container(
          // Padding top of default FloatingSearchBar height (48) + app size * 5
          padding: EdgeInsets.only(top: 48 + AppSize.safeBlockVertical * 5),
          constraints: BoxConstraints.expand(),
          child: SearchResultsListView(
            searchUser: selectedUser,
          ),
        ),
      ),
      transition: CircularFloatingSearchBarTransition(),
      physics: BouncingScrollPhysics(),
      title: Text(
        selectedTag ?? 'Search for new faces',
        style: Theme.of(context).textTheme.headline6,
      ),
      hint: 'Search and find out...',
      actions: [
        FloatingSearchBarAction.searchToClear(),
      ],
      onQueryChanged: (query) {
        filterSearchTags(filter: query).then((v) {
          setState(() {
            filteredUserSearchHistory = v;
            filteredTagSearchHistory =
                filteredUserSearchHistory.map((e) => e.tag!).toList();
          });
        });
      },
      onSubmitted: (query) {
        setState(() {
          addSearchTag(query);
          selectedTag = query;
        });
        controller.close();
      },
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Theme.of(context).primaryColor,
            elevation: 4,
            child: Builder(
              builder: (context) {
                if (filteredTagSearchHistory.isEmpty &&
                    controller.query.isEmpty) {
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
                } else if (filteredTagSearchHistory.isEmpty) {
                  return ListTile(
                    title: Text(controller.query,
                        style: Theme.of(context).textTheme.headline6),
                    leading: const Icon(Icons.search),
                    onTap: () {
                      setState(() {
                        addSearchTag(controller.query);
                        selectedTag = controller.query;
                        selectedUser = filteredUserSearchHistory
                            .firstWhere((e) => e.tag == controller.query);
                      });
                      controller.close();
                    },
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: filteredTagSearchHistory
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
                                setState(() {
                                  deleteSearchTag(tag);
                                });
                              },
                            ),
                            onTap: () {
                              setState(() {
                                putSearchTagFirst(tag);
                                selectedTag = tag;
                                selectedUser = filteredUserSearchHistory
                                    .firstWhere((e) => e.tag == tag);
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
      selectedTag = null;
      selectedUser = null;
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
          backgroundColor: theme.colorScheme.primary,
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
          MaterialPageRoute(builder: (context) => SendLangameView(o)),
        );
      },
      leading: InkWell(
          onTap: () {
            print('should show profile');
          },
          child: buildCroppedRoundedNetworkImage(o.photoUrl)),
      title: Row(children: [
        CustomPaint(painter: o.online ? DrawCircle() : null),
        SizedBox(width: 10),
        Text('${o.displayName}', style: theme.textTheme.button),
      ]),
      tileColor: Color.lerp(a.relations!.relations[index].level.toColor(),
          theme.colorScheme.primary, 0.5),
    );
  }
}

class SearchResultsListView extends StatelessWidget {
  final LangameUser? searchUser;

  const SearchResultsListView({
    Key? key,
    this.searchUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (searchUser == null) {
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
      Profile(searchUser!),
      Spacer(),
      StretchableButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SendLangameView(searchUser!)),
          );
        },
        borderRadius: 2,
        splashColor: Theme.of(context).colorScheme.secondaryVariant,
        buttonPadding: 5,
        buttonColor: Theme.of(context).colorScheme.secondary,
        children: [
          Text('Send a Langame'),
          Container(
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            child: Image.asset('images/logo.png',
                width: AppSize.blockSizeHorizontal * 5),
          ),
        ],
      ),
    ]);
  }
}
