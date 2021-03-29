import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class LangameNotification {
  final String id;
  String senderUid;
  bool background;

  LangameNotification(this.id, this.senderUid, {this.background = false});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$LangameUserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory LangameNotification.fromJson(Map<String, dynamic> json) =>
      _$LangameNotificationFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$LangameUserToJson`.
  Map<String, dynamic> toJson() => _$LangameNotificationToJson(this);
}

@JsonSerializable()
class LangameNotificationPlay extends LangameNotification {
  LangameNotificationPlay(id, senderUid, this.topic, {background = false})
      : super(id, senderUid, background: background);
  String topic;
}
