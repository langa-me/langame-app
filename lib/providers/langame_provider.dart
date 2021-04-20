import 'package:flutter/material.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;

/// Handles state of a before-Langame "shop list"
/// i.e. which players will be invited, topic etc.
/// TODO: might handle in-game state
class LangameProvider extends ChangeNotifier {
  /// Players to be invited
  List<lg.User> _shoppingList = [];
  // TODO might use a stream if its not too overkill
  List<lg.User> get shoppingList => _shoppingList;

  void add(lg.User player) {
    _shoppingList.add(player);
    notifyListeners();
  }

  void remove(lg.User player) {
    _shoppingList.removeWhere((e) => e.uid == player.uid);
    notifyListeners();
  }
}
