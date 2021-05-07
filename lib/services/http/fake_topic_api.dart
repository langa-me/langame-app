import 'dart:async';

import 'package:langame/models/langame/protobuf/langame.pb.dart';
import 'package:langame/services/http/firebase.dart';

import 'topic_api.dart';

class FakeTopicApi extends TopicApi {
  FakeTopicApi(FirebaseApi firebase) : super(firebase);

  @override
  Stream<Iterable<Topic>> streamTopics() {
    throw UnimplementedError();
  }
}
