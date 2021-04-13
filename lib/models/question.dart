import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question {
  String question;

  /// Classified as? i.e. topic "nutrition" is group "health,well being ..."
  List<String> tags;

  Question(this.question, this.tags);

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
