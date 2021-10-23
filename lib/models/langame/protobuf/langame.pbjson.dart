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
@$core.Deprecated('Use contentFilterDescriptor instead')
const ContentFilter$json = const {
  '1': 'ContentFilter',
  '2': const [
    const {'1': 'Safe', '2': 0},
    const {'1': 'Sensitive', '2': 1},
    const {'1': 'Unsafe', '2': 2},
  ],
};

/// Descriptor for `ContentFilter`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List contentFilterDescriptor = $convert.base64Decode('Cg1Db250ZW50RmlsdGVyEggKBFNhZmUQABINCglTZW5zaXRpdmUQARIKCgZVbnNhZmUQAg==');
@$core.Deprecated('Use errorDescriptor instead')
const Error$json = const {
  '1': 'Error',
  '2': const [
    const {'1': 'developerMessage', '3': 1, '4': 1, '5': 9, '10': 'developerMessage'},
    const {'1': 'createdAt', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'code', '3': 3, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'userMessage', '3': 4, '4': 1, '5': 9, '10': 'userMessage'},
  ],
};

/// Descriptor for `Error`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List errorDescriptor = $convert.base64Decode('CgVFcnJvchIqChBkZXZlbG9wZXJNZXNzYWdlGAEgASgJUhBkZXZlbG9wZXJNZXNzYWdlEjgKCWNyZWF0ZWRBdBgCIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBISCgRjb2RlGAMgASgJUgRjb2RlEiAKC3VzZXJNZXNzYWdlGAQgASgJUgt1c2VyTWVzc2FnZQ==');
@$core.Deprecated('Use seenMemesDescriptor instead')
const SeenMemes$json = const {
  '1': 'SeenMemes',
  '2': const [
    const {'1': 'seen', '3': 1, '4': 1, '5': 11, '6': '.langame.protobuf.SeenMemes.Seen', '10': 'seen'},
  ],
  '3': const [SeenMemes_Seen$json],
};

@$core.Deprecated('Use seenMemesDescriptor instead')
const SeenMemes_Seen$json = const {
  '1': 'Seen',
  '2': const [
    const {'1': 's', '3': 1, '4': 3, '5': 11, '6': '.langame.protobuf.SeenMemes.Seen.Single', '10': 's'},
  ],
  '3': const [SeenMemes_Seen_Single$json],
};

@$core.Deprecated('Use seenMemesDescriptor instead')
const SeenMemes_Seen_Single$json = const {
  '1': 'Single',
  '2': const [
    const {'1': 'date', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'date'},
    const {'1': 'meme', '3': 2, '4': 1, '5': 9, '10': 'meme'},
  ],
};

/// Descriptor for `SeenMemes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List seenMemesDescriptor = $convert.base64Decode('CglTZWVuTWVtZXMSNAoEc2VlbhgBIAEoCzIgLmxhbmdhbWUucHJvdG9idWYuU2Vlbk1lbWVzLlNlZW5SBHNlZW4aiwEKBFNlZW4SNQoBcxgBIAMoCzInLmxhbmdhbWUucHJvdG9idWYuU2Vlbk1lbWVzLlNlZW4uU2luZ2xlUgFzGkwKBlNpbmdsZRIuCgRkYXRlGAEgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIEZGF0ZRISCgRtZW1lGAIgASgJUgRtZW1l');
@$core.Deprecated('Use memeDescriptor instead')
const Meme$json = const {
  '1': 'Meme',
  '2': const [
    const {'1': 'created_at', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'content', '3': 2, '4': 1, '5': 9, '10': 'content'},
    const {'1': 'topics', '3': 4, '4': 3, '5': 9, '10': 'topics'},
    const {'1': 'prompt_id', '3': 5, '4': 1, '5': 9, '10': 'promptId'},
    const {'1': 'translated', '3': 6, '4': 3, '5': 11, '6': '.langame.protobuf.Meme.TranslatedEntry', '10': 'translated'},
    const {'1': 'id', '3': 7, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'disabled', '3': 8, '4': 1, '5': 8, '10': 'disabled'},
  ],
  '3': const [Meme_TranslatedEntry$json],
};

