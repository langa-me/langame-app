import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/new_langame_provider.dart';
import 'package:langame/views/buttons/button.dart';
import 'package:provider/provider.dart';

Widget buildUserTile(BuildContext context, lg.User u) {
  final nlp = Provider.of<NewLangameProvider>(context, listen: false);
  final cp = Provider.of<ContextProvider>(context, listen: false);
  return ListTile(
    trailing: u.hasPhotoUrl()
        ? CircleAvatar(
            maxRadius: AppSize.safeBlockHorizontal * 3,
            backgroundImage: NetworkImage(u.photoUrl),
          )
        : CircleAvatar(
            maxRadius: AppSize.safeBlockHorizontal * 3,
            child: Text(u.tag),
          ),
    leading: LangameButton(
      nlp.shoppingList.contains(u)
          ? FontAwesomeIcons.times
          : FontAwesomeIcons.grinTongue,
      onPressed: () {
        if (nlp.shoppingList.contains(u)) {
          nlp.removePlayer(u);
        } else {
          nlp.addPlayer(u);
          cp.pop();
        }
      },
      highlighted: true,
      text: nlp.shoppingList.contains(u) ? 'remove' : 'add',
    ),
  );
}
