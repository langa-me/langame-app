import 'package:langame/models/topic.dart';

import 'topic_api.dart';

class FakeTopicApi implements TopicApi {
  @override
  Future<List<TopicGroup>> getTopics() async {
    return [
      TopicGroup("Recommendations", ["Nutrition", "Wisdom", "Career"]),
      TopicGroup("Sciences",
          ["Biology", "Physics", "Maths", "Artificial Intelligence"]),
      TopicGroup("Philosophy", ["Purpose", "Love", "Friends"]),
      TopicGroup("Spirituality", ["Religion", "Death", "Meditation"]),
      TopicGroup("Health", ["Body", "Mind", "Fast"]),
      TopicGroup("Wealth", [
        "Stocks",
        "Passive",
        "Active",
        "Bitcoin",
        "Ethereum",
        "VC",
        "Angel Investing"
      ])
    ];
  }
}
