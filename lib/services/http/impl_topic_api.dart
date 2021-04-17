import 'package:langame/helpers/constants.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart';
import 'package:langame/services/http/firebase.dart';

import 'topic_api.dart';

class ImplTopicApi extends TopicApi {
  ImplTopicApi(FirebaseApi firebase) : super(firebase);

  @override
  Future<List<Topic>> getTopics() async {
    var query = await firebase.firestore!
        .collection(AppConst.firestoreTopicsCollection)
        .get();
    return query.docs
        .where((e) => e.exists == true && e.data()['content'] != null)
        .map((e) => Topic(id: e.id, content: e.data()['content']))
        .toList();
  }
}
