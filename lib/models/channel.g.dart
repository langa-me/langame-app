// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelUserLangameUser _$ChannelUserLangameUserFromJson(
    Map<String, dynamic> json) {
  return ChannelUserLangameUser(
    json['channelUid'] as int,
    json['langameUid'] as String,
  );
}

Map<String, dynamic> _$ChannelUserLangameUserToJson(
        ChannelUserLangameUser instance) =>
    <String, dynamic>{
      'channelUid': instance.channelUid,
      'langameUid': instance.langameUid,
    };

LangameChannel _$LangameChannelFromJson(Map<String, dynamic> json) {
  return LangameChannel(
    json['channelName'] as String,
    (json['players'] as List<dynamic>)
        .map((e) => ChannelUserLangameUser.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['topics'] as List<dynamic>).map((e) => e as String).toList(),
    (json['questions'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$LangameChannelToJson(LangameChannel instance) =>
    <String, dynamic>{
      'channelName': instance.channelName,
      'players': instance.players,
      'topics': instance.topics,
      'questions': instance.questions,
    };
