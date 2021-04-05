import 'package:json_annotation/json_annotation.dart';
import 'package:langame/models/user.dart';

part 'relation.g.dart';

/// Evaluated relationship between users using AI + heuristics
@JsonSerializable()
class Relation {
  final LangameUser other;
  final RelationLevel level;

  // Langame played together
  //  int64 interactions = 1;

  Relation(this.other, {this.level = RelationLevel.BAD});
}

enum RelationLevel {
  // TODO: temporary
  BAD,
  AVERAGE,
  GREAT,
}
