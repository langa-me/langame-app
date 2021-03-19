///
//  Generated code. Do not modify.
//  source: api/api.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use langameUserDescriptor instead')
const LangameUser$json = const {
  '1': 'LangameUser',
  '2': const [
    const {'1': 'uid', '3': 1, '4': 1, '5': 9, '10': 'uid'},
    const {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'display_name', '3': 3, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'email_verified', '3': 4, '4': 1, '5': 8, '10': 'emailVerified'},
    const {'1': 'phone_number', '3': 5, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'photo_url', '3': 6, '4': 1, '5': 9, '10': 'photoUrl'},
  ],
};

/// Descriptor for `LangameUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List langameUserDescriptor = $convert.base64Decode('CgtMYW5nYW1lVXNlchIQCgN1aWQYASABKAlSA3VpZBIUCgVlbWFpbBgCIAEoCVIFZW1haWwSIQoMZGlzcGxheV9uYW1lGAMgASgJUgtkaXNwbGF5TmFtZRIlCg5lbWFpbF92ZXJpZmllZBgEIAEoCFINZW1haWxWZXJpZmllZBIhCgxwaG9uZV9udW1iZXIYBSABKAlSC3Bob25lTnVtYmVyEhsKCXBob3RvX3VybBgGIAEoCVIIcGhvdG9Vcmw=');
@$core.Deprecated('Use topicGroupDescriptor instead')
const TopicGroup$json = const {
  '1': 'TopicGroup',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'topics', '3': 2, '4': 3, '5': 9, '10': 'topics'},
  ],
};

/// Descriptor for `TopicGroup`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List topicGroupDescriptor = $convert.base64Decode('CgpUb3BpY0dyb3VwEhIKBG5hbWUYASABKAlSBG5hbWUSFgoGdG9waWNzGAIgAygJUgZ0b3BpY3M=');
@$core.Deprecated('Use userFriendsDescriptor instead')
const UserFriends$json = const {
  '1': 'UserFriends',
  '2': const [
    const {'1': 'uid', '3': 1, '4': 1, '5': 9, '10': 'uid'},
    const {'1': 'friends', '3': 2, '4': 3, '5': 11, '6': '.api.Friend', '10': 'friends'},
  ],
};

/// Descriptor for `UserFriends`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userFriendsDescriptor = $convert.base64Decode('CgtVc2VyRnJpZW5kcxIQCgN1aWQYASABKAlSA3VpZBIlCgdmcmllbmRzGAIgAygLMgsuYXBpLkZyaWVuZFIHZnJpZW5kcw==');
@$core.Deprecated('Use friendDescriptor instead')
const Friend$json = const {
  '1': 'Friend',
  '2': const [
    const {'1': 'friend', '3': 1, '4': 1, '5': 11, '6': '.api.LangameUser', '10': 'friend'},
    const {'1': 'relation', '3': 2, '4': 1, '5': 11, '6': '.api.Relation', '10': 'relation'},
  ],
};

/// Descriptor for `Friend`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List friendDescriptor = $convert.base64Decode('CgZGcmllbmQSKAoGZnJpZW5kGAEgASgLMhAuYXBpLkxhbmdhbWVVc2VyUgZmcmllbmQSKQoIcmVsYXRpb24YAiABKAsyDS5hcGkuUmVsYXRpb25SCHJlbGF0aW9u');
@$core.Deprecated('Use relationDescriptor instead')
const Relation$json = const {
  '1': 'Relation',
  '2': const [
    const {'1': 'level', '3': 1, '4': 1, '5': 14, '6': '.api.Relation.Level', '10': 'level'},
  ],
  '4': const [Relation_Level$json],
};

@$core.Deprecated('Use relationDescriptor instead')
const Relation_Level$json = const {
  '1': 'Level',
  '2': const [
    const {'1': 'BAD', '2': 0},
    const {'1': 'AVERAGE', '2': 1},
    const {'1': 'GREAT', '2': 2},
  ],
};

/// Descriptor for `Relation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List relationDescriptor = $convert.base64Decode('CghSZWxhdGlvbhIpCgVsZXZlbBgBIAEoDjITLmFwaS5SZWxhdGlvbi5MZXZlbFIFbGV2ZWwiKAoFTGV2ZWwSBwoDQkFEEAASCwoHQVZFUkFHRRABEgkKBUdSRUFUEAI=');
