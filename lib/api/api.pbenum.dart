///
//  Generated code. Do not modify.
//  source: api/api.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Relation_Level extends $pb.ProtobufEnum {
  static const Relation_Level BAD = Relation_Level._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BAD');
  static const Relation_Level AVERAGE = Relation_Level._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AVERAGE');
  static const Relation_Level GREAT = Relation_Level._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GREAT');

  static const $core.List<Relation_Level> values = <Relation_Level> [
    BAD,
    AVERAGE,
    GREAT,
  ];

  static final $core.Map<$core.int, Relation_Level> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Relation_Level? valueOf($core.int value) => _byValue[value];

  const Relation_Level._($core.int v, $core.String n) : super(v, n);
}

