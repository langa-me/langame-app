import 'package:langame/models/langame/protobuf/langame.pb.dart';

import 'firebase.dart';

abstract class TopicApi {
  final FirebaseApi firebase;

  TopicApi(this.firebase);

  Future<List<Topic>> getTopics();
}