@$core.Deprecated('Use memeDescriptor instead')
const Meme_TranslatedEntry$json = const {
  '1': 'TranslatedEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `Meme`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List memeDescriptor = $convert.base64Decode('CgRNZW1lEjkKCmNyZWF0ZWRfYXQYASABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSGAoHY29udGVudBgCIAEoCVIHY29udGVudBIWCgZ0b3BpY3MYBCADKAlSBnRvcGljcxIbCglwcm9tcHRfaWQYBSABKAlSCHByb21wdElkEkYKCnRyYW5zbGF0ZWQYBiADKAsyJi5sYW5nYW1lLnByb3RvYnVmLk1lbWUuVHJhbnNsYXRlZEVudHJ5Ugp0cmFuc2xhdGVkEg4KAmlkGAcgASgJUgJpZBIaCghkaXNhYmxlZBgIIAEoCFIIZGlzYWJsZWQaPQoPVHJhbnNsYXRlZEVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');
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
    const {'1': 'errors', '3': 14, '4': 3, '5': 11, '6': '.langame.protobuf.Error', '10': 'errors'},
    const {'1': 'last_login', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastLogin'},
    const {'1': 'last_logout', '3': 16, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastLogout'},
    const {'1': 'creation_time', '3': 17, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'creationTime'},
    const {'1': 'disabled', '3': 18, '4': 1, '5': 8, '10': 'disabled'},
    const {'1': 'devices', '3': 19, '4': 3, '5': 11, '6': '.langame.protobuf.User.Device', '10': 'devices'},
    const {'1': 'credits', '3': 20, '4': 1, '5': 5, '10': 'credits'},
    const {'1': 'role', '3': 21, '4': 1, '5': 9, '10': 'role'},
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
final $typed_data.Uint8List userDescriptor = $convert.base64Decode('CgRVc2VyEhAKA3VpZBgBIAEoCVIDdWlkEhQKBWVtYWlsGAIgASgJUgVlbWFpbBIhCgxkaXNwbGF5X25hbWUYAyABKAlSC2Rpc3BsYXlOYW1lEiEKDHBob25lX251bWJlchgEIAEoCVILcGhvbmVOdW1iZXISGwoJcGhvdG9fdXJsGAUgASgJUghwaG90b1VybBIWCgZvbmxpbmUYBiABKAhSBm9ubGluZRIWCgZnb29nbGUYByABKAhSBmdvb2dsZRIUCgVhcHBsZRgJIAEoCFIFYXBwbGUSEAoDdGFnGAsgASgJUgN0YWcSFgoGdG9rZW5zGAwgAygJUgZ0b2tlbnMSLwoTbGF0ZXN0X2ludGVyYWN0aW9ucxgNIAMoCVISbGF0ZXN0SW50ZXJhY3Rpb25zEi8KBmVycm9ycxgOIAMoCzIXLmxhbmdhbWUucHJvdG9idWYuRXJyb3JSBmVycm9ycxI5CgpsYXN0X2xvZ2luGA8gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJbGFzdExvZ2luEjsKC2xhc3RfbG9nb3V0GBAgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKbGFzdExvZ291dBI/Cg1jcmVhdGlvbl90aW1lGBEgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMY3JlYXRpb25UaW1lEhoKCGRpc2FibGVkGBIgASgIUghkaXNhYmxlZBI3CgdkZXZpY2VzGBMgAygLMh0ubGFuZ2FtZS5wcm90b2J1Zi5Vc2VyLkRldmljZVIHZGV2aWNlcxIYCgdjcmVkaXRzGBQgASgFUgdjcmVkaXRzEhIKBHJvbGUYFSABKAlSBHJvbGUaUgoGRGV2aWNlEicKD2xhbmdhbWVfdmVyc2lvbhgBIAEoCVIObGFuZ2FtZVZlcnNpb24SHwoLZGV2aWNlX2luZm8YAiABKAlSCmRldmljZUluZm8=');
@$core.Deprecated('Use userPreferenceDescriptor instead')
const UserPreference$json = const {
  '1': 'UserPreference',
  '2': const [
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'user_recommendations', '3': 3, '4': 1, '5': 14, '6': '.langame.protobuf.UserPreference.RecommendationType', '10': 'userRecommendations'},
    const {'1': 'theme_index', '3': 4, '4': 1, '5': 5, '10': 'themeIndex'},
    const {'1': 'has_done_on_boarding', '3': 5, '4': 1, '5': 8, '10': 'hasDoneOnBoarding'},
    const {'1': 'user_search_history', '3': 6, '4': 3, '5': 9, '10': 'userSearchHistory'},
    const {'1': 'shake_to_feedback', '3': 7, '4': 1, '5': 8, '10': 'shakeToFeedback'},
    const {'1': 'favorite_topics', '3': 8, '4': 3, '5': 9, '10': 'favoriteTopics'},
    const {'1': 'topic_search_history', '3': 9, '4': 3, '5': 9, '10': 'topicSearchHistory'},
    const {'1': 'errors', '3': 10, '4': 3, '5': 11, '6': '.langame.protobuf.Error', '10': 'errors'},
    const {'1': 'speech_to_text_locale', '3': 11, '4': 1, '5': 9, '10': 'speechToTextLocale'},
    const {'1': 'saw_whats_new', '3': 13, '4': 1, '5': 8, '10': 'sawWhatsNew'},
    const {'1': 'notification', '3': 14, '4': 1, '5': 11, '6': '.langame.protobuf.UserPreference.Notification', '10': 'notification'},
    const {'1': 'preview_mode', '3': 15, '4': 1, '5': 8, '10': 'previewMode'},
  ],
  '3': const [UserPreference_Notification$json],
  '4': const [UserPreference_RecommendationType$json],
};

@$core.Deprecated('Use userPreferenceDescriptor instead')
const UserPreference_Notification$json = const {
  '1': 'Notification',
  '2': const [
    const {'1': 'invite', '3': 1, '4': 1, '5': 11, '6': '.langame.protobuf.UserPreference.Notification.Invite', '10': 'invite'},
    const {'1': 'message', '3': 2, '4': 1, '5': 11, '6': '.langame.protobuf.UserPreference.Notification.Message', '10': 'message'},
  ],
  '3': const [UserPreference_Notification_Invite$json, UserPreference_Notification_Message$json],
};

@$core.Deprecated('Use userPreferenceDescriptor instead')
const UserPreference_Notification_Invite$json = const {
  '1': 'Invite',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 8, '10': 'email'},
    const {'1': 'push', '3': 2, '4': 1, '5': 8, '10': 'push'},
  ],
};

