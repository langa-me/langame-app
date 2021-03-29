// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_protocol.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseMessage _$FirebaseMessageFromJson(Map<String, dynamic> json) {
  return FirebaseMessage(
    _$enumDecode(_$LangameStatusCodeEnumMap, json['statusCode']),
    json['errorMessage'] as String?,
  );
}

Map<String, dynamic> _$FirebaseMessageToJson(FirebaseMessage instance) =>
    <String, dynamic>{
      'statusCode': _$LangameStatusCodeEnumMap[instance.statusCode],
      'errorMessage': instance.errorMessage,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$LangameStatusCodeEnumMap = {
  LangameStatusCode.OK: 200,
  LangameStatusCode.BAD_REQUEST: 400,
  LangameStatusCode.UNAUTHORIZED: 401,
};

FirebaseMessageSendLangame _$FirebaseMessageSendLangameFromJson(
    Map<String, dynamic> json) {
  return FirebaseMessageSendLangame(
    _$enumDecode(_$LangameStatusCodeEnumMap, json['statusCode']),
    json['errorMessage'] as String?,
    json['result'] as String?,
  );
}

Map<String, dynamic> _$FirebaseMessageSendLangameToJson(
        FirebaseMessageSendLangame instance) =>
    <String, dynamic>{
      'statusCode': _$LangameStatusCodeEnumMap[instance.statusCode],
      'errorMessage': instance.errorMessage,
      'result': instance.result,
    };
