///
//  Generated code. Do not modify.
//  source: langame/protobuf/langame.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
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
    const {'1': 'tweet', '3': 9, '4': 1, '5': 8, '10': 'tweet'},
    const {'1': 'state', '3': 10, '4': 1, '5': 9, '10': 'state'},
    const {'1': 'error', '3': 11, '4': 1, '5': 9, '10': 'error'},
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
final $typed_data.Uint8List memeDescriptor = $convert.base64Decode('CgRNZW1lEjkKCmNyZWF0ZWRfYXQYASABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSGAoHY29udGVudBgCIAEoCVIHY29udGVudBIWCgZ0b3BpY3MYBCADKAlSBnRvcGljcxIbCglwcm9tcHRfaWQYBSABKAlSCHByb21wdElkEkYKCnRyYW5zbGF0ZWQYBiADKAsyJi5sYW5nYW1lLnByb3RvYnVmLk1lbWUuVHJhbnNsYXRlZEVudHJ5Ugp0cmFuc2xhdGVkEg4KAmlkGAcgASgJUgJpZBIaCghkaXNhYmxlZBgIIAEoCFIIZGlzYWJsZWQSFAoFdHdlZXQYCSABKAhSBXR3ZWV0EhQKBXN0YXRlGAogASgJUgVzdGF0ZRIUCgVlcnJvchgLIAEoCVIFZXJyb3IaPQoPVHJhbnNsYXRlZEVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');
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
    const {'1': 'bot', '3': 22, '4': 1, '5': 8, '10': 'bot'},
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
final $typed_data.Uint8List userDescriptor = $convert.base64Decode('CgRVc2VyEhAKA3VpZBgBIAEoCVIDdWlkEhQKBWVtYWlsGAIgASgJUgVlbWFpbBIhCgxkaXNwbGF5X25hbWUYAyABKAlSC2Rpc3BsYXlOYW1lEiEKDHBob25lX251bWJlchgEIAEoCVILcGhvbmVOdW1iZXISGwoJcGhvdG9fdXJsGAUgASgJUghwaG90b1VybBIWCgZvbmxpbmUYBiABKAhSBm9ubGluZRIWCgZnb29nbGUYByABKAhSBmdvb2dsZRIUCgVhcHBsZRgJIAEoCFIFYXBwbGUSEAoDdGFnGAsgASgJUgN0YWcSFgoGdG9rZW5zGAwgAygJUgZ0b2tlbnMSLwoTbGF0ZXN0X2ludGVyYWN0aW9ucxgNIAMoCVISbGF0ZXN0SW50ZXJhY3Rpb25zEi8KBmVycm9ycxgOIAMoCzIXLmxhbmdhbWUucHJvdG9idWYuRXJyb3JSBmVycm9ycxI5CgpsYXN0X2xvZ2luGA8gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJbGFzdExvZ2luEjsKC2xhc3RfbG9nb3V0GBAgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKbGFzdExvZ291dBI/Cg1jcmVhdGlvbl90aW1lGBEgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMY3JlYXRpb25UaW1lEhoKCGRpc2FibGVkGBIgASgIUghkaXNhYmxlZBI3CgdkZXZpY2VzGBMgAygLMh0ubGFuZ2FtZS5wcm90b2J1Zi5Vc2VyLkRldmljZVIHZGV2aWNlcxIYCgdjcmVkaXRzGBQgASgFUgdjcmVkaXRzEhIKBHJvbGUYFSABKAlSBHJvbGUSEAoDYm90GBYgASgIUgNib3QaUgoGRGV2aWNlEicKD2xhbmdhbWVfdmVyc2lvbhgBIAEoCVIObGFuZ2FtZVZlcnNpb24SHwoLZGV2aWNlX2luZm8YAiABKAlSCmRldmljZUluZm8=');
@$core.Deprecated('Use userPreferenceDescriptor instead')
const UserPreference$json = const {
  '1': 'UserPreference',
  '2': const [
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'user_recommendations', '3': 3, '4': 1, '5': 8, '10': 'userRecommendations'},
    const {'1': 'theme_index', '3': 4, '4': 1, '5': 5, '10': 'themeIndex'},
    const {'1': 'has_done_on_boarding', '3': 5, '4': 1, '5': 8, '10': 'hasDoneOnBoarding'},
    const {'1': 'user_search_history', '3': 6, '4': 3, '5': 9, '10': 'userSearchHistory'},
    const {'1': 'favorite_topics', '3': 8, '4': 3, '5': 9, '10': 'favoriteTopics'},
    const {'1': 'topic_search_history', '3': 9, '4': 3, '5': 9, '10': 'topicSearchHistory'},
    const {'1': 'errors', '3': 10, '4': 3, '5': 11, '6': '.langame.protobuf.Error', '10': 'errors'},
    const {'1': 'saw_whats_new', '3': 13, '4': 1, '5': 8, '10': 'sawWhatsNew'},
    const {'1': 'notification', '3': 14, '4': 1, '5': 11, '6': '.langame.protobuf.UserPreference.Notification', '10': 'notification'},
    const {'1': 'preview_mode', '3': 15, '4': 1, '5': 8, '10': 'previewMode'},
    const {'1': 'goals', '3': 16, '4': 1, '5': 11, '6': '.langame.protobuf.UserPreference.Goals', '10': 'goals'},
    const {'1': 'langames_subscription_frequency', '3': 17, '4': 1, '5': 9, '10': 'langamesSubscriptionFrequency'},
  ],
  '3': const [UserPreference_Notification$json, UserPreference_Goals$json],
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
const UserPreference_Goals$json = const {
  '1': 'Goals',
  '2': const [
    const {'1': 'grow_relationships', '3': 1, '4': 1, '5': 8, '10': 'growRelationships'},
    const {'1': 'compound_relationships', '3': 2, '4': 1, '5': 8, '10': 'compoundRelationships'},
    const {'1': 'learn', '3': 3, '4': 1, '5': 8, '10': 'learn'},
  ],
};

