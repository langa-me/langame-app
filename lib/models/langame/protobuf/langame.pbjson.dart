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
    const {'1': 'contexts', '3': 3, '4': 3, '5': 9, '10': 'contexts'},
  ],
};

/// Descriptor for `Question`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List questionDescriptor = $convert.base64Decode('CghRdWVzdGlvbhIOCgJpZBgBIAEoCVICaWQSGAoHY29udGVudBgCIAEoCVIHY29udGVudBIaCghjb250ZXh0cxgDIAMoCVIIY29udGV4dHM=');
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
    const {'1': 'latest_interactions', '3': 13, '4': 3, '5': 9, '10': 'latestInteractions'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode('CgRVc2VyEhAKA3VpZBgBIAEoCVIDdWlkEhQKBWVtYWlsGAIgASgJUgVlbWFpbBIhCgxkaXNwbGF5X25hbWUYAyABKAlSC2Rpc3BsYXlOYW1lEiEKDHBob25lX251bWJlchgEIAEoCVILcGhvbmVOdW1iZXISGwoJcGhvdG9fdXJsGAUgASgJUghwaG90b1VybBIWCgZvbmxpbmUYBiABKAhSBm9ubGluZRIWCgZnb29nbGUYByABKAhSBmdvb2dsZRIaCghmYWNlYm9vaxgIIAEoCFIIZmFjZWJvb2sSFAoFYXBwbGUYCSABKAhSBWFwcGxlEikKEGZhdm91cml0ZV90b3BpY3MYCiADKAlSD2Zhdm91cml0ZVRvcGljcxIQCgN0YWcYCyABKAlSA3RhZxIWCgZ0b2tlbnMYDCADKAlSBnRva2VucxIvChNsYXRlc3RfaW50ZXJhY3Rpb25zGA0gAygJUhJsYXRlc3RJbnRlcmFjdGlvbnM=');
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
@$core.Deprecated('Use channelUserLangameUserDescriptor instead')
const ChannelUserLangameUser$json = const {
  '1': 'ChannelUserLangameUser',
  '2': const [
    const {'1': 'channel_uid', '3': 1, '4': 1, '5': 13, '10': 'channelUid'},
    const {'1': 'langame_uid', '3': 2, '4': 1, '5': 9, '10': 'langameUid'},
  ],
};

/// Descriptor for `ChannelUserLangameUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelUserLangameUserDescriptor = $convert.base64Decode('ChZDaGFubmVsVXNlckxhbmdhbWVVc2VyEh8KC2NoYW5uZWxfdWlkGAEgASgNUgpjaGFubmVsVWlkEh8KC2xhbmdhbWVfdWlkGAIgASgJUgpsYW5nYW1lVWlk');
@$core.Deprecated('Use langameDescriptor instead')
const Langame$json = const {
  '1': 'Langame',
  '2': const [
    const {'1': 'channelName', '3': 1, '4': 1, '5': 9, '10': 'channelName'},
    const {'1': 'players', '3': 2, '4': 3, '5': 11, '6': '.langame.protobuf.ChannelUserLangameUser', '10': 'players'},
    const {'1': 'topics', '3': 3, '4': 3, '5': 9, '10': 'topics'},
    const {'1': 'questions', '3': 4, '4': 3, '5': 11, '6': '.langame.protobuf.Question', '10': 'questions'},
  ],
};

/// Descriptor for `Langame`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List langameDescriptor = $convert.base64Decode('CgdMYW5nYW1lEiAKC2NoYW5uZWxOYW1lGAEgASgJUgtjaGFubmVsTmFtZRJCCgdwbGF5ZXJzGAIgAygLMigubGFuZ2FtZS5wcm90b2J1Zi5DaGFubmVsVXNlckxhbmdhbWVVc2VyUgdwbGF5ZXJzEhYKBnRvcGljcxgDIAMoCVIGdG9waWNzEjgKCXF1ZXN0aW9ucxgEIAMoCzIaLmxhbmdhbWUucHJvdG9idWYuUXVlc3Rpb25SCXF1ZXN0aW9ucw==');
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