@$core.Deprecated('Use userPreferenceDescriptor instead')
const UserPreference_Notification_Message$json = const {
  '1': 'Message',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 8, '10': 'email'},
    const {'1': 'push', '3': 2, '4': 1, '5': 8, '10': 'push'},
  ],
};

@$core.Deprecated('Use userPreferenceDescriptor instead')
const UserPreference_RecommendationType$json = const {
  '1': 'RecommendationType',
  '2': const [
    const {'1': 'NONE', '2': 0},
    const {'1': 'NEW', '2': 1},
    const {'1': 'COMPOUND', '2': 2},
    const {'1': 'ALL', '2': 3},
  ],
};

/// Descriptor for `UserPreference`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userPreferenceDescriptor = $convert.base64Decode('Cg5Vc2VyUHJlZmVyZW5jZRIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSZgoUdXNlcl9yZWNvbW1lbmRhdGlvbnMYAyABKA4yMy5sYW5nYW1lLnByb3RvYnVmLlVzZXJQcmVmZXJlbmNlLlJlY29tbWVuZGF0aW9uVHlwZVITdXNlclJlY29tbWVuZGF0aW9ucxIfCgt0aGVtZV9pbmRleBgEIAEoBVIKdGhlbWVJbmRleBIvChRoYXNfZG9uZV9vbl9ib2FyZGluZxgFIAEoCFIRaGFzRG9uZU9uQm9hcmRpbmcSLgoTdXNlcl9zZWFyY2hfaGlzdG9yeRgGIAMoCVIRdXNlclNlYXJjaEhpc3RvcnkSKgoRc2hha2VfdG9fZmVlZGJhY2sYByABKAhSD3NoYWtlVG9GZWVkYmFjaxInCg9mYXZvcml0ZV90b3BpY3MYCCADKAlSDmZhdm9yaXRlVG9waWNzEjAKFHRvcGljX3NlYXJjaF9oaXN0b3J5GAkgAygJUhJ0b3BpY1NlYXJjaEhpc3RvcnkSLwoGZXJyb3JzGAogAygLMhcubGFuZ2FtZS5wcm90b2J1Zi5FcnJvclIGZXJyb3JzEjEKFXNwZWVjaF90b190ZXh0X2xvY2FsZRgLIAEoCVISc3BlZWNoVG9UZXh0TG9jYWxlEiIKDXNhd193aGF0c19uZXcYDSABKAhSC3Nhd1doYXRzTmV3ElEKDG5vdGlmaWNhdGlvbhgOIAEoCzItLmxhbmdhbWUucHJvdG9idWYuVXNlclByZWZlcmVuY2UuTm90aWZpY2F0aW9uUgxub3RpZmljYXRpb24SIQoMcHJldmlld19tb2RlGA8gASgIUgtwcmV2aWV3TW9kZRqWAgoMTm90aWZpY2F0aW9uEkwKBmludml0ZRgBIAEoCzI0LmxhbmdhbWUucHJvdG9idWYuVXNlclByZWZlcmVuY2UuTm90aWZpY2F0aW9uLkludml0ZVIGaW52aXRlEk8KB21lc3NhZ2UYAiABKAsyNS5sYW5nYW1lLnByb3RvYnVmLlVzZXJQcmVmZXJlbmNlLk5vdGlmaWNhdGlvbi5NZXNzYWdlUgdtZXNzYWdlGjIKBkludml0ZRIUCgVlbWFpbBgBIAEoCFIFZW1haWwSEgoEcHVzaBgCIAEoCFIEcHVzaBozCgdNZXNzYWdlEhQKBWVtYWlsGAEgASgIUgVlbWFpbBISCgRwdXNoGAIgASgIUgRwdXNoIj4KElJlY29tbWVuZGF0aW9uVHlwZRIICgROT05FEAASBwoDTkVXEAESDAoIQ09NUE9VTkQQAhIHCgNBTEwQAw==');
@$core.Deprecated('Use langameDescriptor instead')
const Langame$json = const {
  '1': 'Langame',
  '2': const [
    const {'1': 'channel_name', '3': 1, '4': 1, '5': 9, '10': 'channelName'},
    const {'1': 'players', '3': 2, '4': 3, '5': 9, '10': 'players'},
    const {'1': 'topics', '3': 3, '4': 3, '5': 9, '10': 'topics'},
    const {'1': 'memes', '3': 4, '4': 3, '5': 11, '6': '.langame.protobuf.Meme', '10': 'memes'},
    const {'1': 'initiator', '3': 5, '4': 1, '5': 9, '10': 'initiator'},
    const {'1': 'done', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'done'},
    const {'1': 'current_meme', '3': 8, '4': 1, '5': 5, '10': 'currentMeme'},
    const {'1': 'date', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'date'},
    const {'1': 'errors', '3': 10, '4': 3, '5': 11, '6': '.langame.protobuf.Error', '10': 'errors'},
    const {'1': 'started', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'started'},
    const {'1': 'next_meme', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'nextMeme'},
    const {'1': 'memes_seen', '3': 14, '4': 1, '5': 5, '10': 'memesSeen'},
    const {'1': 'meme_changed', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'memeChanged'},
    const {'1': 'link', '3': 16, '4': 1, '5': 9, '10': 'link'},
    const {'1': 'reserved_spots', '3': 18, '4': 3, '5': 9, '10': 'reservedSpots'},
    const {'1': 'is_locked', '3': 19, '4': 1, '5': 8, '10': 'isLocked'},
    const {'1': 'is_text', '3': 20, '4': 1, '5': 8, '10': 'isText'},
    const {'1': 'reflections', '3': 21, '4': 3, '5': 11, '6': '.langame.protobuf.Langame.Reflection', '10': 'reflections'},
    const {'1': 'suggestions', '3': 22, '4': 3, '5': 11, '6': '.langame.protobuf.Langame.Suggestion', '10': 'suggestions'},
  ],
  '3': const [Langame_Reflection$json, Langame_Suggestion$json],
};