/// Descriptor for `UserPreference`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userPreferenceDescriptor = $convert.base64Decode('Cg5Vc2VyUHJlZmVyZW5jZRIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSMQoUdXNlcl9yZWNvbW1lbmRhdGlvbnMYAyABKAhSE3VzZXJSZWNvbW1lbmRhdGlvbnMSHwoLdGhlbWVfaW5kZXgYBCABKAVSCnRoZW1lSW5kZXgSLwoUaGFzX2RvbmVfb25fYm9hcmRpbmcYBSABKAhSEWhhc0RvbmVPbkJvYXJkaW5nEi4KE3VzZXJfc2VhcmNoX2hpc3RvcnkYBiADKAlSEXVzZXJTZWFyY2hIaXN0b3J5EicKD2Zhdm9yaXRlX3RvcGljcxgIIAMoCVIOZmF2b3JpdGVUb3BpY3MSMAoUdG9waWNfc2VhcmNoX2hpc3RvcnkYCSADKAlSEnRvcGljU2VhcmNoSGlzdG9yeRIvCgZlcnJvcnMYCiADKAsyFy5sYW5nYW1lLnByb3RvYnVmLkVycm9yUgZlcnJvcnMSIgoNc2F3X3doYXRzX25ldxgNIAEoCFILc2F3V2hhdHNOZXcSUQoMbm90aWZpY2F0aW9uGA4gASgLMi0ubGFuZ2FtZS5wcm90b2J1Zi5Vc2VyUHJlZmVyZW5jZS5Ob3RpZmljYXRpb25SDG5vdGlmaWNhdGlvbhIhCgxwcmV2aWV3X21vZGUYDyABKAhSC3ByZXZpZXdNb2RlEjwKBWdvYWxzGBAgASgLMiYubGFuZ2FtZS5wcm90b2J1Zi5Vc2VyUHJlZmVyZW5jZS5Hb2Fsc1IFZ29hbHMSRgofbGFuZ2FtZXNfc3Vic2NyaXB0aW9uX2ZyZXF1ZW5jeRgRIAEoCVIdbGFuZ2FtZXNTdWJzY3JpcHRpb25GcmVxdWVuY3kalgIKDE5vdGlmaWNhdGlvbhJMCgZpbnZpdGUYASABKAsyNC5sYW5nYW1lLnByb3RvYnVmLlVzZXJQcmVmZXJlbmNlLk5vdGlmaWNhdGlvbi5JbnZpdGVSBmludml0ZRJPCgdtZXNzYWdlGAIgASgLMjUubGFuZ2FtZS5wcm90b2J1Zi5Vc2VyUHJlZmVyZW5jZS5Ob3RpZmljYXRpb24uTWVzc2FnZVIHbWVzc2FnZRoyCgZJbnZpdGUSFAoFZW1haWwYASABKAhSBWVtYWlsEhIKBHB1c2gYAiABKAhSBHB1c2gaMwoHTWVzc2FnZRIUCgVlbWFpbBgBIAEoCFIFZW1haWwSEgoEcHVzaBgCIAEoCFIEcHVzaBqDAQoFR29hbHMSLQoSZ3Jvd19yZWxhdGlvbnNoaXBzGAEgASgIUhFncm93UmVsYXRpb25zaGlwcxI1ChZjb21wb3VuZF9yZWxhdGlvbnNoaXBzGAIgASgIUhVjb21wb3VuZFJlbGF0aW9uc2hpcHMSFAoFbGVhcm4YAyABKAhSBWxlYXJu');
@$core.Deprecated('Use langameDescriptor instead')
const Langame$json = const {
  '1': 'Langame',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'players', '3': 2, '4': 3, '5': 11, '6': '.langame.protobuf.Langame.Player', '10': 'players'},
    const {'1': 'topics', '3': 3, '4': 3, '5': 9, '10': 'topics'},
    const {'1': 'initiator', '3': 5, '4': 1, '5': 9, '10': 'initiator'},
    const {'1': 'done', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'done'},
    const {'1': 'created_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'errors', '3': 10, '4': 3, '5': 11, '6': '.langame.protobuf.Error', '10': 'errors'},
    const {'1': 'reflections', '3': 21, '4': 3, '5': 11, '6': '.langame.protobuf.Langame.Reflection', '10': 'reflections'},
    const {'1': 'tags', '3': 23, '4': 3, '5': 9, '10': 'tags'},
  ],
  '3': const [Langame_Player$json, Langame_Reflection$json],
};

