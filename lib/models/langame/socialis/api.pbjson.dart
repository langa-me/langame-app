///
//  Generated code. Do not modify.
//  source: api.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use gameStateDescriptor instead')
const GameState$json = const {
  '1': 'GameState',
  '2': const [
    const {'1': 'PLAYER_ADD', '2': 0},
    const {'1': 'PLAYER_VALIDATE', '2': 1},
  ],
};

/// Descriptor for `GameState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List gameStateDescriptor = $convert.base64Decode('CglHYW1lU3RhdGUSDgoKUExBWUVSX0FERBAAEhMKD1BMQVlFUl9WQUxJREFURRAB');
@$core.Deprecated('Use addPlayersRequestDescriptor instead')
const AddPlayersRequest$json = const {
  '1': 'AddPlayersRequest',
  '2': const [
    const {'1': 'text', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'text'},
    const {'1': 'speech', '3': 2, '4': 1, '5': 12, '9': 0, '10': 'speech'},
  ],
  '8': const [
    const {'1': 'players'},
  ],
};

/// Descriptor for `AddPlayersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addPlayersRequestDescriptor = $convert.base64Decode('ChFBZGRQbGF5ZXJzUmVxdWVzdBIUCgR0ZXh0GAEgASgJSABSBHRleHQSGAoGc3BlZWNoGAIgASgMSABSBnNwZWVjaEIJCgdwbGF5ZXJz');
@$core.Deprecated('Use validatePlayersRequestDescriptor instead')
const ValidatePlayersRequest$json = const {
  '1': 'ValidatePlayersRequest',
  '2': const [
    const {'1': 'valid', '3': 1, '4': 1, '5': 8, '10': 'valid'},
  ],
};

/// Descriptor for `ValidatePlayersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validatePlayersRequestDescriptor = $convert.base64Decode('ChZWYWxpZGF0ZVBsYXllcnNSZXF1ZXN0EhQKBXZhbGlkGAEgASgIUgV2YWxpZA==');
@$core.Deprecated('Use gameDescriptor instead')
const Game$json = const {
  '1': 'Game',
  '2': const [
    const {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
    const {'1': 'state', '3': 2, '4': 1, '5': 14, '6': '.langame.socialis.GameState', '10': 'state'},
  ],
};

/// Descriptor for `Game`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gameDescriptor = $convert.base64Decode('CgRHYW1lEhIKBHRleHQYASABKAlSBHRleHQSMQoFc3RhdGUYAiABKA4yGy5sYW5nYW1lLnNvY2lhbGlzLkdhbWVTdGF0ZVIFc3RhdGU=');
