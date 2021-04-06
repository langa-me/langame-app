import 'package:langame/models/topic.dart';

abstract class TopicApi {
  Future<List<Topic>> getTopics();
}
