///
//  Generated code. Do not modify.
//  source: api.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class GameState extends $pb.ProtobufEnum {
  static const GameState PLAYER_ADD = GameState._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PLAYER_ADD');
  static const GameState PLAYER_VALIDATE = GameState._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PLAYER_VALIDATE');

  static const $core.List<GameState> values = <GameState> [
    PLAYER_ADD,
    PLAYER_VALIDATE,
  ];

  static final $core.Map<$core.int, GameState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GameState? valueOf($core.int value) => _byValue[value];

  const GameState._($core.int v, $core.String n) : super(v, n);
}

