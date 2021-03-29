// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LangameNotification _$LangameNotificationFromJson(Map<String, dynamic> json) {
  return LangameNotification(
    json['id'] as String,
    json['senderUid'] as String,
    background: json['background'] as bool,
  );
}

Map<String, dynamic> _$LangameNotificationToJson(
        LangameNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderUid': instance.senderUid,
      'background': instance.background,
    };

LangameNotificationPlay _$LangameNotificationPlayFromJson(
    Map<String, dynamic> json) {
  return LangameNotificationPlay(
    json['id'],
    json['senderUid'],
    json['topic'] as String,
    background: json['background'],
  );
}

Map<String, dynamic> _$LangameNotificationPlayToJson(
        LangameNotificationPlay instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderUid': instance.senderUid,
      'background': instance.background,
      'topic': instance.topic,
    };
