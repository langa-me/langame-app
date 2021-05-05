import 'dart:async';

import 'package:langame/helpers/constants.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart';
import 'package:langame/services/http/firebase.dart';

import 'topic_api.dart';

class ImplTopicApi extends TopicApi {
  ImplTopicApi(FirebaseApi firebase) : super(firebase);

  @override
  Stream<Iterable<Topic>> streamTopics() {
    return firebase.firestore!
        .collection(AppConst.firestoreTopicsCollection)
        .snapshots()
        .map((s) => s.docs
            .where((e) => e.exists && e.data()['content'] != null)
            .map((e) => Topic(id: e.id, content: e.data()['content'])));
  }
}
