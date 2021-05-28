import 'package:flutter/material.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;

/// Handle the "create new langame"
class NewLangameProvider extends ChangeNotifier {
  /// Players to be invited
  List<lg.User> _shoppingList = [];
  List<lg.User> get shoppingList => _shoppingList;
  List<lg.Topic> _selectedTopics = [];
  List<lg.Topic> get selectedTopics => _selectedTopics;
  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  void addPlayer(lg.User player) {
    _shoppingList.add(player);
    notifyListeners();
  }

  void removePlayer(lg.User player) {
    _shoppingList.removeWhere((e) => e.uid == player.uid);
    notifyListeners();
  }

  void addTopic(lg.Topic topic) {
    _selectedTopics.add(topic);
    notifyListeners();
  }

  void removeTopic(lg.Topic topic) {
    _selectedTopics.removeWhere((e) => e.id == topic.id);
    notifyListeners();
  }

  void setSelectedDate(DateTime? date) {
    _selectedDate = date;
    notifyListeners();
  }
}