@$core.Deprecated('Use langameDescriptor instead')
const Langame_Reflection$json = const {
  '1': 'Reflection',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'last_message_id', '3': 2, '4': 1, '5': 9, '10': 'lastMessageId'},
    const {'1': 'alternatives', '3': 3, '4': 3, '5': 9, '10': 'alternatives'},
    const {'1': 'created_at', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'content_filter', '3': 5, '4': 1, '5': 14, '6': '.langame.protobuf.ContentFilter', '10': 'contentFilter'},
  ],
};

@$core.Deprecated('Use langameDescriptor instead')
const Langame_Suggestion$json = const {
  '1': 'Suggestion',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'last_message_id', '3': 2, '4': 1, '5': 9, '10': 'lastMessageId'},
    const {'1': 'alternatives', '3': 3, '4': 3, '5': 9, '10': 'alternatives'},
    const {'1': 'created_at', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'content_filter', '3': 5, '4': 1, '5': 14, '6': '.langame.protobuf.ContentFilter', '10': 'contentFilter'},
  ],
};

/// Descriptor for `Langame`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List langameDescriptor = $convert.base64Decode('CgdMYW5nYW1lEiEKDGNoYW5uZWxfbmFtZRgBIAEoCVILY2hhbm5lbE5hbWUSGAoHcGxheWVycxgCIAMoCVIHcGxheWVycxIWCgZ0b3BpY3MYAyADKAlSBnRvcGljcxIsCgVtZW1lcxgEIAMoCzIWLmxhbmdhbWUucHJvdG9idWYuTWVtZVIFbWVtZXMSHAoJaW5pdGlhdG9yGAUgASgJUglpbml0aWF0b3ISLgoEZG9uZRgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSBGRvbmUSIQoMY3VycmVudF9tZW1lGAggASgFUgtjdXJyZW50TWVtZRIuCgRkYXRlGAkgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIEZGF0ZRIvCgZlcnJvcnMYCiADKAsyFy5sYW5nYW1lLnByb3RvYnVmLkVycm9yUgZlcnJvcnMSNAoHc3RhcnRlZBgLIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSB3N0YXJ0ZWQSNwoJbmV4dF9tZW1lGA0gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIIbmV4dE1lbWUSHQoKbWVtZXNfc2VlbhgOIAEoBVIJbWVtZXNTZWVuEj0KDG1lbWVfY2hhbmdlZBgPIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC21lbWVDaGFuZ2VkEhIKBGxpbmsYECABKAlSBGxpbmsSJQoOcmVzZXJ2ZWRfc3BvdHMYEiADKAlSDXJlc2VydmVkU3BvdHMSGwoJaXNfbG9ja2VkGBMgASgIUghpc0xvY2tlZBIXCgdpc190ZXh0GBQgASgIUgZpc1RleHQSRgoLcmVmbGVjdGlvbnMYFSADKAsyJC5sYW5nYW1lLnByb3RvYnVmLkxhbmdhbWUuUmVmbGVjdGlvblILcmVmbGVjdGlvbnMSRgoLc3VnZ2VzdGlvbnMYFiADKAsyJC5sYW5nYW1lLnByb3RvYnVmLkxhbmdhbWUuU3VnZ2VzdGlvblILc3VnZ2VzdGlvbnMa9AEKClJlZmxlY3Rpb24SFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEiYKD2xhc3RfbWVzc2FnZV9pZBgCIAEoCVINbGFzdE1lc3NhZ2VJZBIiCgxhbHRlcm5hdGl2ZXMYAyADKAlSDGFsdGVybmF0aXZlcxI5CgpjcmVhdGVkX2F0GAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EkYKDmNvbnRlbnRfZmlsdGVyGAUgASgOMh8ubGFuZ2FtZS5wcm90b2J1Zi5Db250ZW50RmlsdGVyUg1jb250ZW50RmlsdGVyGvQBCgpTdWdnZXN0aW9uEhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBImCg9sYXN0X21lc3NhZ2VfaWQYAiABKAlSDWxhc3RNZXNzYWdlSWQSIgoMYWx0ZXJuYXRpdmVzGAMgAygJUgxhbHRlcm5hdGl2ZXMSOQoKY3JlYXRlZF9hdBgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBJGCg5jb250ZW50X2ZpbHRlchgFIAEoDjIfLmxhbmdhbWUucHJvdG9idWYuQ29udGVudEZpbHRlclINY29udGVudEZpbHRlcg==');
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
    const {'1': 'errors', '3': 7, '4': 3, '5': 11, '6': '.langame.protobuf.Error', '10': 'errors'},
  ],
};

