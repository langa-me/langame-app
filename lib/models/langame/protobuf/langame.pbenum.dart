///
//  Generated code. Do not modify.
//  source: langame/protobuf/langame.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class InteractionLevel extends $pb.ProtobufEnum {
  static const InteractionLevel BAD = InteractionLevel._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BAD');
  static const InteractionLevel AVERAGE = InteractionLevel._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AVERAGE');
  static const InteractionLevel GREAT = InteractionLevel._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GREAT');
  static const InteractionLevel LOVE = InteractionLevel._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LOVE');

  static const $core.List<InteractionLevel> values = <InteractionLevel> [
    BAD,
    AVERAGE,
    GREAT,
    LOVE,
  ];

  static final $core.Map<$core.int, InteractionLevel> _byValue = $pb.ProtobufEnum.initByValue(values);
  static InteractionLevel? valueOf($core.int value) => _byValue[value];

  const InteractionLevel._($core.int v, $core.String n) : super(v, n);
}

class UserPreference_RecommendationType extends $pb.ProtobufEnum {
  static const UserPreference_RecommendationType NONE = UserPreference_RecommendationType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NONE');
  static const UserPreference_RecommendationType NEW = UserPreference_RecommendationType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NEW');
  static const UserPreference_RecommendationType COMPOUND = UserPreference_RecommendationType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COMPOUND');
  static const UserPreference_RecommendationType ALL = UserPreference_RecommendationType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ALL');

  static const $core.List<UserPreference_RecommendationType> values = <UserPreference_RecommendationType> [
    NONE,
    NEW,
    COMPOUND,
    ALL,
  ];

  static final $core.Map<$core.int, UserPreference_RecommendationType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static UserPreference_RecommendationType? valueOf($core.int value) => _byValue[value];

  const UserPreference_RecommendationType._($core.int v, $core.String n) : super(v, n);
}

class FunctionResponse_VersionCheck_UpdateRequired extends $pb.ProtobufEnum {
  static const FunctionResponse_VersionCheck_UpdateRequired OK = FunctionResponse_VersionCheck_UpdateRequired._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OK');
  static const FunctionResponse_VersionCheck_UpdateRequired REQUIRED = FunctionResponse_VersionCheck_UpdateRequired._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'REQUIRED');
  static const FunctionResponse_VersionCheck_UpdateRequired RETRO_COMPATIBLE = FunctionResponse_VersionCheck_UpdateRequired._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RETRO_COMPATIBLE');

  static const $core.List<FunctionResponse_VersionCheck_UpdateRequired> values = <FunctionResponse_VersionCheck_UpdateRequired> [
    OK,
    REQUIRED,
    RETRO_COMPATIBLE,
  ];

  static final $core.Map<$core.int, FunctionResponse_VersionCheck_UpdateRequired> _byValue = $pb.ProtobufEnum.initByValue(values);
  static FunctionResponse_VersionCheck_UpdateRequired? valueOf($core.int value) => _byValue[value];

  const FunctionResponse_VersionCheck_UpdateRequired._($core.int v, $core.String n) : super(v, n);
}

class Message_Type extends $pb.ProtobufEnum {
  static const Message_Type INVITE = Message_Type._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INVITE');
  static const Message_Type MESSAGE = Message_Type._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MESSAGE');

  static const $core.List<Message_Type> values = <Message_Type> [
    INVITE,
    MESSAGE,
  ];

  static final $core.Map<$core.int, Message_Type> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Message_Type? valueOf($core.int value) => _byValue[value];

  const Message_Type._($core.int v, $core.String n) : super(v, n);
}

