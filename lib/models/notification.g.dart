// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LangameNotification _$LangameNotificationFromJson(Map<String, dynamic> json) {
  return LangameNotification(
    json['id'] as String,
    json['senderUid'] as String,
    json['recipientUid'] as String,
    background: json['background'] as bool?,
  );
}

Map<String, dynamic> _$LangameNotificationToJson(
        LangameNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderUid': instance.senderUid,
      'recipientUid': instance.recipientUid,
      'background': instance.background,
    };

LangameNotificationPlay _$LangameNotificationPlayFromJson(
    Map<String, dynamic> json) {
  return LangameNotificationPlay(
    json['id'],
    json['senderUid'],
    json['recipientUid'],
    json['topic'] as String,
    json['agoraUid'] as int,
    json['agoraChannelName'] as String,
    json['agoraRtcToken'] as String,
    background: json['background'],
  );
}

Map<String, dynamic> _$LangameNotificationPlayToJson(
        LangameNotificationPlay instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderUid': instance.senderUid,
      'recipientUid': instance.recipientUid,
      'background': instance.background,
      'topic': instance.topic,
      'agoraUid': instance.agoraUid,
      'agoraChannelName': instance.agoraChannelName,
      'agoraRtcToken': instance.agoraRtcToken,
    };

LangameNotificationReadyToPlay _$LangameNotificationReadyToPlayFromJson(
    Map<String, dynamic> json) {
  return LangameNotificationReadyToPlay(
    json['id'],
    json['senderUid'],
    json['recipientUid'],
    json['topic'] as String,
    json['question'] as String,
    background: json['background'],
  );
}

Map<String, dynamic> _$LangameNotificationReadyToPlayToJson(
        LangameNotificationReadyToPlay instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderUid': instance.senderUid,
      'recipientUid': instance.recipientUid,
      'background': instance.background,
      'topic': instance.topic,
      'question': instance.question,
    };
