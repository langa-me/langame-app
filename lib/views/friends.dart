import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:langame/api/api.pb.dart';
import 'package:langame/api/extension.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/profile_provider.dart';
import 'package:langame/views/notifications.dart';
import 'package:langame/views/profile.dart';
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

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
            leading: InkWell(child:
                Consumer<AuthenticationProvider>(builder: (context, p, c) {
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
                      child: buildCroppedRoundedNetworkImage(_user!.photoUrl));
                } else {
                  return IconButton(
                      icon: Icon(Icons.account_circle), onPressed: () {});
                }
              })
            ]),
        body: Consumer<ProfileProvider>(
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
              child: Consumer<AuthenticationProvider>(
                  builder: (context, a, child) {
                return ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 4);
                  },
                  itemCount: a.relations.length,
                  padding: EdgeInsets.all(4.0),
                  itemBuilder: (context, index) {
                    return _buildFriendTile(index, a, theme);
                  },
                );
              }),
            ),
          );
        }));
  }

  Widget _buildFriendTile(
      int index, AuthenticationProvider a, ThemeData theme) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TopicView(a.relations[index].secondUser)),
        );
      },
      leading: InkWell(
          onTap: () {
            print('should show profile');
          },
          child: buildCroppedRoundedNetworkImage(
              a.relations[index].secondUser.photoUrl)),
      trailing: IconButton(
          icon:
              Icon(Icons.whatshot_rounded, color: theme.colorScheme.secondary),
          onPressed: () {}),
      title: Row(children: [
        CustomPaint(
            painter: a.relations[index].secondUser.status ==
                    LangameUser_Status.ONLINE
                ? DrawCircle()
                : null),
        SizedBox(width: 10),
        Text('${a.relations[index].secondUser.displayName}',
            style: theme.textTheme.button),
      ]),
      tileColor: Color.lerp(
          a.relations[index].level.toColor(), theme.colorScheme.primary, 0.5),
    );
  }
}
