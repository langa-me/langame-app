import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langame/protos/api.pb.dart';

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
    final ColorScheme colorScheme = theme.colorScheme;
    final Color appBarColor = theme.appBarTheme.color ?? theme.primaryColor;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: Container(
          color: theme.appBarTheme.color!.withOpacity(0.8),
          child: SizedBox(
            height: 500,
            width: 400,
            child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {},
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              _user.photoUrl,
                            ),
                            radius: 50.0,
                          )),
                      Text(
                        _user.displayName,
                        style: theme.appBarTheme.textTheme!.headline4,
                      )
                    ])),
          ),
        ),
      ),
    ]);
  }
}
