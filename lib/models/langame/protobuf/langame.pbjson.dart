///
//  Generated code. Do not modify.
//  source: langame/protobuf/langame.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use interactionLevelDescriptor instead')
const InteractionLevel$json = const {
  '1': 'InteractionLevel',
  '2': const [
    const {'1': 'BAD', '2': 0},
    const {'1': 'AVERAGE', '2': 1},
    const {'1': 'GREAT', '2': 2},
    const {'1': 'LOVE', '2': 3},
  ],
};

/// Descriptor for `InteractionLevel`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List interactionLevelDescriptor = $convert.base64Decode('ChBJbnRlcmFjdGlvbkxldmVsEgcKA0JBRBAAEgsKB0FWRVJBR0UQARIJCgVHUkVBVBACEggKBExPVkUQAw==');
@$core.Deprecated('Use firestoreCollectionDescriptor instead')
const FirestoreCollection$json = const {
  '1': 'FirestoreCollection',
  '2': const [
    const {'1': 'USERS', '2': 0},
    const {'1': 'MEMES', '2': 1},
    const {'1': 'PROMPTS', '2': 2},
    const {'1': 'LANGAMES', '2': 3},
  ],
};

/// Descriptor for `FirestoreCollection`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List firestoreCollectionDescriptor = $convert.base64Decode('ChNGaXJlc3RvcmVDb2xsZWN0aW9uEgkKBVVTRVJTEAASCQoFTUVNRVMQARILCgdQUk9NUFRTEAISDAoITEFOR0FNRVMQAw==');
@$core.Deprecated('Use memeDescriptor instead')
const Meme$json = const {
  '1': 'Meme',
  '2': const [
    const {'1': 'created_at', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'content', '3': 2, '4': 1, '5': 9, '10': 'content'},
    const {'1': 'tags', '3': 4, '4': 3, '5': 11, '6': '.langame.protobuf.Tag', '10': 'tags'},
    const {'1': 'prompt_id', '3': 5, '4': 1, '5': 9, '10': 'promptId'},
  ],
};

/// Descriptor for `Meme`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List memeDescriptor = $convert.base64Decode('CgRNZW1lEjkKCmNyZWF0ZWRfYXQYASABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSGAoHY29udGVudBgCIAEoCVIHY29udGVudBIpCgR0YWdzGAQgAygLMhUubGFuZ2FtZS5wcm90b2J1Zi5UYWdSBHRhZ3MSGwoJcHJvbXB0X2lkGAUgASgJUghwcm9tcHRJZA==');
@$core.Deprecated('Use tagDescriptor instead')
const Tag$json = const {
  '1': 'Tag',
  '2': const [
    const {'1': 'created_at', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'topic', '3': 2, '4': 1, '5': 11, '6': '.langame.protobuf.Tag.Topic', '9': 0, '10': 'topic'},
    const {'1': 'classification', '3': 3, '4': 1, '5': 11, '6': '.langame.protobuf.Tag.Classification', '9': 0, '10': 'classification'},
    const {'1': 'engine', '3': 4, '4': 1, '5': 11, '6': '.langame.protobuf.Tag.Engine', '9': 0, '10': 'engine'},
    const {'1': 'feedback', '3': 5, '4': 1, '5': 11, '6': '.langame.protobuf.Tag.Feedback', '9': 0, '10': 'feedback'},
    const {'1': 'context', '3': 6, '4': 1, '5': 11, '6': '.langame.protobuf.Tag.Context', '9': 0, '10': 'context'},
    const {'1': 'aggregated_feedback', '3': 7, '4': 1, '5': 11, '6': '.langame.protobuf.Tag.Feedback', '9': 0, '10': 'aggregatedFeedback'},
  ],
  '3': const [Tag_Topic$json, Tag_Classification$json, Tag_Engine$json, Tag_Feedback$json, Tag_Context$json],
  '8': const [
    const {'1': 'type'},
  ],
};

