///
//  Generated code. Do not modify.
//  source: langame/protobuf/langame.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Relation_RelationLevel extends $pb.ProtobufEnum {
  static const Relation_RelationLevel BAD = Relation_RelationLevel._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BAD');
  static const Relation_RelationLevel AVERAGE = Relation_RelationLevel._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AVERAGE');
  static const Relation_RelationLevel GREAT = Relation_RelationLevel._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GREAT');

  static const $core.List<Relation_RelationLevel> values = <Relation_RelationLevel> [
    BAD,
    AVERAGE,
    GREAT,
  ];

  static final $core.Map<$core.int, Relation_RelationLevel> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Relation_RelationLevel? valueOf($core.int value) => _byValue[value];

  const Relation_RelationLevel._($core.int v, $core.String n) : super(v, n);
}

