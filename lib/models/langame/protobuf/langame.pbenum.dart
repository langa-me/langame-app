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

class Paint_Shape extends $pb.ProtobufEnum {
  static const Paint_Shape Rectangle = Paint_Shape._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Rectangle');
  static const Paint_Shape Circle = Paint_Shape._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Circle');
  static const Paint_Shape Line = Paint_Shape._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Line');
  static const Paint_Shape Text = Paint_Shape._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Text');

  static const $core.List<Paint_Shape> values = <Paint_Shape> [
    Rectangle,
    Circle,
    Line,
    Text,
  ];

  static final $core.Map<$core.int, Paint_Shape> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Paint_Shape? valueOf($core.int value) => _byValue[value];

  const Paint_Shape._($core.int v, $core.String n) : super(v, n);
}

