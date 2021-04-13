import 'package:langame/models/question.dart';

abstract class TopicApi {
  Future<List<Question>> getTopics();
}
