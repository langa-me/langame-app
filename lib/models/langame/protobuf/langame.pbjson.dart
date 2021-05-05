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
final $typed_data.Uint8List interactionLevelDescriptor = $convert.base64Decode(
    'ChBJbnRlcmFjdGlvbkxldmVsEgcKA0JBRBAAEgsKB0FWRVJBR0UQARIJCgVHUkVBVBACEggKBExPVkUQAw==');
@$core.Deprecated('Use topicDescriptor instead')
const Topic$json = const {
  '1': 'Topic',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'content', '3': 2, '4': 1, '5': 9, '10': 'content'},
  ],
};

/// Descriptor for `Topic`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List topicDescriptor = $convert.base64Decode(
    'CgVUb3BpYxIOCgJpZBgBIAEoCVICaWQSGAoHY29udGVudBgCIAEoCVIHY29udGVudA==');
@$core.Deprecated('Use questionDescriptor instead')
const Question$json = const {
  '1': 'Question',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'content', '3': 2, '4': 1, '5': 9, '10': 'content'},
    const {'1': 'contexts', '3': 3, '4': 3, '5': 9, '10': 'contexts'},
  ],
};

/// Descriptor for `Question`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List questionDescriptor = $convert.base64Decode(
    'CghRdWVzdGlvbhIOCgJpZBgBIAEoCVICaWQSGAoHY29udGVudBgCIAEoCVIHY29udGVudBIaCghjb250ZXh0cxgDIAMoCVIIY29udGV4dHM=');
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
final $typed_data.Uint8List tagDescriptor = $convert.base64Decode(
    'CgNUYWcSDgoCaWQYASABKAlSAmlkEhgKB2NvbnRlbnQYAiABKAlSB2NvbnRlbnQSFAoFc2NvcmUYAyABKAFSBXNjb3JlEhQKBWh1bWFuGAQgASgIUgVodW1hbhIaCghxdWVzdGlvbhgFIAEoCVIIcXVlc3Rpb24SHAoJZ2VuZXJhdGVkGAYgASgIUglnZW5lcmF0ZWQ=');
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
    const {
      '1': 'favourite_topics',
      '3': 10,
      '4': 3,
      '5': 9,
      '10': 'favouriteTopics'
    },
    const {'1': 'tag', '3': 11, '4': 1, '5': 9, '10': 'tag'},
    const {'1': 'tokens', '3': 12, '4': 3, '5': 9, '10': 'tokens'},
    const {
      '1': 'latest_interactions',
      '3': 13,
      '4': 3,
      '5': 9,
      '10': 'latestInteractions'
    },
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEhAKA3VpZBgBIAEoCVIDdWlkEhQKBWVtYWlsGAIgASgJUgVlbWFpbBIhCgxkaXNwbGF5X25hbWUYAyABKAlSC2Rpc3BsYXlOYW1lEiEKDHBob25lX251bWJlchgEIAEoCVILcGhvbmVOdW1iZXISGwoJcGhvdG9fdXJsGAUgASgJUghwaG90b1VybBIWCgZvbmxpbmUYBiABKAhSBm9ubGluZRIWCgZnb29nbGUYByABKAhSBmdvb2dsZRIaCghmYWNlYm9vaxgIIAEoCFIIZmFjZWJvb2sSFAoFYXBwbGUYCSABKAhSBWFwcGxlEikKEGZhdm91cml0ZV90b3BpY3MYCiADKAlSD2Zhdm91cml0ZVRvcGljcxIQCgN0YWcYCyABKAlSA3RhZxIWCgZ0b2tlbnMYDCADKAlSBnRva2VucxIvChNsYXRlc3RfaW50ZXJhY3Rpb25zGA0gAygJUhJsYXRlc3RJbnRlcmFjdGlvbnM=');
@$core.Deprecated('Use userPreferenceDescriptor instead')
const UserPreference$json = const {
  '1': 'UserPreference',
  '2': const [
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {
      '1': 'unknown_people_recommendations',
      '3': 3,
      '4': 1,
      '5': 8,
      '10': 'unknownPeopleRecommendations'
    },
    const {'1': 'theme_index', '3': 4, '4': 1, '5': 5, '10': 'themeIndex'},
    const {
      '1': 'has_done_on_boarding',
      '3': 5,
      '4': 1,
      '5': 8,
      '10': 'hasDoneOnBoarding'
    },
    const {
      '1': 'search_history',
      '3': 6,
      '4': 3,
      '5': 9,
      '10': 'searchHistory'
    },
    const {
      '1': 'shake_to_feedback',
      '3': 7,
      '4': 1,
      '5': 8,
      '10': 'shakeToFeedback'
    },
  ],
};

/// Descriptor for `UserPreference`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userPreferenceDescriptor = $convert.base64Decode(
    'Cg5Vc2VyUHJlZmVyZW5jZRIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSRAoedW5rbm93bl9wZW9wbGVfcmVjb21tZW5kYXRpb25zGAMgASgIUhx1bmtub3duUGVvcGxlUmVjb21tZW5kYXRpb25zEh8KC3RoZW1lX2luZGV4GAQgASgFUgp0aGVtZUluZGV4Ei8KFGhhc19kb25lX29uX2JvYXJkaW5nGAUgASgIUhFoYXNEb25lT25Cb2FyZGluZxIlCg5zZWFyY2hfaGlzdG9yeRgGIAMoCVINc2VhcmNoSGlzdG9yeRIqChFzaGFrZV90b19mZWVkYmFjaxgHIAEoCFIPc2hha2VUb0ZlZWRiYWNr');
@$core.Deprecated('Use channelUserLangameUserDescriptor instead')
const ChannelUserLangameUser$json = const {
  '1': 'ChannelUserLangameUser',
  '2': const [
    const {'1': 'channel_uid', '3': 1, '4': 1, '5': 13, '10': 'channelUid'},
    const {'1': 'langame_uid', '3': 2, '4': 1, '5': 9, '10': 'langameUid'},
  ],
};

/// Descriptor for `ChannelUserLangameUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelUserLangameUserDescriptor =
    $convert.base64Decode(
        'ChZDaGFubmVsVXNlckxhbmdhbWVVc2VyEh8KC2NoYW5uZWxfdWlkGAEgASgNUgpjaGFubmVsVWlkEh8KC2xhbmdhbWVfdWlkGAIgASgJUgpsYW5nYW1lVWlk');
@$core.Deprecated('Use langameDescriptor instead')
const Langame$json = const {
  '1': 'Langame',
  '2': const [
    const {'1': 'channelName', '3': 1, '4': 1, '5': 9, '10': 'channelName'},
    const {
      '1': 'players',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.langame.protobuf.ChannelUserLangameUser',
      '10': 'players'
    },
    const {'1': 'topics', '3': 3, '4': 3, '5': 9, '10': 'topics'},
    const {
      '1': 'questions',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.langame.protobuf.Question',
      '10': 'questions'
    },
  ],
};

/// Descriptor for `Langame`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List langameDescriptor = $convert.base64Decode(
    'CgdMYW5nYW1lEiAKC2NoYW5uZWxOYW1lGAEgASgJUgtjaGFubmVsTmFtZRJCCgdwbGF5ZXJzGAIgAygLMigubGFuZ2FtZS5wcm90b2J1Zi5DaGFubmVsVXNlckxhbmdhbWVVc2VyUgdwbGF5ZXJzEhYKBnRvcGljcxgDIAMoCVIGdG9waWNzEjgKCXF1ZXN0aW9ucxgEIAMoCzIaLmxhbmdhbWUucHJvdG9idWYuUXVlc3Rpb25SCXF1ZXN0aW9ucw==');
