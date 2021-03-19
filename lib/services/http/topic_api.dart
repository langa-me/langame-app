import 'package:langame/api/api.pb.dart';

abstract class TopicApi {
  Future<List<TopicGroup>> getTopics();
}
