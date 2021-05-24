import 'dart:core';

import 'package:flutter/material.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart';
import 'package:langame/services/http/firebase.dart';
import 'package:langame/services/http/impl_topic_api.dart';
import 'package:langame/services/http/topic_api.dart';
import 'package:ordered_set/comparing.dart';
import 'package:ordered_set/ordered_set.dart';

class TopicProvider extends ChangeNotifier {
  final FirebaseApi firebase;

  late TopicApi _api;
  final OrderedSet<Topic> _topics =
      OrderedSet<Topic>(Comparing.on((e) => e.content));
  OrderedSet<Topic> get topics => _topics;

  TopicProvider(this.firebase) {
    _api = ImplTopicApi(firebase);
    _api.streamTopics().listen((snap) => snap.forEach((t) {
          if (_topics.add(t)) notifyListeners();
        }));
  }
}
