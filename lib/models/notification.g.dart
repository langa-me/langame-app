// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LangameNotification _$LangameNotificationFromJson(Map<String, dynamic> json) {
  return LangameNotification(
    json['senderUid'] as String,
    (json['recipientsUid'] as List<dynamic>).map((e) => e as String).toList(),
  )
    ..id = json['id'] as String?
    ..topics =
        (json['topics'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..channelName = json['channelName'] as String?
    ..ready = json['ready'] as bool?;
}

Map<String, dynamic> _$LangameNotificationToJson(
        LangameNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderUid': instance.senderUid,
      'recipientsUid': instance.recipientsUid,
      'topics': instance.topics,
      'channelName': instance.channelName,
      'ready': instance.ready,
    };
