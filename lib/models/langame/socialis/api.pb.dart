///
//  Generated code. Do not modify.
//  source: api.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'api.pbenum.dart';

export 'api.pbenum.dart';

enum AddPlayersRequest_Players {
  text, 
  speech, 
  notSet
}

class AddPlayersRequest extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, AddPlayersRequest_Players> _AddPlayersRequest_PlayersByTag = {
    1 : AddPlayersRequest_Players.text,
    2 : AddPlayersRequest_Players.speech,
    0 : AddPlayersRequest_Players.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddPlayersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.socialis'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'text')
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'speech', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  AddPlayersRequest._() : super();
  factory AddPlayersRequest({
    $core.String? text,
    $core.List<$core.int>? speech,
  }) {
    final _result = create();
    if (text != null) {
      _result.text = text;
    }
    if (speech != null) {
      _result.speech = speech;
    }
    return _result;
  }
  factory AddPlayersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddPlayersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddPlayersRequest clone() => AddPlayersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddPlayersRequest copyWith(void Function(AddPlayersRequest) updates) => super.copyWith((message) => updates(message as AddPlayersRequest)) as AddPlayersRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddPlayersRequest create() => AddPlayersRequest._();
  AddPlayersRequest createEmptyInstance() => create();
  static $pb.PbList<AddPlayersRequest> createRepeated() => $pb.PbList<AddPlayersRequest>();
  @$core.pragma('dart2js:noInline')
  static AddPlayersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddPlayersRequest>(create);
  static AddPlayersRequest? _defaultInstance;

  AddPlayersRequest_Players whichPlayers() => _AddPlayersRequest_PlayersByTag[$_whichOneof(0)]!;
  void clearPlayers() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get speech => $_getN(1);
  @$pb.TagNumber(2)
  set speech($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSpeech() => $_has(1);
  @$pb.TagNumber(2)
  void clearSpeech() => clearField(2);
}

class ValidatePlayersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ValidatePlayersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.socialis'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'valid')
    ..hasRequiredFields = false
  ;

  ValidatePlayersRequest._() : super();
  factory ValidatePlayersRequest({
    $core.bool? valid,
  }) {
    final _result = create();
    if (valid != null) {
      _result.valid = valid;
    }
    return _result;
  }
  factory ValidatePlayersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidatePlayersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidatePlayersRequest clone() => ValidatePlayersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidatePlayersRequest copyWith(void Function(ValidatePlayersRequest) updates) => super.copyWith((message) => updates(message as ValidatePlayersRequest)) as ValidatePlayersRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ValidatePlayersRequest create() => ValidatePlayersRequest._();
  ValidatePlayersRequest createEmptyInstance() => create();
  static $pb.PbList<ValidatePlayersRequest> createRepeated() => $pb.PbList<ValidatePlayersRequest>();
  @$core.pragma('dart2js:noInline')
  static ValidatePlayersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidatePlayersRequest>(create);
  static ValidatePlayersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get valid => $_getBF(0);
  @$pb.TagNumber(1)
  set valid($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValid() => $_has(0);
  @$pb.TagNumber(1)
  void clearValid() => clearField(1);
}

class Game extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Game', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.socialis'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'text')
    ..e<GameState>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: GameState.PLAYER_ADD, valueOf: GameState.valueOf, enumValues: GameState.values)
    ..hasRequiredFields = false
  ;

  Game._() : super();
  factory Game({
    $core.String? text,
    GameState? state,
  }) {
    final _result = create();
    if (text != null) {
      _result.text = text;
    }
    if (state != null) {
      _result.state = state;
    }
    return _result;
  }
  factory Game.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Game.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Game clone() => Game()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Game copyWith(void Function(Game) updates) => super.copyWith((message) => updates(message as Game)) as Game; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Game create() => Game._();
  Game createEmptyInstance() => create();
  static $pb.PbList<Game> createRepeated() => $pb.PbList<Game>();
  @$core.pragma('dart2js:noInline')
  static Game getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Game>(create);
  static Game? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => clearField(1);

  @$pb.TagNumber(2)
  GameState get state => $_getN(1);
  @$pb.TagNumber(2)
  set state(GameState v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => clearField(2);
}

