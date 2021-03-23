import 'package:langame/models/topic.dart';

abstract class TopicApi {
  Future<List<TopicGroup>> getTopics();
}
