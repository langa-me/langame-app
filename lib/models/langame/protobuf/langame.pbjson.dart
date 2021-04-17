///
//  Generated code. Do not modify.
//  source: langame/protobuf/langame.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use topicDescriptor instead')
const Topic$json = const {
  '1': 'Topic',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'content', '3': 2, '4': 1, '5': 9, '10': 'content'},
  ],
};

/// Descriptor for `Topic`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List topicDescriptor = $convert.base64Decode('CgVUb3BpYxIOCgJpZBgBIAEoCVICaWQSGAoHY29udGVudBgCIAEoCVIHY29udGVudA==');
@$core.Deprecated('Use questionDescriptor instead')
const Question$json = const {
  '1': 'Question',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'content', '3': 2, '4': 1, '5': 9, '10': 'content'},
  ],
};

/// Descriptor for `Question`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List questionDescriptor = $convert.base64Decode('CghRdWVzdGlvbhIOCgJpZBgBIAEoCVICaWQSGAoHY29udGVudBgCIAEoCVIHY29udGVudA==');
@$core.Deprecated('Use tagDescriptor instead')
const Tag$json = const {
  '1': 'Tag',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'content', '3': 2, '4': 1, '5': 9, '10': 'content'},
    const {'1': 'score', '3': 3, '4': 1, '5': 1, '10': 'score'},
    const {'1': 'human', '3': 4, '4': 1, '5': 8, '10': 'human'},
    const {'1': 'question', '3': 5, '4': 1, '5': 9, '10': 'question'},
    const {'1': 'generated', '3': 6, '4': 1, '5': 8, '10': 'generated'},
  ],
};

/// Descriptor for `Tag`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tagDescriptor = $convert.base64Decode('CgNUYWcSDgoCaWQYASABKAlSAmlkEhgKB2NvbnRlbnQYAiABKAlSB2NvbnRlbnQSFAoFc2NvcmUYAyABKAFSBXNjb3JlEhQKBWh1bWFuGAQgASgIUgVodW1hbhIaCghxdWVzdGlvbhgFIAEoCVIIcXVlc3Rpb24SHAoJZ2VuZXJhdGVkGAYgASgIUglnZW5lcmF0ZWQ=');
@$core.Deprecated('Use userDescriptor instead')
const User$json = const {
  '1': 'User',
  '2': const [
    const {'1': 'uid', '3': 1, '4': 1, '5': 9, '10': 'uid'},
    const {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'display_name', '3': 3, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'phone_number', '3': 4, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'photo_url', '3': 5, '4': 1, '5': 9, '10': 'photoUrl'},
    const {'1': 'online', '3': 6, '4': 1, '5': 8, '10': 'online'},
    const {'1': 'google', '3': 7, '4': 1, '5': 8, '10': 'google'},
    const {'1': 'facebook', '3': 8, '4': 1, '5': 8, '10': 'facebook'},
    const {'1': 'apple', '3': 9, '4': 1, '5': 8, '10': 'apple'},
    const {'1': 'favourite_topics', '3': 10, '4': 3, '5': 9, '10': 'favouriteTopics'},
    const {'1': 'tag', '3': 11, '4': 1, '5': 9, '10': 'tag'},
    const {'1': 'tokens', '3': 12, '4': 3, '5': 9, '10': 'tokens'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode('CgRVc2VyEhAKA3VpZBgBIAEoCVIDdWlkEhQKBWVtYWlsGAIgASgJUgVlbWFpbBIhCgxkaXNwbGF5X25hbWUYAyABKAlSC2Rpc3BsYXlOYW1lEiEKDHBob25lX251bWJlchgEIAEoCVILcGhvbmVOdW1iZXISGwoJcGhvdG9fdXJsGAUgASgJUghwaG90b1VybBIWCgZvbmxpbmUYBiABKAhSBm9ubGluZRIWCgZnb29nbGUYByABKAhSBmdvb2dsZRIaCghmYWNlYm9vaxgIIAEoCFIIZmFjZWJvb2sSFAoFYXBwbGUYCSABKAhSBWFwcGxlEikKEGZhdm91cml0ZV90b3BpY3MYCiADKAlSD2Zhdm91cml0ZVRvcGljcxIQCgN0YWcYCyABKAlSA3RhZxIWCgZ0b2tlbnMYDCADKAlSBnRva2Vucw==');
@$core.Deprecated('Use relationDescriptor instead')
const Relation$json = const {
  '1': 'Relation',
  '2': const [
    const {'1': 'other', '3': 1, '4': 1, '5': 11, '6': '.langame.protobuf.User', '10': 'other'},
    const {'1': 'level', '3': 2, '4': 1, '5': 14, '6': '.langame.protobuf.Relation.RelationLevel', '10': 'level'},
  ],
  '4': const [Relation_RelationLevel$json],
};

@$core.Deprecated('Use relationDescriptor instead')
const Relation_RelationLevel$json = const {
  '1': 'RelationLevel',
  '2': const [
    const {'1': 'BAD', '2': 0},
    const {'1': 'AVERAGE', '2': 1},
    const {'1': 'GREAT', '2': 2},
  ],
};

/// Descriptor for `Relation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List relationDescriptor = $convert.base64Decode('CghSZWxhdGlvbhIsCgVvdGhlchgBIAEoCzIWLmxhbmdhbWUucHJvdG9idWYuVXNlclIFb3RoZXISPgoFbGV2ZWwYAiABKA4yKC5sYW5nYW1lLnByb3RvYnVmLlJlbGF0aW9uLlJlbGF0aW9uTGV2ZWxSBWxldmVsIjAKDVJlbGF0aW9uTGV2ZWwSBwoDQkFEEAASCwoHQVZFUkFHRRABEgkKBUdSRUFUEAI=');