@$core.Deprecated('Use langameDescriptor instead')
const Langame_Player$json = const {
  '1': 'Player',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'tag', '3': 2, '4': 1, '5': 9, '10': 'tag'},
    const {'1': 'photo_url', '3': 4, '4': 1, '5': 9, '10': 'photoUrl'},
    const {'1': 'bot', '3': 5, '4': 1, '5': 8, '10': 'bot'},
    const {'1': 'locale', '3': 10, '4': 1, '5': 9, '10': 'locale'},
    const {'1': 'email', '3': 12, '4': 1, '5': 9, '10': 'email'},
  ],
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
    const {'1': 'userFeedbacks', '3': 6, '4': 3, '5': 11, '6': '.langame.protobuf.Langame.Reflection.UserFeedbacksEntry', '10': 'userFeedbacks'},
  ],
  '3': const [Langame_Reflection_UserFeedbacksEntry$json],
};

@$core.Deprecated('Use langameDescriptor instead')
const Langame_Reflection_UserFeedbacksEntry$json = const {
  '1': 'UserFeedbacksEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 13, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `Langame`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List langameDescriptor = $convert.base64Decode('CgdMYW5nYW1lEg4KAmlkGAEgASgJUgJpZBI6CgdwbGF5ZXJzGAIgAygLMiAubGFuZ2FtZS5wcm90b2J1Zi5MYW5nYW1lLlBsYXllclIHcGxheWVycxIWCgZ0b3BpY3MYAyADKAlSBnRvcGljcxIcCglpbml0aWF0b3IYBSABKAlSCWluaXRpYXRvchIuCgRkb25lGAcgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIEZG9uZRI5CgpjcmVhdGVkX2F0GAkgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0Ei8KBmVycm9ycxgKIAMoCzIXLmxhbmdhbWUucHJvdG9idWYuRXJyb3JSBmVycm9ycxJGCgtyZWZsZWN0aW9ucxgVIAMoCzIkLmxhbmdhbWUucHJvdG9idWYuTGFuZ2FtZS5SZWZsZWN0aW9uUgtyZWZsZWN0aW9ucxISCgR0YWdzGBcgAygJUgR0YWdzGocBCgZQbGF5ZXISDgoCaWQYASABKAlSAmlkEhAKA3RhZxgCIAEoCVIDdGFnEhsKCXBob3RvX3VybBgEIAEoCVIIcGhvdG9VcmwSEAoDYm90GAUgASgIUgNib3QSFgoGbG9jYWxlGAogASgJUgZsb2NhbGUSFAoFZW1haWwYDCABKAlSBWVtYWlsGpUDCgpSZWZsZWN0aW9uEhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBImCg9sYXN0X21lc3NhZ2VfaWQYAiABKAlSDWxhc3RNZXNzYWdlSWQSIgoMYWx0ZXJuYXRpdmVzGAMgAygJUgxhbHRlcm5hdGl2ZXMSOQoKY3JlYXRlZF9hdBgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBJGCg5jb250ZW50X2ZpbHRlchgFIAEoDjIfLmxhbmdhbWUucHJvdG9idWYuQ29udGVudEZpbHRlclINY29udGVudEZpbHRlchJdCg11c2VyRmVlZGJhY2tzGAYgAygLMjcubGFuZ2FtZS5wcm90b2J1Zi5MYW5nYW1lLlJlZmxlY3Rpb24uVXNlckZlZWRiYWNrc0VudHJ5Ug11c2VyRmVlZGJhY2tzGkAKElVzZXJGZWVkYmFja3NFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoDVIFdmFsdWU6AjgB');
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
@$core.Deprecated('Use messageDescriptor instead')
const Message$json = const {
  '1': 'Message',
  '2': const [
    const {'1': 'created_at', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'author', '3': 4, '4': 1, '5': 11, '6': '.langame.protobuf.Message.Author', '10': 'author'},
    const {'1': 'langame_id', '3': 7, '4': 1, '5': 9, '10': 'langameId'},
    const {'1': 'type', '3': 8, '4': 1, '5': 14, '6': '.langame.protobuf.Message.Type', '10': 'type'},
    const {'1': 'body', '3': 9, '4': 1, '5': 9, '10': 'body'},
    const {'1': 'title', '3': 10, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'id', '3': 11, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'analysis', '3': 12, '4': 1, '5': 11, '6': '.langame.protobuf.Message.Analysis', '10': 'analysis'},
    const {'1': 'delivery', '3': 13, '4': 1, '5': 11, '6': '.langame.protobuf.Message.Delivery', '10': 'delivery'},
    const {'1': 'components', '3': 14, '4': 3, '5': 11, '6': '.langame.protobuf.Message.Component', '10': 'components'},
  ],
  '3': const [Message_Author$json, Message_Component$json, Message_Delivery$json, Message_Analysis$json],
  '4': const [Message_Type$json],
};

@$core.Deprecated('Use messageDescriptor instead')
const Message_Author$json = const {
  '1': 'Author',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'tag', '3': 2, '4': 1, '5': 9, '10': 'tag'},
    const {'1': 'photo_url', '3': 4, '4': 1, '5': 9, '10': 'photoUrl'},
    const {'1': 'bot', '3': 5, '4': 1, '5': 8, '10': 'bot'},
    const {'1': 'locale', '3': 10, '4': 1, '5': 9, '10': 'locale'},
    const {'1': 'email', '3': 12, '4': 1, '5': 9, '10': 'email'},
  ],
};

