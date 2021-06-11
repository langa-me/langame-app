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
@$core.Deprecated('Use memeDescriptor instead')
const Meme$json = const {
  '1': 'Meme',
  '2': const [
    const {'1': 'created_at', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'content', '3': 2, '4': 1, '5': 9, '10': 'content'},
    const {'1': 'tags', '3': 4, '4': 3, '5': 11, '6': '.langame.protobuf.Tag', '10': 'tags'},
  ],
};

/// Descriptor for `Meme`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List memeDescriptor = $convert.base64Decode('CgRNZW1lEjkKCmNyZWF0ZWRfYXQYASABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSGAoHY29udGVudBgCIAEoCVIHY29udGVudBIpCgR0YWdzGAQgAygLMhUubGFuZ2FtZS5wcm90b2J1Zi5UYWdSBHRhZ3M=');
@$core.Deprecated('Use tagDescriptor instead')
const Tag$json = const {
  '1': 'Tag',
  '2': const [
    const {'1': 'created_at', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'topic', '3': 2, '4': 1, '5': 11, '6': '.langame.protobuf.Tag.Topic', '9': 0, '10': 'topic'},
    const {'1': 'classification', '3': 3, '4': 1, '5': 11, '6': '.langame.protobuf.Tag.Classification', '9': 0, '10': 'classification'},
    const {'1': 'origin', '3': 4, '4': 1, '5': 11, '6': '.langame.protobuf.Tag.Origin', '9': 0, '10': 'origin'},
    const {'1': 'feedback', '3': 5, '4': 1, '5': 11, '6': '.langame.protobuf.Tag.Feedback', '9': 0, '10': 'feedback'},
    const {'1': 'context', '3': 6, '4': 1, '5': 11, '6': '.langame.protobuf.Tag.Context', '9': 0, '10': 'context'},
  ],
  '3': const [Tag_Topic$json, Tag_Classification$json, Tag_Origin$json, Tag_Feedback$json, Tag_Context$json],
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
const Tag_Origin$json = const {
  '1': 'Origin',
  '2': const [
    const {'1': 'openai', '3': 2, '4': 1, '5': 11, '6': '.langame.protobuf.Tag.Origin.OpenAI', '9': 0, '10': 'openai'},
  ],
  '3': const [Tag_Origin_OpenAI$json],
  '8': const [
    const {'1': 'type'},
  ],
};

@$core.Deprecated('Use tagDescriptor instead')
const Tag_Origin_OpenAI$json = const {
  '1': 'OpenAI',
  '2': const [
    const {'1': 'version', '3': 1, '4': 1, '5': 13, '10': 'version'},
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
final $typed_data.Uint8List tagDescriptor = $convert.base64Decode('CgNUYWcSOQoKY3JlYXRlZF9hdBgBIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBIzCgV0b3BpYxgCIAEoCzIbLmxhbmdhbWUucHJvdG9idWYuVGFnLlRvcGljSABSBXRvcGljEk4KDmNsYXNzaWZpY2F0aW9uGAMgASgLMiQubGFuZ2FtZS5wcm90b2J1Zi5UYWcuQ2xhc3NpZmljYXRpb25IAFIOY2xhc3NpZmljYXRpb24SNgoGb3JpZ2luGAQgASgLMhwubGFuZ2FtZS5wcm90b2J1Zi5UYWcuT3JpZ2luSABSBm9yaWdpbhI8CghmZWVkYmFjaxgFIAEoCzIeLmxhbmdhbWUucHJvdG9idWYuVGFnLkZlZWRiYWNrSABSCGZlZWRiYWNrEjkKB2NvbnRleHQYBiABKAsyHS5sYW5nYW1lLnByb3RvYnVmLlRhZy5Db250ZXh0SABSB2NvbnRleHQaOQoFVG9waWMSGAoHY29udGVudBgCIAEoCVIHY29udGVudBIWCgZlbW9qaXMYAyADKAlSBmVtb2ppcxpWCg5DbGFzc2lmaWNhdGlvbhIYCgdjb250ZW50GAEgASgJUgdjb250ZW50EhQKBXNjb3JlGAIgASgBUgVzY29yZRIUCgVodW1hbhgDIAEoCFIFaHVtYW4acwoGT3JpZ2luEj0KBm9wZW5haRgCIAEoCzIjLmxhbmdhbWUucHJvdG9idWYuVGFnLk9yaWdpbi5PcGVuQUlIAFIGb3BlbmFpGiIKBk9wZW5BSRIYCgd2ZXJzaW9uGAEgASgNUgd2ZXJzaW9uQgYKBHR5cGUa/QEKCEZlZWRiYWNrEhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBJCCgdnZW5lcmFsGAIgASgLMiYubGFuZ2FtZS5wcm90b2J1Zi5UYWcuRmVlZGJhY2suR2VuZXJhbEgAUgdnZW5lcmFsEkgKCXJlbGV2YW5jZRgDIAEoCzIoLmxhbmdhbWUucHJvdG9idWYuVGFnLkZlZWRiYWNrLlJlbGV2YW5jZUgAUglyZWxldmFuY2UaHwoHR2VuZXJhbBIUCgVzY29yZRgBIAEoDVIFc2NvcmUaIQoJUmVsZXZhbmNlEhQKBXNjb3JlGAEgASgNUgVzY29yZUIGCgR0eXBlGn4KB0NvbnRleHQSGAoHY29udGVudBgBIAEoCVIHY29udGVudBI2CgR0eXBlGAIgASgOMiIubGFuZ2FtZS5wcm90b2J1Zi5UYWcuQ29udGV4dC5UeXBlUgR0eXBlIiEKBFR5cGUSDQoJV0lLSVBFRElBEAASCgoGT1BFTkFJEAFCBgoEdHlwZQ==');
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
    const {'1': 'latest_interactions', '3': 13, '4': 3, '5': 9, '10': 'latestInteractions'},
    const {'1': 'errors', '3': 14, '4': 3, '5': 9, '10': 'errors'},
    const {'1': 'last_login', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastLogin'},
    const {'1': 'last_logout', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastLogout'},
    const {'1': 'creation_time', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'creationTime'},
    const {'1': 'disabled', '3': 18, '4': 1, '5': 8, '10': 'disabled'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode('CgRVc2VyEhAKA3VpZBgBIAEoCVIDdWlkEhQKBWVtYWlsGAIgASgJUgVlbWFpbBIhCgxkaXNwbGF5X25hbWUYAyABKAlSC2Rpc3BsYXlOYW1lEiEKDHBob25lX251bWJlchgEIAEoCVILcGhvbmVOdW1iZXISGwoJcGhvdG9fdXJsGAUgASgJUghwaG90b1VybBIWCgZvbmxpbmUYBiABKAhSBm9ubGluZRIWCgZnb29nbGUYByABKAhSBmdvb2dsZRIaCghmYWNlYm9vaxgIIAEoCFIIZmFjZWJvb2sSFAoFYXBwbGUYCSABKAhSBWFwcGxlEikKEGZhdm91cml0ZV90b3BpY3MYCiADKAlSD2Zhdm91cml0ZVRvcGljcxIQCgN0YWcYCyABKAlSA3RhZxIWCgZ0b2tlbnMYDCADKAlSBnRva2VucxIvChNsYXRlc3RfaW50ZXJhY3Rpb25zGA0gAygJUhJsYXRlc3RJbnRlcmFjdGlvbnMSFgoGZXJyb3JzGA4gAygJUgZlcnJvcnMSOQoKbGFzdF9sb2dpbhgPIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWxhc3RMb2dpbhI7CgtsYXN0X2xvZ291dBgQIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCmxhc3RMb2dvdXQSPwoNY3JlYXRpb25fdGltZRgRIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDGNyZWF0aW9uVGltZRIaCghkaXNhYmxlZBgSIAEoCFIIZGlzYWJsZWQ=');
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
  ],
};

/// Descriptor for `UserPreference`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userPreferenceDescriptor = $convert.base64Decode('Cg5Vc2VyUHJlZmVyZW5jZRIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSRAoedW5rbm93bl9wZW9wbGVfcmVjb21tZW5kYXRpb25zGAMgASgIUhx1bmtub3duUGVvcGxlUmVjb21tZW5kYXRpb25zEh8KC3RoZW1lX2luZGV4GAQgASgFUgp0aGVtZUluZGV4Ei8KFGhhc19kb25lX29uX2JvYXJkaW5nGAUgASgIUhFoYXNEb25lT25Cb2FyZGluZxIlCg5zZWFyY2hfaGlzdG9yeRgGIAMoCVINc2VhcmNoSGlzdG9yeRIqChFzaGFrZV90b19mZWVkYmFjaxgHIAEoCFIPc2hha2VUb0ZlZWRiYWNr');
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
    const {'1': 'current_audio_id', '3': 12, '4': 1, '5': 5, '10': 'currentAudioId'},
  ],
};

/// Descriptor for `Langame`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List langameDescriptor = $convert.base64Decode('CgdMYW5nYW1lEiEKDGNoYW5uZWxfbmFtZRgBIAEoCVILY2hhbm5lbE5hbWUSGAoHcGxheWVycxgCIAMoCVIHcGxheWVycxIWCgZ0b3BpY3MYAyADKAlSBnRvcGljcxIUCgVtZW1lcxgEIAMoCVIFbWVtZXMSHAoJaW5pdGlhdG9yGAUgASgJUglpbml0aWF0b3ISLgoEZG9uZRgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSBGRvbmUSIQoMY3VycmVudF9tZW1lGAggASgFUgtjdXJyZW50TWVtZRIuCgRkYXRlGAkgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIEZGF0ZRIWCgZlcnJvcnMYCiADKAlSBmVycm9ycxI0CgdzdGFydGVkGAsgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIHc3RhcnRlZBIoChBjdXJyZW50X2F1ZGlvX2lkGAwgASgFUg5jdXJyZW50QXVkaW9JZA==');
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
@$core.Deprecated('Use paintDescriptor instead')
const Paint$json = const {
  '1': 'Paint',
  '2': const [
    const {'1': 'selection_rectangle', '3': 1, '4': 1, '5': 11, '6': '.langame.protobuf.Paint.SelectionRectangle', '9': 0, '10': 'selectionRectangle'},
    const {'1': 'selection_circle', '3': 2, '4': 1, '5': 11, '6': '.langame.protobuf.Paint.SelectionCircle', '9': 0, '10': 'selectionCircle'},
    const {'1': 'selection_line', '3': 3, '4': 1, '5': 11, '6': '.langame.protobuf.Paint.SelectionLine', '9': 0, '10': 'selectionLine'},
    const {'1': 'selection_text', '3': 4, '4': 1, '5': 11, '6': '.langame.protobuf.Paint.SelectionText', '9': 0, '10': 'selectionText'},
    const {'1': 'draw_rectangle', '3': 5, '4': 1, '5': 11, '6': '.langame.protobuf.Paint.DrawRectangle', '9': 0, '10': 'drawRectangle'},
    const {'1': 'draw_circle', '3': 6, '4': 1, '5': 11, '6': '.langame.protobuf.Paint.DrawCircle', '9': 0, '10': 'drawCircle'},
    const {'1': 'draw_line', '3': 7, '4': 1, '5': 11, '6': '.langame.protobuf.Paint.DrawLine', '9': 0, '10': 'drawLine'},
    const {'1': 'draw_points', '3': 8, '4': 1, '5': 11, '6': '.langame.protobuf.Paint.DrawPoints', '9': 0, '10': 'drawPoints'},
    const {'1': 'draw_text', '3': 9, '4': 1, '5': 11, '6': '.langame.protobuf.Paint.DrawText', '9': 0, '10': 'drawText'},
    const {'1': 'clear_all', '3': 10, '4': 1, '5': 11, '6': '.langame.protobuf.Paint.Clear', '9': 0, '10': 'clearAll'},
    const {'1': 'edit_text', '3': 11, '4': 1, '5': 11, '6': '.langame.protobuf.Paint.EditText', '9': 0, '10': 'editText'},
  ],
  '3': const [Paint_SelectionRectangle$json, Paint_SelectionCircle$json, Paint_SelectionLine$json, Paint_SelectionText$json, Paint_DrawShape$json, Paint_DrawRectangle$json, Paint_DrawCircle$json, Paint_DrawLine$json, Paint_DrawPoints$json, Paint_DrawText$json, Paint_Clear$json, Paint_EditText$json],
  '4': const [Paint_Shape$json],
  '8': const [
    const {'1': 'action'},
  ],
};

@$core.Deprecated('Use paintDescriptor instead')
const Paint_SelectionRectangle$json = const {
  '1': 'SelectionRectangle',
  '2': const [
    const {'1': 'shape_properties', '3': 1, '4': 1, '5': 11, '6': '.langame.protobuf.Paint.DrawShape', '10': 'shapeProperties'},
    const {'1': 'shift_x', '3': 2, '4': 1, '5': 1, '10': 'shiftX'},
    const {'1': 'shift_y', '3': 3, '4': 1, '5': 1, '10': 'shiftY'},
  ],
};

@$core.Deprecated('Use paintDescriptor instead')
const Paint_SelectionCircle$json = const {
  '1': 'SelectionCircle',
  '2': const [
    const {'1': 'shape_properties', '3': 1, '4': 1, '5': 11, '6': '.langame.protobuf.Paint.DrawShape', '10': 'shapeProperties'},
    const {'1': 'shift_x', '3': 2, '4': 1, '5': 1, '10': 'shiftX'},
    const {'1': 'shift_y', '3': 3, '4': 1, '5': 1, '10': 'shiftY'},
  ],
};

@$core.Deprecated('Use paintDescriptor instead')
const Paint_SelectionLine$json = const {
  '1': 'SelectionLine',
  '2': const [
    const {'1': 'shape_properties', '3': 1, '4': 1, '5': 11, '6': '.langame.protobuf.Paint.DrawShape', '10': 'shapeProperties'},
    const {'1': 'is_p1', '3': 2, '4': 1, '5': 8, '10': 'isP1'},
    const {'1': 'new_x', '3': 3, '4': 1, '5': 1, '10': 'newX'},
    const {'1': 'new_y', '3': 4, '4': 1, '5': 1, '10': 'newY'},
  ],
};

@$core.Deprecated('Use paintDescriptor instead')
const Paint_SelectionText$json = const {
  '1': 'SelectionText',
  '2': const [
    const {'1': 'shape_properties', '3': 1, '4': 1, '5': 11, '6': '.langame.protobuf.Paint.DrawShape', '10': 'shapeProperties'},
    const {'1': 'new_x', '3': 2, '4': 1, '5': 1, '10': 'newX'},
    const {'1': 'new_y', '3': 3, '4': 1, '5': 1, '10': 'newY'},
  ],
};

@$core.Deprecated('Use paintDescriptor instead')
const Paint_DrawShape$json = const {
  '1': 'DrawShape',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'r', '3': 6, '4': 1, '5': 5, '10': 'r'},
    const {'1': 'g', '3': 7, '4': 1, '5': 5, '10': 'g'},
    const {'1': 'b', '3': 8, '4': 1, '5': 5, '10': 'b'},
    const {'1': 'screenWidth', '3': 9, '4': 1, '5': 1, '10': 'screenWidth'},
    const {'1': 'screenHeight', '3': 10, '4': 1, '5': 1, '10': 'screenHeight'},
  ],
};

