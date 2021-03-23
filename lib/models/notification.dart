import 'user.dart';

class LangameNotification {
  final String id;
  Relation relation;
  LangameNotificationType type;
  bool background;
  String topic;

  LangameNotification(this.id, this.relation, this.topic,
      {this.type = LangameNotificationType.INVITATION,
      this.background = false});
}

enum LangameNotificationType {
  INVITATION,
}
