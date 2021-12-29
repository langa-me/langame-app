import 'dart:core';
import 'dart:math';

import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/crash_analytics_provider.dart';
import 'package:langame/providers/preference_provider.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:langame/views/topics/most_popular_topics.dart';

class TagProvider extends ChangeNotifier {
  TagProvider(this.firebase, this._cap, this.algolia, this._pp) {
    this.firebase.auth!.authStateChanges().listen((user) {
      if (user == null) {
        _availableTopics = [];
        notifyListeners();
      } else {
        firebase.firestore!.collection('topics').get().then((value) {
          _availableTopics = value.docs.map((doc) => doc.id).toList();
          _cap.log(
              'tag_provider: detected authentication change, updated available topics: $_availableTopics');
          notifyListeners();
        });
      }
    });
  }
  final FirebaseApi firebase;
  final CrashAnalyticsProvider _cap;
  Algolia algolia;
  final PreferenceProvider _pp;
  List<String> _availableTopics = [];
  List<String> get availableTopics => _availableTopics;
  Random _random = new Random(42);

  void setDefaultTopics() {
    // If the user did not select some topics previously,
    // add randomly some of his favorite topics
    // or random most popular ones if he does not have
    // favorite topics
    if (_selectedTopics.isEmpty) {
      final randomNumber = _random.nextInt(3) + 1;
      final someTopics = this._pp.preference.favoriteTopics.isNotEmpty
          ? this._pp.preference.favoriteTopics.take(randomNumber).toList()
          : getMostPopularTopics().take(randomNumber).toList();
      _selectedTopics.addAll(someTopics);
      notifyListeners();
      this
          ._cap
          .log('Randomly selected ${someTopics.length} topics: ${someTopics}');
    }
  }

  void query(String value) async {
    if (value.isEmpty) {
      resetFilteredTopicSearchTagHistory();
      return;
    }

    try {
      final i = algolia.index(AppConst.isDev ? 'dev_topics' : 'prod_topics');
      final o = await i.query('$value').getObjects();
      filteredTopicSearchHistory = o.hits
          .map((e) => e.data['objectID'] as String)
          .toList()
          .reversed
          .toList();
      _cap.log(
          'filteredTopicSearchHistory: $value $filteredTopicSearchHistory');
      notifyListeners();
    } catch (e, s) {
      _cap.log('tag_provider: query error: $e $s');
      _cap.recordError(e, s);
    }
  }

  List<String> _filteredTopicSearchHistory = [];
  List<String> get filteredTopicSearchHistory => _filteredTopicSearchHistory;
  set filteredTopicSearchHistory(List<String> v) {
    _filteredTopicSearchHistory = v;
    notifyListeners();
  }

  Set<String> _selectedTopics = {};
  Set<String> get selectedTopics => _selectedTopics;
  void addToSelectedTopic(String v) {
    _cap.sendClickTopic(v);
    _selectedTopics.add(v);
    _cap.log('tag_provider: added $v to selected topics');
    notifyListeners();
  }

  void removeFromSelectedTopic(String v) {
    _cap.sendClickTopic(v);
    _selectedTopics.remove(v);
    _cap.log('tag_provider: removed $v from selected topics');
    notifyListeners();
  }

  static const _historyLength = 5;

  void addTopicSearchHistory(String topic) {
    _pp.preference.topicSearchHistory.add(topic);
    if (_pp.preference.topicSearchHistory.length > _historyLength) {
      for (var i = _pp.preference.topicSearchHistory.length;
          i > _historyLength;
          i--) {
        _pp.preference.topicSearchHistory
            .remove(_pp.preference.topicSearchHistory.elementAt(i));
      }
    }
    _cap.log('tag_provider:addTopicSearchHistory');

    notifyListeners();
    firebase.analytics
        ?.logEvent(name: 'add_topic_history', parameters: {'topic': topic});
  }

  void placeFirstTopicSearchHistory(String topic) {
    _cap.log('tag_provider:placeFirstTopicSearchHistory');

    _pp.preference.topicSearchHistory.removeWhere((e) => e == topic);
    _pp.preference.topicSearchHistory.add(topic);
  }

  void deleteTopicSearchHistory(String tag) {
    _cap.log('tag_provider:deleteTopicSearchHistory');

    _pp.preference.topicSearchHistory.removeWhere((e) => e == tag);
    _filteredTopicSearchHistory.removeWhere((e) => e == tag);
    notifyListeners();
    firebase.analytics?.logEvent(
        name: 'delete_topic_search_history', parameters: {'tag': tag});
  }

  void resetFilteredTopicSearchTagHistory() {
    _cap.log('tag_provider:resetFilteredTopicSearchTagHistory');

    _filteredTopicSearchHistory = _pp.preference.topicSearchHistory;
    notifyListeners();
  }
}
