import 'package:flutter/material.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/new_langame_provider.dart';

void Function() onAddToShoppingList(
    User u, NewLangameProvider lp, ContextProvider cp, void Function(int, {Curve? curve}) goToPage) {
  return () {
    var msg = 'The Langame is full!';
    if (lp.shoppingList.length < 4) {
      lp.addPlayer(u);
      msg = '${u.tag} has been added to current Langame 😛';
    }
    cp.showSnackBar(msg);
  };
}

void Function() onRemoveFromShoppingList(
    User u, NewLangameProvider lp, ContextProvider cp, void Function(int, {Curve? curve}) goToPage) {
  return () {
    lp.removePlayer(u);
    cp.showSnackBar('${u.tag} has been removed from current Langame 😛');
  };
}
