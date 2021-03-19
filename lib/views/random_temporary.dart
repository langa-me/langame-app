import 'package:flutter/material.dart';
import 'package:langame/api/api.pb.dart';
import 'package:langame/api/extension.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/profile_provider.dart';
import 'package:langame/views/profile.dart';
import 'package:provider/provider.dart';

import 'image.dart';
import 'overlay.dart';
import 'topic.dart';

class RandomTemporary extends StatefulWidget {
  @override
  _RandomTemporaryState createState() => _RandomTemporaryState();
}

/// Main page of Langame (temporary name...)
class _RandomTemporaryState extends State<RandomTemporary> {
  LangameUser? _user;

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(actions: <Widget>[
          Consumer2<AuthenticationProvider, ProfileProvider>(builder:
              (context, authenticationProvider, profileProvider, child) {
            _user = authenticationProvider.user;
            if (_user != null) {
              return InkWell(
                  onTap: () {
                    profileProvider.profileShown =
                        !profileProvider.profileShown;
                  },
                  child: buildRoundedNetworkImage(_user!.photoUrl));
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
                return ListView.builder(
                  itemCount: a.friends.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TopicView()),
                        );
                      },
                      leading: InkWell(
                          onTap: () {
                            print('should show profile');
                          },
                          child: buildRoundedNetworkImage(
                              a.friends[index].friend.photoUrl,
                              size: 50)),
                      trailing: IconButton(
                          icon: Icon(Icons.whatshot_rounded), onPressed: () {}),
                      title: Text('${a.friends[index].friend.displayName}'),
                      tileColor: a.friends[index].relation.toColor(),
                    );
                  },
                );
              }),
            ),
          );
        }));
  }
}
