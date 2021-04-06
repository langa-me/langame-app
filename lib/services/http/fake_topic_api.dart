import 'package:langame/models/topic.dart';

import 'topic_api.dart';

class FakeTopicApi implements TopicApi {
  @override
  Future<List<Topic>> getTopics() async {
    return [
      Topic("Nutrition", ["Recommendations"]),
      Topic("Wisdom", ["Recommendations"]),
      Topic("Career", ["Recommendations"]),
      Topic("Biology", ["Sciences"]),
      Topic("Physics", ["Sciences"]),
      Topic("Maths", ["Sciences"]),
      Topic("Artificial Intelligence", ["Sciences"]),
      Topic("Purpose", ["Philosophy"]),
      Topic("Love", ["Philosophy"]),
      Topic("Friends", ["Philosophy"]),
      Topic("Religion", ["Spirituality"]),
      Topic("Death", ["Spirituality"]),
      Topic("Meditation", ["Spirituality"]),
      Topic("Body", ["Health"]),
      Topic("Mind", ["Health"]),
      Topic("Fast", ["Health"]),
      Topic("Stocks", ["Wealth"]),
      Topic("Passive", ["Wealth"]),
      Topic("Active", ["Wealth"]),
      Topic("Bitcoin", ["Wealth"]),
      Topic("Ethereum", ["Wealth"]),
      Topic("Venture Capitalism", ["Wealth"]),
      Topic("Angel Investing", ["Wealth"]),
    ];
  }
}
