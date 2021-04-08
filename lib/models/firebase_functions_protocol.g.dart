// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_functions_protocol.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseFunctionsResponse _$FirebaseFunctionsResponseFromJson(
    Map<String, dynamic> json) {
  return FirebaseFunctionsResponse(
    _$enumDecode(
        _$FirebaseFunctionsResponseStatusCodeEnumMap, json['statusCode']),
    json['errorMessage'] as String?,
  )..results =
      (json['results'] as List<dynamic>?)?.map((e) => e as String).toList();
}

Map<String, dynamic> _$FirebaseFunctionsResponseToJson(
        FirebaseFunctionsResponse instance) =>
    <String, dynamic>{
      'statusCode':
          _$FirebaseFunctionsResponseStatusCodeEnumMap[instance.statusCode],
      'errorMessage': instance.errorMessage,
      'results': instance.results,
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

const _$FirebaseFunctionsResponseStatusCodeEnumMap = {
  FirebaseFunctionsResponseStatusCode.OK: 200,
  FirebaseFunctionsResponseStatusCode.BAD_REQUEST: 400,
  FirebaseFunctionsResponseStatusCode.UNAUTHORIZED: 401,
  FirebaseFunctionsResponseStatusCode.INTERNAL: 500,
};
