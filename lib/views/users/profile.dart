import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;

import '../images/image.dart';

class Profile extends StatelessWidget {
  final lg.User _user;
  Profile(this._user);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Text(
        _user.tag,
        style: theme.textTheme.headline6,
        textAlign: TextAlign.center,
      ),
      buildCroppedRoundedNetworkImage(_user.photoUrl,
          width: AppSize.blockSizeHorizontal * 20),
    ]);
  }
}