@$core.Deprecated('Use messageDescriptor instead')
const Message_Component$json = const {
  '1': 'Component',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 13, '10': 'type'},
    const {'1': 'custom_id', '3': 2, '4': 1, '5': 9, '10': 'customId'},
    const {'1': 'disabled', '3': 3, '4': 1, '5': 8, '10': 'disabled'},
    const {'1': 'style', '3': 4, '4': 1, '5': 13, '10': 'style'},
    const {'1': 'label', '3': 5, '4': 1, '5': 9, '10': 'label'},
    const {'1': 'emoji', '3': 6, '4': 1, '5': 9, '10': 'emoji'},
    const {'1': 'url', '3': 7, '4': 1, '5': 9, '10': 'url'},
    const {'1': 'options', '3': 8, '4': 3, '5': 11, '6': '.langame.protobuf.Message.Component.Option', '10': 'options'},
    const {'1': 'placeholder', '3': 9, '4': 1, '5': 9, '10': 'placeholder'},
    const {'1': 'min_values', '3': 10, '4': 1, '5': 5, '10': 'minValues'},
    const {'1': 'max_values', '3': 11, '4': 1, '5': 5, '10': 'maxValues'},
    const {'1': 'components', '3': 12, '4': 3, '5': 11, '6': '.langame.protobuf.Message.Component', '10': 'components'},
  ],
  '3': const [Message_Component_Option$json],
};