/// Descriptor for `Player`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playerDescriptor = $convert.base64Decode('CgZQbGF5ZXISFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEjMKB3RpbWVfaW4YAiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgZ0aW1lSW4SNQoIdGltZV9vdXQYAyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgd0aW1lT3V0EiwKBW5vdGVzGAQgAygLMhYubGFuZ2FtZS5wcm90b2J1Zi5Ob3RlUgVub3RlcxIZCghhdWRpb19pZBgFIAEoBVIHYXVkaW9JZBIfCgthdWRpb190b2tlbhgGIAEoCVIKYXVkaW9Ub2tlbhIvCgZlcnJvcnMYByADKAsyFy5sYW5nYW1lLnByb3RvYnVmLkVycm9yUgZlcnJvcnM=');
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
    const {'1': 'id', '3': 4, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'parameters', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Any', '10': 'parameters'},
  ],
};

/// Descriptor for `Prompt`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List promptDescriptor = $convert.base64Decode('CgZQcm9tcHQSEgoEdHlwZRgBIAEoCVIEdHlwZRIaCgh0ZW1wbGF0ZRgCIAEoCVIIdGVtcGxhdGUSDgoCaWQYBCABKAlSAmlkEjQKCnBhcmFtZXRlcnMYBSABKAsyFC5nb29nbGUucHJvdG9idWYuQW55UgpwYXJhbWV0ZXJz');
@$core.Deprecated('Use recordingDescriptor instead')
const Recording$json = const {
  '1': 'Recording',
  '2': const [
    const {'1': 'created_at', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'text', '3': 2, '4': 1, '5': 9, '10': 'text'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'metadata', '3': 4, '4': 3, '5': 11, '6': '.langame.protobuf.Recording.MetadataEntry', '10': 'metadata'},
    const {'1': 'note', '3': 5, '4': 1, '5': 9, '10': 'note'},
  ],
  '3': const [Recording_MetadataEntry$json],
};

