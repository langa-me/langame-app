import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/user.dart';
import 'package:langame/providers/profile_provider.dart';
import 'package:provider/provider.dart';

import 'image.dart';

class Profile extends StatelessWidget {
  final LangameUser _user;
  final bool isSelf;
  Profile(this._user, {this.isSelf = false});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var children = [
      Align(
        alignment: Alignment.topCenter,
        child: Column(children: [
          buildCroppedRoundedNetworkImage(_user.photoUrl!,
              width: AppSize.blockSizeHorizontal * 30),
          Text(
            _user.displayName!,
            style: theme.textTheme.headline6!.merge(
              TextStyle(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).colorScheme.primary
                      : Colors.white),
            ),
            textAlign: TextAlign.center,
          )
        ]),
      ),
    ];
    if (isSelf) {
      children.insert(
        0,
        Align(
          alignment: Alignment.topRight,
          child: Material(
            child: IconButton(
              icon: Icon(Icons.settings),
              color: theme.colorScheme.secondary,
              onPressed: () {
                Provider.of<ProfileProvider>(context, listen: false)
                    .profileShown = false;
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SettingsTwo()),
                // );
              },
            ),
          ),
        ),
      );
    }
    // TODO: maybe instead something scrollable
    return Column(children: children);
  }
}
