import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class LangameNotification {
  final String id;
  String senderUid;
  bool? background;

  LangameNotification(this.id, this.senderUid, {this.background = false});

  factory LangameNotification.fromJson(Map<String, dynamic> json) =>
      _$LangameNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$LangameNotificationToJson(this);
}

@JsonSerializable()
class LangameNotificationPlay extends LangameNotification {
  LangameNotificationPlay(id, senderUid, this.topic, this.agoraUid,
      this.agoraChannelName, this.agoraRtcToken,
      {background = false})
      : super(id, senderUid, background: background);

  /// Topic of the Langame
  String topic;

  /// Self agora user id in the channel
  int agoraUid;

  /// Agora channel name
  String agoraChannelName;

  /// Agora RTC token for this channel and user
  String agoraRtcToken;

  factory LangameNotificationPlay.fromJson(Map<String, dynamic> json) =>
      _$LangameNotificationPlayFromJson(json);

  Map<String, dynamic> toJson() => _$LangameNotificationPlayToJson(this);
}

@JsonSerializable()
class LangameNotificationReadyToPlay extends LangameNotification {
  LangameNotificationReadyToPlay(id, senderUid, this.topic, this.question,
      {background = false})
      : super(id, senderUid, background: background);
  String topic;
  String question;

  factory LangameNotificationReadyToPlay.fromJson(Map<String, dynamic> json) =>
      _$LangameNotificationReadyToPlayFromJson(json);

  Map<String, dynamic> toJson() => _$LangameNotificationReadyToPlayToJson(this);
}