@$core.Deprecated('Use recordingDescriptor instead')
const Recording_MetadataEntry$json = const {
  '1': 'MetadataEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `Recording`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recordingDescriptor = $convert.base64Decode('CglSZWNvcmRpbmcSOQoKY3JlYXRlZF9hdBgBIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBISCgR0ZXh0GAIgASgJUgR0ZXh0EhcKB3VzZXJfaWQYAyABKAlSBnVzZXJJZBJFCghtZXRhZGF0YRgEIAMoCzIpLmxhbmdhbWUucHJvdG9idWYuUmVjb3JkaW5nLk1ldGFkYXRhRW50cnlSCG1ldGFkYXRhEhIKBG5vdGUYBSABKAlSBG5vdGUaOwoNTWV0YWRhdGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');
@$core.Deprecated('Use messageDescriptor instead')
const Message$json = const {
  '1': 'Message',
  '2': const [
    const {'1': 'created_at', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'from_uid', '3': 4, '4': 1, '5': 9, '10': 'fromUid'},
    const {'1': 'to_uid', '3': 5, '4': 1, '5': 9, '10': 'toUid'},
    const {'1': 'channel_name', '3': 7, '4': 1, '5': 9, '10': 'channelName'},
    const {'1': 'type', '3': 8, '4': 1, '5': 14, '6': '.langame.protobuf.Message.Type', '10': 'type'},
    const {'1': 'body', '3': 9, '4': 1, '5': 9, '10': 'body'},
    const {'1': 'title', '3': 10, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'id', '3': 11, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'analysis', '3': 12, '4': 1, '5': 11, '6': '.langame.protobuf.Message.Analysis', '10': 'analysis'},
  ],
  '3': const [Message_Analysis$json],
  '4': const [Message_Type$json],
};

@$core.Deprecated('Use messageDescriptor instead')
const Message_Analysis$json = const {
  '1': 'Analysis',
  '2': const [
    const {'1': 'topics', '3': 1, '4': 3, '5': 9, '10': 'topics'},
    const {'1': 'sentiments', '3': 2, '4': 3, '5': 11, '6': '.langame.protobuf.Message.Analysis.Sentiment', '10': 'sentiments'},
    const {'1': 'error', '3': 3, '4': 1, '5': 11, '6': '.langame.protobuf.Message.Analysis.Error', '10': 'error'},
    const {'1': 'filter', '3': 4, '4': 1, '5': 14, '6': '.langame.protobuf.ContentFilter', '10': 'filter'},
  ],
  '3': const [Message_Analysis_Error$json, Message_Analysis_Sentiment$json],
};

@$core.Deprecated('Use messageDescriptor instead')
const Message_Analysis_Error$json = const {
  '1': 'Error',
  '2': const [
    const {'1': 'developer_message', '3': 1, '4': 1, '5': 9, '10': 'developerMessage'},
    const {'1': 'tries', '3': 2, '4': 1, '5': 5, '10': 'tries'},
  ],
};

@$core.Deprecated('Use messageDescriptor instead')
const Message_Analysis_Sentiment$json = const {
  '1': 'Sentiment',
  '2': const [
    const {'1': 'score', '3': 1, '4': 1, '5': 2, '10': 'score'},
    const {'1': 'label', '3': 2, '4': 1, '5': 9, '10': 'label'},
  ],
};

@$core.Deprecated('Use messageDescriptor instead')
const Message_Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'INVITE', '2': 0},
    const {'1': 'MESSAGE', '2': 1},
  ],
};

