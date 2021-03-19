import 'package:langame/api/api.pb.dart';

import 'topic_api.dart';

class FakeTopicApi implements TopicApi {
  @override
  Future<List<TopicGroup>> getTopics() async {
    return [
      TopicGroup(
          name: "Recommendations", topics: ["Nutrition", "Wisdom", "Career"]),
      TopicGroup(
          name: "Sciences",
          topics: ["Biology", "Physics", "Maths", "Artificial Intelligence"]),
      TopicGroup(name: "Philosophy", topics: ["Purpose", "Love", "Friends"]),
      TopicGroup(
          name: "Spirituality", topics: ["Religion", "Death", "Meditation"]),
      TopicGroup(name: "Health", topics: ["Body", "Mind", "Fast"]),
      TopicGroup(name: "Wealth", topics: [
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
