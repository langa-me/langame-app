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

class FirestoreCollection extends $pb.ProtobufEnum {
  static const FirestoreCollection USERS = FirestoreCollection._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'USERS');
  static const FirestoreCollection MEMES = FirestoreCollection._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MEMES');
  static const FirestoreCollection PROMPTS = FirestoreCollection._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PROMPTS');
  static const FirestoreCollection LANGAMES = FirestoreCollection._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LANGAMES');

  static const $core.List<FirestoreCollection> values = <FirestoreCollection> [
    USERS,
    MEMES,
    PROMPTS,
    LANGAMES,
  ];

  static final $core.Map<$core.int, FirestoreCollection> _byValue = $pb.ProtobufEnum.initByValue(values);
  static FirestoreCollection? valueOf($core.int value) => _byValue[value];

  const FirestoreCollection._($core.int v, $core.String n) : super(v, n);
}

class Tag_Context_Type extends $pb.ProtobufEnum {
  static const Tag_Context_Type WIKIPEDIA = Tag_Context_Type._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'WIKIPEDIA');
  static const Tag_Context_Type OPENAI = Tag_Context_Type._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OPENAI');

  static const $core.List<Tag_Context_Type> values = <Tag_Context_Type> [
    WIKIPEDIA,
    OPENAI,
  ];

  static final $core.Map<$core.int, Tag_Context_Type> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Tag_Context_Type? valueOf($core.int value) => _byValue[value];

  const Tag_Context_Type._($core.int v, $core.String n) : super(v, n);
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