@$core.Deprecated('Use messageDescriptor instead')
const Message_Component_Option$json = const {
  '1': 'Option',
  '2': const [
    const {'1': 'label', '3': 1, '4': 1, '5': 9, '10': 'label'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'emoji', '3': 4, '4': 1, '5': 9, '10': 'emoji'},
    const {'1': 'default', '3': 5, '4': 1, '5': 8, '10': 'default'},
  ],
};

@$core.Deprecated('Use messageDescriptor instead')
const Message_Delivery$json = const {
  '1': 'Delivery',
  '2': const [
    const {'1': 'attempts', '3': 1, '4': 1, '5': 13, '10': 'attempts'},
    const {'1': 'end_time', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endTime'},
    const {'1': 'error', '3': 3, '4': 1, '5': 9, '10': 'error'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
  ],
};

@$core.Deprecated('Use messageDescriptor instead')
const Message_Analysis$json = const {
  '1': 'Analysis',
  '2': const [
    const {'1': 'topics', '3': 1, '4': 3, '5': 9, '10': 'topics'},
    const {'1': 'sentiments', '3': 2, '4': 3, '5': 11, '6': '.langame.protobuf.Message.Analysis.Sentiment', '10': 'sentiments'},
    const {'1': 'error', '3': 3, '4': 1, '5': 11, '6': '.langame.protobuf.Message.Analysis.Error', '10': 'error'},
    const {'1': 'filter', '3': 4, '4': 1, '5': 14, '6': '.langame.protobuf.ContentFilter', '10': 'filter'},
    const {'1': 'token', '3': 5, '4': 3, '5': 11, '6': '.langame.protobuf.Message.Analysis.Token', '10': 'token'},
  ],
  '3': const [Message_Analysis_Error$json, Message_Analysis_Sentiment$json, Message_Analysis_Token$json],
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
const Message_Analysis_Token$json = const {
  '1': 'Token',
  '2': const [
    const {'1': 'start', '3': 1, '4': 1, '5': 13, '10': 'start'},
    const {'1': 'end', '3': 2, '4': 1, '5': 13, '10': 'end'},
    const {'1': 'word', '3': 3, '4': 1, '5': 9, '10': 'word'},
    const {'1': 'entity_group', '3': 4, '4': 1, '5': 9, '10': 'entityGroup'},
    const {'1': 'score', '3': 5, '4': 1, '5': 2, '10': 'score'},
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
final $typed_data.Uint8List messageDescriptor = $convert.base64Decode('CgdNZXNzYWdlEjkKCmNyZWF0ZWRfYXQYAyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOAoGYXV0aG9yGAQgASgLMiAubGFuZ2FtZS5wcm90b2J1Zi5NZXNzYWdlLkF1dGhvclIGYXV0aG9yEh0KCmxhbmdhbWVfaWQYByABKAlSCWxhbmdhbWVJZBIyCgR0eXBlGAggASgOMh4ubGFuZ2FtZS5wcm90b2J1Zi5NZXNzYWdlLlR5cGVSBHR5cGUSEgoEYm9keRgJIAEoCVIEYm9keRIUCgV0aXRsZRgKIAEoCVIFdGl0bGUSDgoCaWQYCyABKAlSAmlkEj4KCGFuYWx5c2lzGAwgASgLMiIubGFuZ2FtZS5wcm90b2J1Zi5NZXNzYWdlLkFuYWx5c2lzUghhbmFseXNpcxI+CghkZWxpdmVyeRgNIAEoCzIiLmxhbmdhbWUucHJvdG9idWYuTWVzc2FnZS5EZWxpdmVyeVIIZGVsaXZlcnkSQwoKY29tcG9uZW50cxgOIAMoCzIjLmxhbmdhbWUucHJvdG9idWYuTWVzc2FnZS5Db21wb25lbnRSCmNvbXBvbmVudHMahwEKBkF1dGhvchIOCgJpZBgBIAEoCVICaWQSEAoDdGFnGAIgASgJUgN0YWcSGwoJcGhvdG9fdXJsGAQgASgJUghwaG90b1VybBIQCgNib3QYBSABKAhSA2JvdBIWCgZsb2NhbGUYCiABKAlSBmxvY2FsZRIUCgVlbWFpbBgMIAEoCVIFZW1haWwaoAQKCUNvbXBvbmVudBISCgR0eXBlGAEgASgNUgR0eXBlEhsKCWN1c3RvbV9pZBgCIAEoCVIIY3VzdG9tSWQSGgoIZGlzYWJsZWQYAyABKAhSCGRpc2FibGVkEhQKBXN0eWxlGAQgASgNUgVzdHlsZRIUCgVsYWJlbBgFIAEoCVIFbGFiZWwSFAoFZW1vamkYBiABKAlSBWVtb2ppEhAKA3VybBgHIAEoCVIDdXJsEkQKB29wdGlvbnMYCCADKAsyKi5sYW5nYW1lLnByb3RvYnVmLk1lc3NhZ2UuQ29tcG9uZW50Lk9wdGlvblIHb3B0aW9ucxIgCgtwbGFjZWhvbGRlchgJIAEoCVILcGxhY2Vob2xkZXISHQoKbWluX3ZhbHVlcxgKIAEoBVIJbWluVmFsdWVzEh0KCm1heF92YWx1ZXMYCyABKAVSCW1heFZhbHVlcxJDCgpjb21wb25lbnRzGAwgAygLMiMubGFuZ2FtZS5wcm90b2J1Zi5NZXNzYWdlLkNvbXBvbmVudFIKY29tcG9uZW50cxqGAQoGT3B0aW9uEhQKBWxhYmVsGAEgASgJUgVsYWJlbBIUCgV2YWx1ZRgCIAEoCVIFdmFsdWUSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEhQKBWVtb2ppGAQgASgJUgVlbW9qaRIYCgdkZWZhdWx0GAUgASgIUgdkZWZhdWx0GosBCghEZWxpdmVyeRIaCghhdHRlbXB0cxgBIAEoDVIIYXR0ZW1wdHMSNQoIZW5kX3RpbWUYAiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgdlbmRUaW1lEhQKBWVycm9yGAMgASgJUgVlcnJvchIWCgZzdGF0dXMYBCABKAlSBnN0YXR1cxqsBAoIQW5hbHlzaXMSFgoGdG9waWNzGAEgAygJUgZ0b3BpY3MSTAoKc2VudGltZW50cxgCIAMoCzIsLmxhbmdhbWUucHJvdG9idWYuTWVzc2FnZS5BbmFseXNpcy5TZW50aW1lbnRSCnNlbnRpbWVudHMSPgoFZXJyb3IYAyABKAsyKC5sYW5nYW1lLnByb3RvYnVmLk1lc3NhZ2UuQW5hbHlzaXMuRXJyb3JSBWVycm9yEjcKBmZpbHRlchgEIAEoDjIfLmxhbmdhbWUucHJvdG9idWYuQ29udGVudEZpbHRlclIGZmlsdGVyEj4KBXRva2VuGAUgAygLMigubGFuZ2FtZS5wcm90b2J1Zi5NZXNzYWdlLkFuYWx5c2lzLlRva2VuUgV0b2tlbhpKCgVFcnJvchIrChFkZXZlbG9wZXJfbWVzc2FnZRgBIAEoCVIQZGV2ZWxvcGVyTWVzc2FnZRIUCgV0cmllcxgCIAEoBVIFdHJpZXMaNwoJU2VudGltZW50EhQKBXNjb3JlGAEgASgCUgVzY29yZRIUCgVsYWJlbBgCIAEoCVIFbGFiZWwafAoFVG9rZW4SFAoFc3RhcnQYASABKA1SBXN0YXJ0EhAKA2VuZBgCIAEoDVIDZW5kEhIKBHdvcmQYAyABKAlSBHdvcmQSIQoMZW50aXR5X2dyb3VwGAQgASgJUgtlbnRpdHlHcm91cBIUCgVzY29yZRgFIAEoAlIFc2NvcmUiHwoEVHlwZRIKCgZJTlZJVEUQABILCgdNRVNTQUdFEAE=');
