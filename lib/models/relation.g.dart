// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Relation _$RelationFromJson(Map<String, dynamic> json) {
  return Relation(
    LangameUser.fromJson(json['other'] as Map<String, dynamic>),
    level: _$enumDecode(_$RelationLevelEnumMap, json['level']),
  );
}

Map<String, dynamic> _$RelationToJson(Relation instance) => <String, dynamic>{
      'other': instance.other,
      'level': _$RelationLevelEnumMap[instance.level],
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

const _$RelationLevelEnumMap = {
  RelationLevel.BAD: 'BAD',
  RelationLevel.AVERAGE: 'AVERAGE',
  RelationLevel.GREAT: 'GREAT',
};
