import 'package:flutter/material.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;

/// Handle the "create new langame"
class NewLangameProvider extends ChangeNotifier {
  /// Players to be invited
  List<lg.User> _shoppingList = [];
  List<lg.User> get shoppingList => _shoppingList;
  List<lg.Tag> _selectedTopics = [];
  List<lg.Tag> get selectedTopics => _selectedTopics;
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

  void addTopic(lg.Tag topic) {
    _selectedTopics.add(topic);
    notifyListeners();
  }

  void removeTopic(lg.Tag topic) {
    _selectedTopics.removeWhere((e) => e.topic.content == topic.topic.content);
    notifyListeners();
  }

  void setSelectedDate(DateTime? date) {
    _selectedDate = date;
    notifyListeners();
  }
}
