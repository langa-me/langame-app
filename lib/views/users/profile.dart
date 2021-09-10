import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;

class Profile extends StatelessWidget {
  final lg.User _user;
  Profile(this._user);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      _user.hasPhotoUrl() ? Text(
        _user.tag,
        style: theme.textTheme.headline6,
        textAlign: TextAlign.center,
      ) : SizedBox.shrink(),
      _user.hasPhotoUrl()
                                      ? CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              _user.photoUrl),
                                        )
                                      : CircleAvatar(
                                          child: Text(_user.tag),
                                        ),
    ]);
  }
}
