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
    phoneNumber: json['phoneNumber'] as String?,
    photoUrl: json['photoUrl'] as String?,
    online: json['online'] as bool,
    tag: json['tag'] as String?,
    google: json['google'] as bool,
    facebook: json['facebook'] as bool,
    apple: json['apple'] as bool,
    favouriteTopics: (json['favouriteTopics'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
  )
    ..isALangameUser = json['isALangameUser'] as bool
    ..tokens =
        (json['tokens'] as List<dynamic>?)?.map((e) => e as String).toList();
}

Map<String, dynamic> _$LangameUserToJson(LangameUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'displayName': instance.displayName,
      'phoneNumber': instance.phoneNumber,
      'photoUrl': instance.photoUrl,
      'online': instance.online,
      'google': instance.google,
      'facebook': instance.facebook,
      'apple': instance.apple,
      'favouriteTopics': instance.favouriteTopics,
      'isALangameUser': instance.isALangameUser,
      'tag': instance.tag,
      'tokens': instance.tokens,
    };
