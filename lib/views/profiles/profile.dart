import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/user.dart';

import '../images/image.dart';

class Profile extends StatelessWidget {
  final LangameUser _user;
  Profile(this._user);

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
    // TODO: maybe instead something scrollable
    return Column(children: children);
  }
}
