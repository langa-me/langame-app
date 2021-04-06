import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:langame/models/topic.dart';
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
  final List<Topic> _topics = [];
  List<Topic> get topics => _topics;

  Future<void> getAllTopics() async {
    _topics.clear();
    (await _api.getTopics()).forEach((element) {
      _topics.add(element);
      notifyListeners();
    });
  }

  TopicProvider({bool fake = true}) {
    _fake = fake;
    _api = _fake ? FakeTopicApi() : ImplTopicApi();
  }
}
