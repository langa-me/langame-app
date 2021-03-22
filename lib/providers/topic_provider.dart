import 'dart:async';
import 'dart:collection';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:langame/api/api.pb.dart';
import 'package:langame/services/http/fake_topic_api.dart';
import 'package:langame/services/http/impl_topic_api.dart';
import 'package:langame/services/http/topic_api.dart';

const List<String> hardcodedTopics = <String>[
  'Sciences',
  'Philosophy',
  'Spirituality',
  'Health',
  'Wealth',
];

class TopicProvider extends ChangeNotifier {
  /// Defines whether it's fake API or real
  bool _fake = true;
  late TopicApi _api;
  final List<TopicGroup> _topicGroups = [];
  UnmodifiableListView<TopicGroup> get topicGroups =>
      UnmodifiableListView(_topicGroups);

  Future<void> getAllTopics() async {
    _topicGroups.clear();
    (await _api.getTopics()).forEach((element) {
      _topicGroups.add(element);
      notifyListeners();
    });
  }

  TopicProvider({bool fake = true}) {
    _fake = fake;
    _api = _fake ? FakeTopicApi() : ImplTopicApi();
  }
}