@$core.Deprecated('Use paintDescriptor instead')
const Paint_DrawRectangle$json = const {
  '1': 'DrawRectangle',
  '2': const [
    const {'1': 'shape_properties', '3': 1, '4': 1, '5': 11, '6': '.langame.protobuf.Paint.DrawShape', '10': 'shapeProperties'},
    const {'1': 'bottom_left_x', '3': 2, '4': 1, '5': 1, '10': 'bottomLeftX'},
    const {'1': 'bottom_left_y', '3': 3, '4': 1, '5': 1, '10': 'bottomLeftY'},
    const {'1': 'top_right_x', '3': 4, '4': 1, '5': 1, '10': 'topRightX'},
    const {'1': 'top_right_y', '3': 5, '4': 1, '5': 1, '10': 'topRightY'},
  ],
};

@$core.Deprecated('Use paintDescriptor instead')
const Paint_DrawCircle$json = const {
  '1': 'DrawCircle',
  '2': const [
    const {'1': 'shape_properties', '3': 1, '4': 1, '5': 11, '6': '.langame.protobuf.Paint.DrawShape', '10': 'shapeProperties'},
    const {'1': 'center_x', '3': 2, '4': 1, '5': 1, '10': 'centerX'},
    const {'1': 'center_y', '3': 3, '4': 1, '5': 1, '10': 'centerY'},
    const {'1': 'radius', '3': 4, '4': 1, '5': 1, '10': 'radius'},
  ],
};

