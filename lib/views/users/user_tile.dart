import 'package:flutter/material.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/new_langame_provider.dart';
import 'package:langame/views/users/shopping_list.dart';
import 'package:provider/provider.dart';

Widget buildUserTile(BuildContext context, NewLangameProvider lp, lg.User u,
        void Function(int, {Curve? curve}) goToPage) =>
    ListTile(
      leading: u.hasPhotoUrl()
          ? CircleAvatar(
              backgroundImage: NetworkImage(u.photoUrl),
            )
          : CircleAvatar(
              child: Text(u.tag),
            ),
      trailing: MaterialButton(
        // TODO: might use ToggleButton instead? (with icon)
        onPressed: lp.shoppingList.any((e) => e.uid == u.uid)
            ? onRemoveFromShoppingList(u, lp,
                Provider.of<ContextProvider>(context, listen: false), goToPage)
            : onAddToShoppingList(u, lp,
                Provider.of<ContextProvider>(context, listen: false), goToPage),
        splashColor: Theme.of(context).colorScheme.secondaryVariant,
        color: Theme.of(context).colorScheme.secondary,
        shape: CircleBorder(),
        child: Icon(
          lp.shoppingList.any((e) => e.uid == u.uid)
              ? Icons.remove_shopping_cart_outlined
              : Icons.add_shopping_cart_outlined,
          color: Colors.black,
        ),
      ),
    );
