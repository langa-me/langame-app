import 'package:flutter/material.dart';
import 'package:langame/models/user.dart';

/// Handles state of a before-Langame "shop list"
/// i.e. which players will be invited, topic etc.
/// TODO: might handle in-game state
class LangameProvider extends ChangeNotifier {
  /// Players to be invited
  List<LangameUser> _shoppingList = [];
  // TODO might use a stream if its not too overkill
  List<LangameUser> get shoppingList => _shoppingList;

  void add(LangameUser player) {
    _shoppingList.add(player);
    notifyListeners();
  }

  void remove(LangameUser player) {
    _shoppingList.removeWhere((e) => e.uid == player.uid);
    notifyListeners();
  }
}
