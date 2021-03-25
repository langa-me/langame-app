// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LangameUser _$LangameUserFromJson(Map<String, dynamic> json) {
  return LangameUser(
    uid: json['uid'] as String?,
    email: json['email'] as String?,
    displayName: json['displayName'] as String?,
    emailVerified: json['emailVerified'] as bool,
    phoneNumber: json['phoneNumber'] as String?,
    photoUrl: json['photoUrl'] as String?,
    status: _$enumDecode(_$StatusEnumMap, json['status']),
    tag: json['tag'] as String?,
    google: json['google'] as bool,
    facebook: json['facebook'] as bool,
    apple: json['apple'] as bool,
    favouriteTopics: (json['favouriteTopics'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
  )..isALangameUser = json['isALangameUser'] as bool;
}

Map<String, dynamic> _$LangameUserToJson(LangameUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'displayName': instance.displayName,
      'emailVerified': instance.emailVerified,
      'phoneNumber': instance.phoneNumber,
      'photoUrl': instance.photoUrl,
      'status': _$StatusEnumMap[instance.status],
      'google': instance.google,
      'facebook': instance.facebook,
      'apple': instance.apple,
      'favouriteTopics': instance.favouriteTopics,
      'isALangameUser': instance.isALangameUser,
      'tag': instance.tag,
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

const _$StatusEnumMap = {
  Status.OFFLINE: 'OFFLINE',
  Status.ONLINE: 'ONLINE',
};
