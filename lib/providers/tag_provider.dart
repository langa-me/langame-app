import 'dart:core';

import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/services/http/firebase.dart';

class TagProvider extends ChangeNotifier {
  TagProvider(this.firebase, this._cap, this._algolia, this._pp);
  final FirebaseApi firebase;
  final CrashAnalyticsProvider _cap;
  final Algolia? _algolia;
  final PreferenceProvider _pp;

  void query(String value) async {
    if (value.isEmpty) {
      resetFilteredTopicSearchTagHistory();
      return;
    }

    final i = _algolia?.index('prod_topics');
    final o = await i?.query('$value').getObjects();
    filteredTopicSearchHistory = o?.hits
        .map((e) => e.data['objectID'] as String)
        .toList()
        .reversed
        .toList();
  }

  List<String> _filteredTopicSearchHistory = [];
  List<String> get filteredTopicSearchHistory => _filteredTopicSearchHistory;
  set filteredTopicSearchHistory(v) {
    _filteredTopicSearchHistory = v;
    notifyListeners();
  }

  Set<String> _selectedTopics = {};
  Set<String> get selectedTopics => _selectedTopics;
  void addToSelectedTopic(String v) {
    _cap.sendClickTopic(v);
    _selectedTopics.add(v);
    notifyListeners();
  }

  void removeFromSelectedTopic(String v) {
    _cap.sendClickTopic(v);
    _selectedTopics.remove(v);
    notifyListeners();
  }

  static const _historyLength = 5;

  void addTopicSearchHistory(String topic) {
    _pp.preference!.topicSearchHistory.add(topic);
    if (_pp.preference!.topicSearchHistory.length > _historyLength) {
      for (var i = _pp.preference!.topicSearchHistory.length;
          i > _historyLength;
          i--) {
        _pp.preference!.topicSearchHistory
            .remove(_pp.preference!.topicSearchHistory.elementAt(i));
      }
    }
    _cap.log('tag_provider:addTopicSearchHistory');

    notifyListeners();
    firebase.analytics
        ?.logEvent(name: 'add_topic_history', parameters: {'topic': topic});
  }

  void placeFirstTopicSearchHistory(String topic) {
    _cap.log('tag_provider:placeFirstTopicSearchHistory');

    _pp.preference!.topicSearchHistory.removeWhere((e) => e == topic);
    _pp.preference!.topicSearchHistory.add(topic);
  }

  void deleteTopicSearchHistory(String tag) {
    _cap.log('tag_provider:deleteTopicSearchHistory');

    _pp.preference!.topicSearchHistory.removeWhere((e) => e == tag);
    _filteredTopicSearchHistory.removeWhere((e) => e == tag);
    notifyListeners();
    firebase.analytics?.logEvent(
        name: 'delete_topic_search_history', parameters: {'tag': tag});
  }

  void resetFilteredTopicSearchTagHistory() {
    _cap.log('tag_provider:resetFilteredTopicSearchTagHistory');

    _filteredTopicSearchHistory = _pp.preference!.topicSearchHistory;
    notifyListeners();
  }
}
