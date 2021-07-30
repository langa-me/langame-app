import 'package:flutter/material.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;

import 'crash_analytics_provider.dart';

/// Handle the "create new langame"
class NewLangameProvider extends ChangeNotifier {
  NewLangameProvider(this._cap);
  CrashAnalyticsProvider _cap;

  /// Players to be invited
  List<lg.User> _shoppingList = [];
  List<lg.User> get shoppingList => _shoppingList;
  List<lg.Tag> _selectedTopics = [];
  List<lg.Tag> get selectedTopics => _selectedTopics;
  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;
  int _maximumPlayers = 5;
  int get maximumPlayers => _maximumPlayers;

  void addPlayer(lg.User player) {
    _shoppingList.add(player);
    notifyListeners();
  }

  void removePlayer(lg.User player) {
    _shoppingList.removeWhere((e) => e.uid == player.uid);
    notifyListeners();
  }

  void addTopic(lg.Tag topic) {
    _cap.sendClickTopic(topic.topic.content);
    _selectedTopics.add(topic);
    notifyListeners();
  }

  void removeTopic(lg.Tag topic) {
    _cap.sendClickTopic(topic.topic.content);
    _selectedTopics.removeWhere((e) => e.topic.content == topic.topic.content);
    notifyListeners();
  }

  void setSelectedDate(DateTime? date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setMaximumPlayers(int value) {
    _maximumPlayers = value;
    notifyListeners();
  }
}
