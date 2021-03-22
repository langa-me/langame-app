///
//  Generated code. Do not modify.
//  source: api/api.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use relationLevelDescriptor instead')
const RelationLevel$json = const {
  '1': 'RelationLevel',
  '2': const [
    const {'1': 'BAD', '2': 0},
    const {'1': 'AVERAGE', '2': 1},
    const {'1': 'GREAT', '2': 2},
  ],
};

/// Descriptor for `RelationLevel`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List relationLevelDescriptor = $convert.base64Decode('Cg1SZWxhdGlvbkxldmVsEgcKA0JBRBAAEgsKB0FWRVJBR0UQARIJCgVHUkVBVBAC');
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
    const {'1': 'status', '3': 7, '4': 1, '5': 14, '6': '.api.LangameUser.Status', '10': 'status'},
  ],
  '4': const [LangameUser_Status$json],
};

@$core.Deprecated('Use langameUserDescriptor instead')
const LangameUser_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'OFFLINE', '2': 0},
    const {'1': 'ONLINE', '2': 1},
  ],
};

/// Descriptor for `LangameUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List langameUserDescriptor = $convert.base64Decode('CgtMYW5nYW1lVXNlchIQCgN1aWQYASABKAlSA3VpZBIUCgVlbWFpbBgCIAEoCVIFZW1haWwSIQoMZGlzcGxheV9uYW1lGAMgASgJUgtkaXNwbGF5TmFtZRIlCg5lbWFpbF92ZXJpZmllZBgEIAEoCFINZW1haWxWZXJpZmllZBIhCgxwaG9uZV9udW1iZXIYBSABKAlSC3Bob25lTnVtYmVyEhsKCXBob3RvX3VybBgGIAEoCVIIcGhvdG9VcmwSLwoGc3RhdHVzGAcgASgOMhcuYXBpLkxhbmdhbWVVc2VyLlN0YXR1c1IGc3RhdHVzIiEKBlN0YXR1cxILCgdPRkZMSU5FEAASCgoGT05MSU5FEAE=');
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
@$core.Deprecated('Use relationDescriptor instead')
const Relation$json = const {
  '1': 'Relation',
  '2': const [
    const {'1': 'first_user', '3': 1, '4': 1, '5': 11, '6': '.api.LangameUser', '10': 'firstUser'},
    const {'1': 'second_user', '3': 2, '4': 1, '5': 11, '6': '.api.LangameUser', '10': 'secondUser'},
    const {'1': 'level', '3': 3, '4': 1, '5': 14, '6': '.api.RelationLevel', '10': 'level'},
  ],
};

/// Descriptor for `Relation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List relationDescriptor = $convert.base64Decode('CghSZWxhdGlvbhIvCgpmaXJzdF91c2VyGAEgASgLMhAuYXBpLkxhbmdhbWVVc2VyUglmaXJzdFVzZXISMQoLc2Vjb25kX3VzZXIYAiABKAsyEC5hcGkuTGFuZ2FtZVVzZXJSCnNlY29uZFVzZXISKAoFbGV2ZWwYAyABKA4yEi5hcGkuUmVsYXRpb25MZXZlbFIFbGV2ZWw=');
@$core.Deprecated('Use langameNotificationDescriptor instead')
const LangameNotification$json = const {
  '1': 'LangameNotification',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'sender', '3': 2, '4': 1, '5': 11, '6': '.api.LangameUser', '10': 'sender'},
    const {'1': 'type', '3': 3, '4': 1, '5': 14, '6': '.api.LangameNotification.Type', '10': 'type'},
    const {'1': 'background', '3': 4, '4': 1, '5': 8, '10': 'background'},
    const {'1': 'topic', '3': 5, '4': 1, '5': 9, '10': 'topic'},
    const {'1': 'relation', '3': 6, '4': 1, '5': 14, '6': '.api.RelationLevel', '10': 'relation'},
  ],
  '4': const [LangameNotification_Type$json],
};

@$core.Deprecated('Use langameNotificationDescriptor instead')
const LangameNotification_Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'INVITATION', '2': 0},
  ],
};

/// Descriptor for `LangameNotification`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List langameNotificationDescriptor = $convert.base64Decode('ChNMYW5nYW1lTm90aWZpY2F0aW9uEg4KAmlkGAEgASgJUgJpZBIoCgZzZW5kZXIYAiABKAsyEC5hcGkuTGFuZ2FtZVVzZXJSBnNlbmRlchIxCgR0eXBlGAMgASgOMh0uYXBpLkxhbmdhbWVOb3RpZmljYXRpb24uVHlwZVIEdHlwZRIeCgpiYWNrZ3JvdW5kGAQgASgIUgpiYWNrZ3JvdW5kEhQKBXRvcGljGAUgASgJUgV0b3BpYxIuCghyZWxhdGlvbhgGIAEoDjISLmFwaS5SZWxhdGlvbkxldmVsUghyZWxhdGlvbiIWCgRUeXBlEg4KCklOVklUQVRJT04QAA==');
