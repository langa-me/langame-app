import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/new_langame_provider.dart';
import 'package:langame/views/buttons/button.dart';
import 'package:langame/views/users/user_circle.dart';
import 'package:provider/provider.dart';

Widget buildUserTile(BuildContext context, lg.User u) {
  final nlp = Provider.of<NewLangameProvider>(context, listen: false);
  final cp = Provider.of<ContextProvider>(context, listen: false);
  return ListTile(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildUserCircle(context, u),
        LangameButton(
          nlp.shoppingList.contains(u)
              ? FontAwesomeIcons.times
              : FontAwesomeIcons.plus,
          onPressed: () {
            if (nlp.shoppingList.contains(u)) {
              nlp.removePlayer(u);
            } else {
              nlp.addPlayer(u);
              cp.pop();
            }
          },
        ),
      ],
    ),
  );
}