@$core.Deprecated('Use paintDescriptor instead')
const Paint_DrawLine$json = const {
  '1': 'DrawLine',
  '2': const [
    const {'1': 'shape_properties', '3': 1, '4': 1, '5': 11, '6': '.langame.protobuf.Paint.DrawShape', '10': 'shapeProperties'},
    const {'1': 'p1_x', '3': 2, '4': 1, '5': 1, '10': 'p1X'},
    const {'1': 'p1_y', '3': 3, '4': 1, '5': 1, '10': 'p1Y'},
    const {'1': 'p2_x', '3': 4, '4': 1, '5': 1, '10': 'p2X'},
    const {'1': 'p2_y', '3': 5, '4': 1, '5': 1, '10': 'p2Y'},
  ],
};

@$core.Deprecated('Use paintDescriptor instead')
const Paint_DrawPoints$json = const {
  '1': 'DrawPoints',
  '2': const [
    const {'1': 'shape_properties', '3': 1, '4': 1, '5': 11, '6': '.langame.protobuf.Paint.DrawShape', '10': 'shapeProperties'},
    const {'1': 'position_x', '3': 4, '4': 1, '5': 1, '10': 'positionX'},
    const {'1': 'position_y', '3': 5, '4': 1, '5': 1, '10': 'positionY'},
  ],
};