/// Descriptor for `Message`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDescriptor = $convert.base64Decode('CgdNZXNzYWdlEjkKCmNyZWF0ZWRfYXQYAyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSGQoIZnJvbV91aWQYBCABKAlSB2Zyb21VaWQSFQoGdG9fdWlkGAUgASgJUgV0b1VpZBIhCgxjaGFubmVsX25hbWUYByABKAlSC2NoYW5uZWxOYW1lEjIKBHR5cGUYCCABKA4yHi5sYW5nYW1lLnByb3RvYnVmLk1lc3NhZ2UuVHlwZVIEdHlwZRISCgRib2R5GAkgASgJUgRib2R5EhQKBXRpdGxlGAogASgJUgV0aXRsZRIOCgJpZBgLIAEoCVICaWQSPgoIYW5hbHlzaXMYDCABKAsyIi5sYW5nYW1lLnByb3RvYnVmLk1lc3NhZ2UuQW5hbHlzaXNSCGFuYWx5c2lzGu4CCghBbmFseXNpcxIWCgZ0b3BpY3MYASADKAlSBnRvcGljcxJMCgpzZW50aW1lbnRzGAIgAygLMiwubGFuZ2FtZS5wcm90b2J1Zi5NZXNzYWdlLkFuYWx5c2lzLlNlbnRpbWVudFIKc2VudGltZW50cxI+CgVlcnJvchgDIAEoCzIoLmxhbmdhbWUucHJvdG9idWYuTWVzc2FnZS5BbmFseXNpcy5FcnJvclIFZXJyb3ISNwoGZmlsdGVyGAQgASgOMh8ubGFuZ2FtZS5wcm90b2J1Zi5Db250ZW50RmlsdGVyUgZmaWx0ZXIaSgoFRXJyb3ISKwoRZGV2ZWxvcGVyX21lc3NhZ2UYASABKAlSEGRldmVsb3Blck1lc3NhZ2USFAoFdHJpZXMYAiABKAVSBXRyaWVzGjcKCVNlbnRpbWVudBIUCgVzY29yZRgBIAEoAlIFc2NvcmUSFAoFbGFiZWwYAiABKAlSBWxhYmVsIh8KBFR5cGUSCgoGSU5WSVRFEAASCwoHTUVTU0FHRRAB');