@$core.Deprecated('Use tagDescriptor instead')
const Tag_Topic$json = const {
  '1': 'Topic',
  '2': const [
    const {'1': 'content', '3': 2, '4': 1, '5': 9, '10': 'content'},
    const {'1': 'emojis', '3': 3, '4': 3, '5': 9, '10': 'emojis'},
  ],
};

@$core.Deprecated('Use tagDescriptor instead')
const Tag_Classification$json = const {
  '1': 'Classification',
  '2': const [
    const {'1': 'content', '3': 1, '4': 1, '5': 9, '10': 'content'},
    const {'1': 'score', '3': 2, '4': 1, '5': 1, '10': 'score'},
    const {'1': 'human', '3': 3, '4': 1, '5': 8, '10': 'human'},
  ],
};

@$core.Deprecated('Use tagDescriptor instead')
const Tag_Engine$json = const {
  '1': 'Engine',
  '2': const [
    const {'1': 'parameters', '3': 1, '4': 1, '5': 11, '6': '.langame.protobuf.Tag.Engine.Parameters', '10': 'parameters'},
  ],
  '3': const [Tag_Engine_Parameters$json],
};

@$core.Deprecated('Use tagDescriptor instead')
const Tag_Engine_Parameters$json = const {
  '1': 'Parameters',
  '2': const [
    const {'1': 'temperature', '3': 1, '4': 1, '5': 1, '10': 'temperature'},
    const {'1': 'max_tokens', '3': 2, '4': 1, '5': 13, '10': 'maxTokens'},
    const {'1': 'top_p', '3': 3, '4': 1, '5': 13, '10': 'topP'},
    const {'1': 'frequency_penalty', '3': 4, '4': 1, '5': 1, '10': 'frequencyPenalty'},
    const {'1': 'presence_penalty', '3': 5, '4': 1, '5': 1, '10': 'presencePenalty'},
    const {'1': 'stop', '3': 6, '4': 3, '5': 9, '10': 'stop'},
    const {'1': 'model', '3': 7, '4': 1, '5': 9, '10': 'model'},
  ],
};

@$core.Deprecated('Use tagDescriptor instead')
const Tag_Feedback$json = const {
  '1': 'Feedback',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'general', '3': 2, '4': 1, '5': 11, '6': '.langame.protobuf.Tag.Feedback.General', '9': 0, '10': 'general'},
    const {'1': 'relevance', '3': 3, '4': 1, '5': 11, '6': '.langame.protobuf.Tag.Feedback.Relevance', '9': 0, '10': 'relevance'},
  ],
  '3': const [Tag_Feedback_General$json, Tag_Feedback_Relevance$json],
  '8': const [
    const {'1': 'type'},
  ],
};

@$core.Deprecated('Use tagDescriptor instead')
const Tag_Feedback_General$json = const {
  '1': 'General',
  '2': const [
    const {'1': 'score', '3': 1, '4': 1, '5': 13, '10': 'score'},
  ],
};

@$core.Deprecated('Use tagDescriptor instead')
const Tag_Feedback_Relevance$json = const {
  '1': 'Relevance',
  '2': const [
    const {'1': 'score', '3': 1, '4': 1, '5': 13, '10': 'score'},
  ],
};

@$core.Deprecated('Use tagDescriptor instead')
const Tag_Context$json = const {
  '1': 'Context',
  '2': const [
    const {'1': 'content', '3': 1, '4': 1, '5': 9, '10': 'content'},
    const {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.langame.protobuf.Tag.Context.Type', '10': 'type'},
  ],
  '4': const [Tag_Context_Type$json],
};

@$core.Deprecated('Use tagDescriptor instead')
const Tag_Context_Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'WIKIPEDIA', '2': 0},
    const {'1': 'OPENAI', '2': 1},
  ],
};

