import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/user.dart';
import 'package:langame/providers/profile_provider.dart';
import 'package:langame/views/settings.dart';
import 'package:provider/provider.dart';

import 'image.dart';

class Profile extends StatefulWidget {
  final LangameUser _user;
  Profile(this._user);

  @override
  _ProfileState createState() => _ProfileState(_user);
}

class _ProfileState extends State<Profile> {
  LangameUser _user;
  _ProfileState(this._user);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color appBarColor = theme.appBarTheme.color ?? theme.primaryColor;

    final provider = Provider.of<ProfileProvider>(context, listen: false);
    return Column(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          color: appBarColor.withOpacity(0.9),
          height: 500,
          width: 400,
          padding: EdgeInsets.all(24),
          child: SizedBox(
            child: Stack(children: [
              Align(
                  alignment: Alignment.topRight,
                  child: Material(
                      child: IconButton(
                    icon: Icon(Icons.settings),
                    color: theme.colorScheme.secondary,
                    onPressed: () {
                      provider.profileShown = false;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsTwo()),
                      );
                    },
                  ))),
              Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildCroppedRoundedNetworkImage(_user.photoUrl!,
                            width: AppSize.blockSizeHorizontal * 30),
                        Text(
                          _user.displayName!,
                          style: theme.appBarTheme.textTheme!.headline4,
                        )
                      ]))
            ]),
          ),
        ),
      ),
    ]);
  }
}
