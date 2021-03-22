///
//  Generated code. Do not modify.
//  source: api/api.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class RelationLevel extends $pb.ProtobufEnum {
  static const RelationLevel BAD = RelationLevel._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BAD');
  static const RelationLevel AVERAGE = RelationLevel._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AVERAGE');
  static const RelationLevel GREAT = RelationLevel._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GREAT');

  static const $core.List<RelationLevel> values = <RelationLevel> [
    BAD,
    AVERAGE,
    GREAT,
  ];

  static final $core.Map<$core.int, RelationLevel> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RelationLevel? valueOf($core.int value) => _byValue[value];

  const RelationLevel._($core.int v, $core.String n) : super(v, n);
}

class LangameUser_Status extends $pb.ProtobufEnum {
  static const LangameUser_Status OFFLINE = LangameUser_Status._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OFFLINE');
  static const LangameUser_Status ONLINE = LangameUser_Status._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ONLINE');

  static const $core.List<LangameUser_Status> values = <LangameUser_Status> [
    OFFLINE,
    ONLINE,
  ];

  static final $core.Map<$core.int, LangameUser_Status> _byValue = $pb.ProtobufEnum.initByValue(values);
  static LangameUser_Status? valueOf($core.int value) => _byValue[value];

  const LangameUser_Status._($core.int v, $core.String n) : super(v, n);
}

class LangameNotification_Type extends $pb.ProtobufEnum {
  static const LangameNotification_Type INVITATION = LangameNotification_Type._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INVITATION');

  static const $core.List<LangameNotification_Type> values = <LangameNotification_Type> [
    INVITATION,
  ];

  static final $core.Map<$core.int, LangameNotification_Type> _byValue = $pb.ProtobufEnum.initByValue(values);
  static LangameNotification_Type? valueOf($core.int value) => _byValue[value];

  const LangameNotification_Type._($core.int v, $core.String n) : super(v, n);
}