/// Descriptor for `Tag`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tagDescriptor = $convert.base64Decode('CgNUYWcSOQoKY3JlYXRlZF9hdBgBIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBIzCgV0b3BpYxgCIAEoCzIbLmxhbmdhbWUucHJvdG9idWYuVGFnLlRvcGljSABSBXRvcGljEk4KDmNsYXNzaWZpY2F0aW9uGAMgASgLMiQubGFuZ2FtZS5wcm90b2J1Zi5UYWcuQ2xhc3NpZmljYXRpb25IAFIOY2xhc3NpZmljYXRpb24SNgoGZW5naW5lGAQgASgLMhwubGFuZ2FtZS5wcm90b2J1Zi5UYWcuRW5naW5lSABSBmVuZ2luZRI8CghmZWVkYmFjaxgFIAEoCzIeLmxhbmdhbWUucHJvdG9idWYuVGFnLkZlZWRiYWNrSABSCGZlZWRiYWNrEjkKB2NvbnRleHQYBiABKAsyHS5sYW5nYW1lLnByb3RvYnVmLlRhZy5Db250ZXh0SABSB2NvbnRleHQSUQoTYWdncmVnYXRlZF9mZWVkYmFjaxgHIAEoCzIeLmxhbmdhbWUucHJvdG9idWYuVGFnLkZlZWRiYWNrSABSEmFnZ3JlZ2F0ZWRGZWVkYmFjaxo5CgVUb3BpYxIYCgdjb250ZW50GAIgASgJUgdjb250ZW50EhYKBmVtb2ppcxgDIAMoCVIGZW1vamlzGlYKDkNsYXNzaWZpY2F0aW9uEhgKB2NvbnRlbnQYASABKAlSB2NvbnRlbnQSFAoFc2NvcmUYAiABKAFSBXNjb3JlEhQKBWh1bWFuGAMgASgIUgVodW1hbhq4AgoGRW5naW5lEkcKCnBhcmFtZXRlcnMYASABKAsyJy5sYW5nYW1lLnByb3RvYnVmLlRhZy5FbmdpbmUuUGFyYW1ldGVyc1IKcGFyYW1ldGVycxrkAQoKUGFyYW1ldGVycxIgCgt0ZW1wZXJhdHVyZRgBIAEoAVILdGVtcGVyYXR1cmUSHQoKbWF4X3Rva2VucxgCIAEoDVIJbWF4VG9rZW5zEhMKBXRvcF9wGAMgASgNUgR0b3BQEisKEWZyZXF1ZW5jeV9wZW5hbHR5GAQgASgBUhBmcmVxdWVuY3lQZW5hbHR5EikKEHByZXNlbmNlX3BlbmFsdHkYBSABKAFSD3ByZXNlbmNlUGVuYWx0eRISCgRzdG9wGAYgAygJUgRzdG9wEhQKBW1vZGVsGAcgASgJUgVtb2RlbBr9AQoIRmVlZGJhY2sSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEkIKB2dlbmVyYWwYAiABKAsyJi5sYW5nYW1lLnByb3RvYnVmLlRhZy5GZWVkYmFjay5HZW5lcmFsSABSB2dlbmVyYWwSSAoJcmVsZXZhbmNlGAMgASgLMigubGFuZ2FtZS5wcm90b2J1Zi5UYWcuRmVlZGJhY2suUmVsZXZhbmNlSABSCXJlbGV2YW5jZRofCgdHZW5lcmFsEhQKBXNjb3JlGAEgASgNUgVzY29yZRohCglSZWxldmFuY2USFAoFc2NvcmUYASABKA1SBXNjb3JlQgYKBHR5cGUafgoHQ29udGV4dBIYCgdjb250ZW50GAEgASgJUgdjb250ZW50EjYKBHR5cGUYAiABKA4yIi5sYW5nYW1lLnByb3RvYnVmLlRhZy5Db250ZXh0LlR5cGVSBHR5cGUiIQoEVHlwZRINCglXSUtJUEVESUEQABIKCgZPUEVOQUkQAUIGCgR0eXBl');
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
    const {'1': 'apple', '3': 9, '4': 1, '5': 8, '10': 'apple'},
    const {'1': 'tag', '3': 11, '4': 1, '5': 9, '10': 'tag'},
    const {'1': 'tokens', '3': 12, '4': 3, '5': 9, '10': 'tokens'},
    const {'1': 'latest_interactions', '3': 13, '4': 3, '5': 9, '10': 'latestInteractions'},
    const {'1': 'errors', '3': 14, '4': 3, '5': 9, '10': 'errors'},
    const {'1': 'last_login', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastLogin'},
    const {'1': 'last_logout', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastLogout'},
    const {'1': 'creation_time', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'creationTime'},
    const {'1': 'disabled', '3': 18, '4': 1, '5': 8, '10': 'disabled'},
    const {'1': 'devices', '3': 19, '4': 3, '5': 11, '6': '.langame.protobuf.User.Device', '10': 'devices'},
  ],
  '3': const [User_Device$json],
};

