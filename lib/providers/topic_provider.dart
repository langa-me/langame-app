import 'dart:async';

import 'package:flutter/material.dart';
import 'package:langame/api/api.pb.dart';
import 'package:langame/services/http/fake_topic_api.dart';
import 'package:langame/services/http/impl_topic_api.dart';
import 'package:langame/services/http/topic_api.dart';

class TopicProvider extends ChangeNotifier {
  /// Defines whether it's fake API or real
  bool _fake = true;
  late TopicApi _api;
  final _streamController = StreamController<TopicGroup>();

  Stream<TopicGroup> get topicStream {
    return _streamController.stream;
  }

  Future<void> getAllTopics() async {
    (await _api.getTopics()).forEach((element) {
      _streamController.add(element);
    });
  }

  TopicProvider({bool fake = true}) {
    _fake = fake;
    _api = _fake ? FakeTopicApi() : ImplTopicApi();
  }
}
