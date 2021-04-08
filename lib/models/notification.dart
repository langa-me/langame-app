import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class LangameNotification {
  String? id;
  String senderUid;
  List<String> recipientsUid;

  /// Topics of the Langame
  List<String>? topics;

  /// Agora channel name
  String? channelName;

  bool? ready;

  LangameNotification(this.senderUid, this.recipientsUid);

  factory LangameNotification.fromJson(Map<String, dynamic> json) =>
      _$LangameNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$LangameNotificationToJson(this);
}