@$core.Deprecated('Use paintDescriptor instead')
const Paint_DrawText$json = const {
  '1': 'DrawText',
  '2': const [
    const {'1': 'shape_properties', '3': 1, '4': 1, '5': 11, '6': '.langame.protobuf.Paint.DrawShape', '10': 'shapeProperties'},
    const {'1': 'position_x', '3': 4, '4': 1, '5': 1, '10': 'positionX'},
    const {'1': 'position_y', '3': 5, '4': 1, '5': 1, '10': 'positionY'},
  ],
};

@$core.Deprecated('Use paintDescriptor instead')
const Paint_Clear$json = const {
  '1': 'Clear',
};

@$core.Deprecated('Use paintDescriptor instead')
const Paint_EditText$json = const {
  '1': 'EditText',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'text', '3': 2, '4': 1, '5': 9, '10': 'text'},
  ],
};

@$core.Deprecated('Use paintDescriptor instead')
const Paint_Shape$json = const {
  '1': 'Shape',
  '2': const [
    const {'1': 'Rectangle', '2': 0},
    const {'1': 'Circle', '2': 1},
    const {'1': 'Line', '2': 2},
    const {'1': 'Text', '2': 3},
  ],
};

/// Descriptor for `Paint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paintDescriptor = $convert.base64Decode('CgVQYWludBJdChNzZWxlY3Rpb25fcmVjdGFuZ2xlGAEgASgLMioubGFuZ2FtZS5wcm90b2J1Zi5QYWludC5TZWxlY3Rpb25SZWN0YW5nbGVIAFISc2VsZWN0aW9uUmVjdGFuZ2xlElQKEHNlbGVjdGlvbl9jaXJjbGUYAiABKAsyJy5sYW5nYW1lLnByb3RvYnVmLlBhaW50LlNlbGVjdGlvbkNpcmNsZUgAUg9zZWxlY3Rpb25DaXJjbGUSTgoOc2VsZWN0aW9uX2xpbmUYAyABKAsyJS5sYW5nYW1lLnByb3RvYnVmLlBhaW50LlNlbGVjdGlvbkxpbmVIAFINc2VsZWN0aW9uTGluZRJOCg5zZWxlY3Rpb25fdGV4dBgEIAEoCzIlLmxhbmdhbWUucHJvdG9idWYuUGFpbnQuU2VsZWN0aW9uVGV4dEgAUg1zZWxlY3Rpb25UZXh0Ek4KDmRyYXdfcmVjdGFuZ2xlGAUgASgLMiUubGFuZ2FtZS5wcm90b2J1Zi5QYWludC5EcmF3UmVjdGFuZ2xlSABSDWRyYXdSZWN0YW5nbGUSRQoLZHJhd19jaXJjbGUYBiABKAsyIi5sYW5nYW1lLnByb3RvYnVmLlBhaW50LkRyYXdDaXJjbGVIAFIKZHJhd0NpcmNsZRI/CglkcmF3X2xpbmUYByABKAsyIC5sYW5nYW1lLnByb3RvYnVmLlBhaW50LkRyYXdMaW5lSABSCGRyYXdMaW5lEkUKC2RyYXdfcG9pbnRzGAggASgLMiIubGFuZ2FtZS5wcm90b2J1Zi5QYWludC5EcmF3UG9pbnRzSABSCmRyYXdQb2ludHMSPwoJZHJhd190ZXh0GAkgASgLMiAubGFuZ2FtZS5wcm90b2J1Zi5QYWludC5EcmF3VGV4dEgAUghkcmF3VGV4dBI8CgljbGVhcl9hbGwYCiABKAsyHS5sYW5nYW1lLnByb3RvYnVmLlBhaW50LkNsZWFySABSCGNsZWFyQWxsEj8KCWVkaXRfdGV4dBgLIAEoCzIgLmxhbmdhbWUucHJvdG9idWYuUGFpbnQuRWRpdFRleHRIAFIIZWRpdFRleHQalAEKElNlbGVjdGlvblJlY3RhbmdsZRJMChBzaGFwZV9wcm9wZXJ0aWVzGAEgASgLMiEubGFuZ2FtZS5wcm90b2J1Zi5QYWludC5EcmF3U2hhcGVSD3NoYXBlUHJvcGVydGllcxIXCgdzaGlmdF94GAIgASgBUgZzaGlmdFgSFwoHc2hpZnRfeRgDIAEoAVIGc2hpZnRZGpEBCg9TZWxlY3Rpb25DaXJjbGUSTAoQc2hhcGVfcHJvcGVydGllcxgBIAEoCzIhLmxhbmdhbWUucHJvdG9idWYuUGFpbnQuRHJhd1NoYXBlUg9zaGFwZVByb3BlcnRpZXMSFwoHc2hpZnRfeBgCIAEoAVIGc2hpZnRYEhcKB3NoaWZ0X3kYAyABKAFSBnNoaWZ0WRqcAQoNU2VsZWN0aW9uTGluZRJMChBzaGFwZV9wcm9wZXJ0aWVzGAEgASgLMiEubGFuZ2FtZS5wcm90b2J1Zi5QYWludC5EcmF3U2hhcGVSD3NoYXBlUHJvcGVydGllcxITCgVpc19wMRgCIAEoCFIEaXNQMRITCgVuZXdfeBgDIAEoAVIEbmV3WBITCgVuZXdfeRgEIAEoAVIEbmV3WRqHAQoNU2VsZWN0aW9uVGV4dBJMChBzaGFwZV9wcm9wZXJ0aWVzGAEgASgLMiEubGFuZ2FtZS5wcm90b2J1Zi5QYWludC5EcmF3U2hhcGVSD3NoYXBlUHJvcGVydGllcxITCgVuZXdfeBgCIAEoAVIEbmV3WBITCgVuZXdfeRgDIAEoAVIEbmV3WRqLAQoJRHJhd1NoYXBlEg4KAmlkGAEgASgJUgJpZBIMCgFyGAYgASgFUgFyEgwKAWcYByABKAVSAWcSDAoBYhgIIAEoBVIBYhIgCgtzY3JlZW5XaWR0aBgJIAEoAVILc2NyZWVuV2lkdGgSIgoMc2NyZWVuSGVpZ2h0GAogASgBUgxzY3JlZW5IZWlnaHQa5QEKDURyYXdSZWN0YW5nbGUSTAoQc2hhcGVfcHJvcGVydGllcxgBIAEoCzIhLmxhbmdhbWUucHJvdG9idWYuUGFpbnQuRHJhd1NoYXBlUg9zaGFwZVByb3BlcnRpZXMSIgoNYm90dG9tX2xlZnRfeBgCIAEoAVILYm90dG9tTGVmdFgSIgoNYm90dG9tX2xlZnRfeRgDIAEoAVILYm90dG9tTGVmdFkSHgoLdG9wX3JpZ2h0X3gYBCABKAFSCXRvcFJpZ2h0WBIeCgt0b3BfcmlnaHRfeRgFIAEoAVIJdG9wUmlnaHRZGqgBCgpEcmF3Q2lyY2xlEkwKEHNoYXBlX3Byb3BlcnRpZXMYASABKAsyIS5sYW5nYW1lLnByb3RvYnVmLlBhaW50LkRyYXdTaGFwZVIPc2hhcGVQcm9wZXJ0aWVzEhkKCGNlbnRlcl94GAIgASgBUgdjZW50ZXJYEhkKCGNlbnRlcl95GAMgASgBUgdjZW50ZXJZEhYKBnJhZGl1cxgEIAEoAVIGcmFkaXVzGqQBCghEcmF3TGluZRJMChBzaGFwZV9wcm9wZXJ0aWVzGAEgASgLMiEubGFuZ2FtZS5wcm90b2J1Zi5QYWludC5EcmF3U2hhcGVSD3NoYXBlUHJvcGVydGllcxIRCgRwMV94GAIgASgBUgNwMVgSEQoEcDFfeRgDIAEoAVIDcDFZEhEKBHAyX3gYBCABKAFSA3AyWBIRCgRwMl95GAUgASgBUgNwMlkamAEKCkRyYXdQb2ludHMSTAoQc2hhcGVfcHJvcGVydGllcxgBIAEoCzIhLmxhbmdhbWUucHJvdG9idWYuUGFpbnQuRHJhd1NoYXBlUg9zaGFwZVByb3BlcnRpZXMSHQoKcG9zaXRpb25feBgEIAEoAVIJcG9zaXRpb25YEh0KCnBvc2l0aW9uX3kYBSABKAFSCXBvc2l0aW9uWRqWAQoIRHJhd1RleHQSTAoQc2hhcGVfcHJvcGVydGllcxgBIAEoCzIhLmxhbmdhbWUucHJvdG9idWYuUGFpbnQuRHJhd1NoYXBlUg9zaGFwZVByb3BlcnRpZXMSHQoKcG9zaXRpb25feBgEIAEoAVIJcG9zaXRpb25YEh0KCnBvc2l0aW9uX3kYBSABKAFSCXBvc2l0aW9uWRoHCgVDbGVhchouCghFZGl0VGV4dBIOCgJpZBgBIAEoCVICaWQSEgoEdGV4dBgCIAEoCVIEdGV4dCI2CgVTaGFwZRINCglSZWN0YW5nbGUQABIKCgZDaXJjbGUQARIICgRMaW5lEAISCAoEVGV4dBADQggKBmFjdGlvbg==');
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