@$core.Deprecated('Use userDescriptor instead')
const User_Device$json = const {
  '1': 'Device',
  '2': const [
    const {'1': 'langame_version', '3': 1, '4': 1, '5': 9, '10': 'langameVersion'},
    const {'1': 'device_info', '3': 2, '4': 1, '5': 9, '10': 'deviceInfo'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode('CgRVc2VyEhAKA3VpZBgBIAEoCVIDdWlkEhQKBWVtYWlsGAIgASgJUgVlbWFpbBIhCgxkaXNwbGF5X25hbWUYAyABKAlSC2Rpc3BsYXlOYW1lEiEKDHBob25lX251bWJlchgEIAEoCVILcGhvbmVOdW1iZXISGwoJcGhvdG9fdXJsGAUgASgJUghwaG90b1VybBIWCgZvbmxpbmUYBiABKAhSBm9ubGluZRIWCgZnb29nbGUYByABKAhSBmdvb2dsZRIUCgVhcHBsZRgJIAEoCFIFYXBwbGUSEAoDdGFnGAsgASgJUgN0YWcSFgoGdG9rZW5zGAwgAygJUgZ0b2tlbnMSLwoTbGF0ZXN0X2ludGVyYWN0aW9ucxgNIAMoCVISbGF0ZXN0SW50ZXJhY3Rpb25zEhYKBmVycm9ycxgOIAMoCVIGZXJyb3JzEjkKCmxhc3RfbG9naW4YDyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglsYXN0TG9naW4SOwoLbGFzdF9sb2dvdXQYECABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgpsYXN0TG9nb3V0Ej8KDWNyZWF0aW9uX3RpbWUYESABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgxjcmVhdGlvblRpbWUSGgoIZGlzYWJsZWQYEiABKAhSCGRpc2FibGVkEjcKB2RldmljZXMYEyADKAsyHS5sYW5nYW1lLnByb3RvYnVmLlVzZXIuRGV2aWNlUgdkZXZpY2VzGlIKBkRldmljZRInCg9sYW5nYW1lX3ZlcnNpb24YASABKAlSDmxhbmdhbWVWZXJzaW9uEh8KC2RldmljZV9pbmZvGAIgASgJUgpkZXZpY2VJbmZv');
@$core.Deprecated('Use userPreferenceDescriptor instead')
const UserPreference$json = const {
  '1': 'UserPreference',
  '2': const [
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'unknown_people_recommendations', '3': 3, '4': 1, '5': 8, '10': 'unknownPeopleRecommendations'},
    const {'1': 'theme_index', '3': 4, '4': 1, '5': 5, '10': 'themeIndex'},
    const {'1': 'has_done_on_boarding', '3': 5, '4': 1, '5': 8, '10': 'hasDoneOnBoarding'},
    const {'1': 'search_history', '3': 6, '4': 3, '5': 9, '10': 'searchHistory'},
    const {'1': 'shake_to_feedback', '3': 7, '4': 1, '5': 8, '10': 'shakeToFeedback'},
    const {'1': 'favorite_topics', '3': 8, '4': 3, '5': 9, '10': 'favoriteTopics'},
  ],
};

/// Descriptor for `UserPreference`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userPreferenceDescriptor = $convert.base64Decode('Cg5Vc2VyUHJlZmVyZW5jZRIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSRAoedW5rbm93bl9wZW9wbGVfcmVjb21tZW5kYXRpb25zGAMgASgIUhx1bmtub3duUGVvcGxlUmVjb21tZW5kYXRpb25zEh8KC3RoZW1lX2luZGV4GAQgASgFUgp0aGVtZUluZGV4Ei8KFGhhc19kb25lX29uX2JvYXJkaW5nGAUgASgIUhFoYXNEb25lT25Cb2FyZGluZxIlCg5zZWFyY2hfaGlzdG9yeRgGIAMoCVINc2VhcmNoSGlzdG9yeRIqChFzaGFrZV90b19mZWVkYmFjaxgHIAEoCFIPc2hha2VUb0ZlZWRiYWNrEicKD2Zhdm9yaXRlX3RvcGljcxgIIAMoCVIOZmF2b3JpdGVUb3BpY3M=');
@$core.Deprecated('Use langameDescriptor instead')
const Langame$json = const {
  '1': 'Langame',
  '2': const [
    const {'1': 'channel_name', '3': 1, '4': 1, '5': 9, '10': 'channelName'},
    const {'1': 'players', '3': 2, '4': 3, '5': 9, '10': 'players'},
    const {'1': 'topics', '3': 3, '4': 3, '5': 9, '10': 'topics'},
    const {'1': 'memes', '3': 4, '4': 3, '5': 9, '10': 'memes'},
    const {'1': 'initiator', '3': 5, '4': 1, '5': 9, '10': 'initiator'},
    const {'1': 'done', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'done'},
    const {'1': 'current_meme', '3': 8, '4': 1, '5': 5, '10': 'currentMeme'},
    const {'1': 'date', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'date'},
    const {'1': 'errors', '3': 10, '4': 3, '5': 9, '10': 'errors'},
    const {'1': 'started', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'started'},
    const {'1': 'next_meme', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextMeme'},
    const {'1': 'memes_seen', '3': 14, '4': 1, '5': 5, '10': 'memesSeen'},
    const {'1': 'meme_changed', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'memeChanged'},
    const {'1': 'link', '3': 16, '4': 1, '5': 9, '10': 'link'},
    const {'1': 'reserved_spots', '3': 18, '4': 3, '5': 9, '10': 'reservedSpots'},
    const {'1': 'is_locked', '3': 19, '4': 1, '5': 8, '10': 'isLocked'},
  ],
};

/// Descriptor for `Langame`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List langameDescriptor = $convert.base64Decode('CgdMYW5nYW1lEiEKDGNoYW5uZWxfbmFtZRgBIAEoCVILY2hhbm5lbE5hbWUSGAoHcGxheWVycxgCIAMoCVIHcGxheWVycxIWCgZ0b3BpY3MYAyADKAlSBnRvcGljcxIUCgVtZW1lcxgEIAMoCVIFbWVtZXMSHAoJaW5pdGlhdG9yGAUgASgJUglpbml0aWF0b3ISLgoEZG9uZRgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSBGRvbmUSIQoMY3VycmVudF9tZW1lGAggASgFUgtjdXJyZW50TWVtZRIuCgRkYXRlGAkgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIEZGF0ZRIWCgZlcnJvcnMYCiADKAlSBmVycm9ycxI0CgdzdGFydGVkGAsgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIHc3RhcnRlZBI3CgluZXh0X21lbWUYDSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUghuZXh0TWVtZRIdCgptZW1lc19zZWVuGA4gASgFUgltZW1lc1NlZW4SPQoMbWVtZV9jaGFuZ2VkGA8gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILbWVtZUNoYW5nZWQSEgoEbGluaxgQIAEoCVIEbGluaxIlCg5yZXNlcnZlZF9zcG90cxgSIAMoCVINcmVzZXJ2ZWRTcG90cxIbCglpc19sb2NrZWQYEyABKAhSCGlzTG9ja2Vk');
@$core.Deprecated('Use playerDescriptor instead')
const Player$json = const {
  '1': 'Player',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'time_in', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timeIn'},
    const {'1': 'time_out', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timeOut'},
    const {'1': 'notes', '3': 4, '4': 3, '5': 11, '6': '.langame.protobuf.Note', '10': 'notes'},
    const {'1': 'audio_id', '3': 5, '4': 1, '5': 5, '10': 'audioId'},
    const {'1': 'audio_token', '3': 6, '4': 1, '5': 9, '10': 'audioToken'},
  ],
};

/// Descriptor for `Player`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playerDescriptor = $convert.base64Decode('CgZQbGF5ZXISFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEjMKB3RpbWVfaW4YAiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgZ0aW1lSW4SNQoIdGltZV9vdXQYAyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgd0aW1lT3V0EiwKBW5vdGVzGAQgAygLMhYubGFuZ2FtZS5wcm90b2J1Zi5Ob3RlUgVub3RlcxIZCghhdWRpb19pZBgFIAEoBVIHYXVkaW9JZBIfCgthdWRpb190b2tlbhgGIAEoCVIKYXVkaW9Ub2tlbg==');
@$core.Deprecated('Use noteDescriptor instead')
const Note$json = const {
  '1': 'Note',
  '2': const [
    const {'1': 'created_at', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'generic', '3': 2, '4': 1, '5': 11, '6': '.langame.protobuf.Note.Generic', '9': 0, '10': 'generic'},
    const {'1': 'goal', '3': 3, '4': 1, '5': 11, '6': '.langame.protobuf.Note.Goal', '9': 0, '10': 'goal'},
    const {'1': 'definition', '3': 4, '4': 1, '5': 11, '6': '.langame.protobuf.Note.Definition', '9': 0, '10': 'definition'},
  ],
  '3': const [Note_Generic$json, Note_Goal$json, Note_Definition$json],
  '8': const [
    const {'1': 'type'},
  ],
};

@$core.Deprecated('Use noteDescriptor instead')
const Note_Generic$json = const {
  '1': 'Generic',
  '2': const [
    const {'1': 'content', '3': 1, '4': 1, '5': 9, '10': 'content'},
  ],
};

@$core.Deprecated('Use noteDescriptor instead')
const Note_Goal$json = const {
  '1': 'Goal',
  '2': const [
    const {'1': 'content', '3': 1, '4': 1, '5': 9, '10': 'content'},
  ],
};

@$core.Deprecated('Use noteDescriptor instead')
const Note_Definition$json = const {
  '1': 'Definition',
  '2': const [
    const {'1': 'content', '3': 1, '4': 1, '5': 9, '10': 'content'},
  ],
};

/// Descriptor for `Note`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List noteDescriptor = $convert.base64Decode('CgROb3RlEjkKCmNyZWF0ZWRfYXQYASABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOgoHZ2VuZXJpYxgCIAEoCzIeLmxhbmdhbWUucHJvdG9idWYuTm90ZS5HZW5lcmljSABSB2dlbmVyaWMSMQoEZ29hbBgDIAEoCzIbLmxhbmdhbWUucHJvdG9idWYuTm90ZS5Hb2FsSABSBGdvYWwSQwoKZGVmaW5pdGlvbhgEIAEoCzIhLmxhbmdhbWUucHJvdG9idWYuTm90ZS5EZWZpbml0aW9uSABSCmRlZmluaXRpb24aIwoHR2VuZXJpYxIYCgdjb250ZW50GAEgASgJUgdjb250ZW50GiAKBEdvYWwSGAoHY29udGVudBgBIAEoCVIHY29udGVudBomCgpEZWZpbml0aW9uEhgKB2NvbnRlbnQYASABKAlSB2NvbnRlbnRCBgoEdHlwZQ==');
@$core.Deprecated('Use notificationDescriptor instead')
const Notification$json = const {
  '1': 'Notification',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'sender_uid', '3': 2, '4': 1, '5': 9, '10': 'senderUid'},
    const {'1': 'recipients_uid', '3': 3, '4': 3, '5': 9, '10': 'recipientsUid'},
    const {'1': 'topics', '3': 4, '4': 3, '5': 9, '10': 'topics'},
    const {'1': 'channel_name', '3': 5, '4': 1, '5': 9, '10': 'channelName'},
    const {'1': 'ready', '3': 6, '4': 1, '5': 8, '10': 'ready'},
  ],
};

/// Descriptor for `Notification`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List notificationDescriptor = $convert.base64Decode('CgxOb3RpZmljYXRpb24SDgoCaWQYASABKAlSAmlkEh0KCnNlbmRlcl91aWQYAiABKAlSCXNlbmRlclVpZBIlCg5yZWNpcGllbnRzX3VpZBgDIAMoCVINcmVjaXBpZW50c1VpZBIWCgZ0b3BpY3MYBCADKAlSBnRvcGljcxIhCgxjaGFubmVsX25hbWUYBSABKAlSC2NoYW5uZWxOYW1lEhQKBXJlYWR5GAYgASgIUgVyZWFkeQ==');
@$core.Deprecated('Use subscriptionDescriptor instead')
const Subscription$json = const {
  '1': 'Subscription',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `Subscription`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscriptionDescriptor = $convert.base64Decode('CgxTdWJzY3JpcHRpb24SFgoGc3RhdHVzGAEgASgJUgZzdGF0dXM=');
@$core.Deprecated('Use functionResponseDescriptor instead')
const FunctionResponse$json = const {
  '1': 'FunctionResponse',
  '2': const [
    const {'1': 'version_check', '3': 1, '4': 1, '5': 11, '6': '.langame.protobuf.FunctionResponse.VersionCheck', '9': 0, '10': 'versionCheck'},
  ],
  '3': const [FunctionResponse_VersionCheck$json],
  '8': const [
    const {'1': 'type'},
  ],
};

@$core.Deprecated('Use functionResponseDescriptor instead')
const FunctionResponse_VersionCheck$json = const {
  '1': 'VersionCheck',
  '2': const [
    const {'1': 'update', '3': 1, '4': 1, '5': 14, '6': '.langame.protobuf.FunctionResponse.VersionCheck.UpdateRequired', '10': 'update'},
  ],
  '4': const [FunctionResponse_VersionCheck_UpdateRequired$json],
};

@$core.Deprecated('Use functionResponseDescriptor instead')
const FunctionResponse_VersionCheck_UpdateRequired$json = const {
  '1': 'UpdateRequired',
  '2': const [
    const {'1': 'OK', '2': 0},
    const {'1': 'REQUIRED', '2': 1},
    const {'1': 'RETRO_COMPATIBLE', '2': 2},
  ],
};

/// Descriptor for `FunctionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List functionResponseDescriptor = $convert.base64Decode('ChBGdW5jdGlvblJlc3BvbnNlElYKDXZlcnNpb25fY2hlY2sYASABKAsyLy5sYW5nYW1lLnByb3RvYnVmLkZ1bmN0aW9uUmVzcG9uc2UuVmVyc2lvbkNoZWNrSABSDHZlcnNpb25DaGVjaxqkAQoMVmVyc2lvbkNoZWNrElYKBnVwZGF0ZRgBIAEoDjI+LmxhbmdhbWUucHJvdG9idWYuRnVuY3Rpb25SZXNwb25zZS5WZXJzaW9uQ2hlY2suVXBkYXRlUmVxdWlyZWRSBnVwZGF0ZSI8Cg5VcGRhdGVSZXF1aXJlZBIGCgJPSxAAEgwKCFJFUVVJUkVEEAESFAoQUkVUUk9fQ09NUEFUSUJMRRACQgYKBHR5cGU=');
@$core.Deprecated('Use promptDescriptor instead')
const Prompt$json = const {
  '1': 'Prompt',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'template', '3': 2, '4': 1, '5': 9, '10': 'template'},
    const {'1': 'tags', '3': 3, '4': 3, '5': 11, '6': '.langame.protobuf.Tag', '10': 'tags'},
  ],
};

/// Descriptor for `Prompt`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List promptDescriptor = $convert.base64Decode('CgZQcm9tcHQSEgoEdHlwZRgBIAEoCVIEdHlwZRIaCgh0ZW1wbGF0ZRgCIAEoCVIIdGVtcGxhdGUSKQoEdGFncxgDIAMoCzIVLmxhbmdhbWUucHJvdG9idWYuVGFnUgR0YWdz');
