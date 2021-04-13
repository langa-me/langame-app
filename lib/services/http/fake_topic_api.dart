import 'package:langame/models/question.dart';

import 'topic_api.dart';

class FakeTopicApi implements TopicApi {
  @override
  Future<List<Question>> getTopics() async {
    return [
      Question("Nutrition", ["Recommendations"]),
      Question("Wisdom", ["Recommendations"]),
      Question("Career", ["Recommendations"]),
      Question("Biology", ["Sciences"]),
      Question("Physics", ["Sciences"]),
      Question("Maths", ["Sciences"]),
      Question("Artificial Intelligence", ["Sciences"]),
      Question("Purpose", ["Philosophy"]),
      Question("Love", ["Philosophy"]),
      Question("Friends", ["Philosophy"]),
      Question("Religion", ["Spirituality"]),
      Question("Death", ["Spirituality"]),
      Question("Meditation", ["Spirituality"]),
      Question("Body", ["Health"]),
      Question("Mind", ["Health"]),
      Question("Fast", ["Health"]),
      Question("Stocks", ["Wealth"]),
      Question("Passive", ["Wealth"]),
      Question("Active", ["Wealth"]),
      Question("Bitcoin", ["Wealth"]),
      Question("Ethereum", ["Wealth"]),
      Question("Venture Capitalism", ["Wealth"]),
      Question("Angel Investing", ["Wealth"]),
    ];
  }
}
