///
//  Generated code. Do not modify.
//  source: langame/protobuf/langame.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../google/protobuf/timestamp.pb.dart' as $0;

import 'langame.pbenum.dart';

export 'langame.pbenum.dart';

class Meme extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Meme', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOM<$0.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $0.Timestamp.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'content')
    ..pc<Tag>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tags', $pb.PbFieldType.PM, subBuilder: Tag.create)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'promptId')
    ..hasRequiredFields = false
  ;

  Meme._() : super();
  factory Meme({
    $0.Timestamp? createdAt,
    $core.String? content,
    $core.Iterable<Tag>? tags,
    $core.String? promptId,
  }) {
    final _result = create();
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (content != null) {
      _result.content = content;
    }
    if (tags != null) {
      _result.tags.addAll(tags);
    }
    if (promptId != null) {
      _result.promptId = promptId;
    }
    return _result;
  }
  factory Meme.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Meme.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Meme clone() => Meme()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Meme copyWith(void Function(Meme) updates) => super.copyWith((message) => updates(message as Meme)) as Meme; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Meme create() => Meme._();
  Meme createEmptyInstance() => create();
  static $pb.PbList<Meme> createRepeated() => $pb.PbList<Meme>();
  @$core.pragma('dart2js:noInline')
  static Meme getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Meme>(create);
  static Meme? _defaultInstance;

  @$pb.TagNumber(1)
  $0.Timestamp get createdAt => $_getN(0);
  @$pb.TagNumber(1)
  set createdAt($0.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCreatedAt() => $_has(0);
  @$pb.TagNumber(1)
  void clearCreatedAt() => clearField(1);
  @$pb.TagNumber(1)
  $0.Timestamp ensureCreatedAt() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get content => $_getSZ(1);
  @$pb.TagNumber(2)
  set content($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasContent() => $_has(1);
  @$pb.TagNumber(2)
  void clearContent() => clearField(2);

  @$pb.TagNumber(4)
  $core.List<Tag> get tags => $_getList(2);

  @$pb.TagNumber(5)
  $core.String get promptId => $_getSZ(3);
  @$pb.TagNumber(5)
  set promptId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasPromptId() => $_has(3);
  @$pb.TagNumber(5)
  void clearPromptId() => clearField(5);
}

class Tag_Topic extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Tag.Topic', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'content')
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'emojis')
    ..hasRequiredFields = false
  ;

  Tag_Topic._() : super();
  factory Tag_Topic({
    $core.String? content,
    $core.Iterable<$core.String>? emojis,
  }) {
    final _result = create();
    if (content != null) {
      _result.content = content;
    }
    if (emojis != null) {
      _result.emojis.addAll(emojis);
    }
    return _result;
  }
  factory Tag_Topic.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Tag_Topic.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Tag_Topic clone() => Tag_Topic()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Tag_Topic copyWith(void Function(Tag_Topic) updates) => super.copyWith((message) => updates(message as Tag_Topic)) as Tag_Topic; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Tag_Topic create() => Tag_Topic._();
  Tag_Topic createEmptyInstance() => create();
  static $pb.PbList<Tag_Topic> createRepeated() => $pb.PbList<Tag_Topic>();
  @$core.pragma('dart2js:noInline')
  static Tag_Topic getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Tag_Topic>(create);
  static Tag_Topic? _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get content => $_getSZ(0);
  @$pb.TagNumber(2)
  set content($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(2)
  $core.bool hasContent() => $_has(0);
  @$pb.TagNumber(2)
  void clearContent() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get emojis => $_getList(1);
}

class Tag_Classification extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Tag.Classification', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'content')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'score', $pb.PbFieldType.OD)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'human')
    ..hasRequiredFields = false
  ;

  Tag_Classification._() : super();
  factory Tag_Classification({
    $core.String? content,
    $core.double? score,
    $core.bool? human,
  }) {
    final _result = create();
    if (content != null) {
      _result.content = content;
    }
    if (score != null) {
      _result.score = score;
    }
    if (human != null) {
      _result.human = human;
    }
    return _result;
  }
  factory Tag_Classification.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Tag_Classification.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Tag_Classification clone() => Tag_Classification()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Tag_Classification copyWith(void Function(Tag_Classification) updates) => super.copyWith((message) => updates(message as Tag_Classification)) as Tag_Classification; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Tag_Classification create() => Tag_Classification._();
  Tag_Classification createEmptyInstance() => create();
  static $pb.PbList<Tag_Classification> createRepeated() => $pb.PbList<Tag_Classification>();
  @$core.pragma('dart2js:noInline')
  static Tag_Classification getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Tag_Classification>(create);
  static Tag_Classification? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get content => $_getSZ(0);
  @$pb.TagNumber(1)
  set content($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContent() => $_has(0);
  @$pb.TagNumber(1)
  void clearContent() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get score => $_getN(1);
  @$pb.TagNumber(2)
  set score($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasScore() => $_has(1);
  @$pb.TagNumber(2)
  void clearScore() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get human => $_getBF(2);
  @$pb.TagNumber(3)
  set human($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasHuman() => $_has(2);
  @$pb.TagNumber(3)
  void clearHuman() => clearField(3);
}

class Tag_Engine_Parameters extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Tag.Engine.Parameters', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'temperature', $pb.PbFieldType.OD)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxTokens', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topP', $pb.PbFieldType.OU3)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'frequencyPenalty', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'presencePenalty', $pb.PbFieldType.OD)
    ..pPS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stop')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'model')
    ..hasRequiredFields = false
  ;

  Tag_Engine_Parameters._() : super();
  factory Tag_Engine_Parameters({
    $core.double? temperature,
    $core.int? maxTokens,
    $core.int? topP,
    $core.double? frequencyPenalty,
    $core.double? presencePenalty,
    $core.Iterable<$core.String>? stop,
    $core.String? model,
  }) {
    final _result = create();
    if (temperature != null) {
      _result.temperature = temperature;
    }
    if (maxTokens != null) {
      _result.maxTokens = maxTokens;
    }
    if (topP != null) {
      _result.topP = topP;
    }
    if (frequencyPenalty != null) {
      _result.frequencyPenalty = frequencyPenalty;
    }
    if (presencePenalty != null) {
      _result.presencePenalty = presencePenalty;
    }
    if (stop != null) {
      _result.stop.addAll(stop);
    }
    if (model != null) {
      _result.model = model;
    }
    return _result;
  }
  factory Tag_Engine_Parameters.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Tag_Engine_Parameters.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Tag_Engine_Parameters clone() => Tag_Engine_Parameters()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Tag_Engine_Parameters copyWith(void Function(Tag_Engine_Parameters) updates) => super.copyWith((message) => updates(message as Tag_Engine_Parameters)) as Tag_Engine_Parameters; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Tag_Engine_Parameters create() => Tag_Engine_Parameters._();
  Tag_Engine_Parameters createEmptyInstance() => create();
  static $pb.PbList<Tag_Engine_Parameters> createRepeated() => $pb.PbList<Tag_Engine_Parameters>();
  @$core.pragma('dart2js:noInline')
  static Tag_Engine_Parameters getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Tag_Engine_Parameters>(create);
  static Tag_Engine_Parameters? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get temperature => $_getN(0);
  @$pb.TagNumber(1)
  set temperature($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTemperature() => $_has(0);
  @$pb.TagNumber(1)
  void clearTemperature() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get maxTokens => $_getIZ(1);
  @$pb.TagNumber(2)
  set maxTokens($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMaxTokens() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxTokens() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get topP => $_getIZ(2);
  @$pb.TagNumber(3)
  set topP($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTopP() => $_has(2);
  @$pb.TagNumber(3)
  void clearTopP() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get frequencyPenalty => $_getN(3);
  @$pb.TagNumber(4)
  set frequencyPenalty($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFrequencyPenalty() => $_has(3);
  @$pb.TagNumber(4)
  void clearFrequencyPenalty() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get presencePenalty => $_getN(4);
  @$pb.TagNumber(5)
  set presencePenalty($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPresencePenalty() => $_has(4);
  @$pb.TagNumber(5)
  void clearPresencePenalty() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.String> get stop => $_getList(5);

  @$pb.TagNumber(7)
  $core.String get model => $_getSZ(6);
  @$pb.TagNumber(7)
  set model($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasModel() => $_has(6);
  @$pb.TagNumber(7)
  void clearModel() => clearField(7);
}

class Tag_Engine extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Tag.Engine', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOM<Tag_Engine_Parameters>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'parameters', subBuilder: Tag_Engine_Parameters.create)
    ..hasRequiredFields = false
  ;

  Tag_Engine._() : super();
  factory Tag_Engine({
    Tag_Engine_Parameters? parameters,
  }) {
    final _result = create();
    if (parameters != null) {
      _result.parameters = parameters;
    }
    return _result;
  }
  factory Tag_Engine.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Tag_Engine.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Tag_Engine clone() => Tag_Engine()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Tag_Engine copyWith(void Function(Tag_Engine) updates) => super.copyWith((message) => updates(message as Tag_Engine)) as Tag_Engine; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Tag_Engine create() => Tag_Engine._();
  Tag_Engine createEmptyInstance() => create();
  static $pb.PbList<Tag_Engine> createRepeated() => $pb.PbList<Tag_Engine>();
  @$core.pragma('dart2js:noInline')
  static Tag_Engine getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Tag_Engine>(create);
  static Tag_Engine? _defaultInstance;

  @$pb.TagNumber(1)
  Tag_Engine_Parameters get parameters => $_getN(0);
  @$pb.TagNumber(1)
  set parameters(Tag_Engine_Parameters v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasParameters() => $_has(0);
  @$pb.TagNumber(1)
  void clearParameters() => clearField(1);
  @$pb.TagNumber(1)
  Tag_Engine_Parameters ensureParameters() => $_ensure(0);
}

class Tag_Feedback_General extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Tag.Feedback.General', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'score', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  Tag_Feedback_General._() : super();
  factory Tag_Feedback_General({
    $core.int? score,
  }) {
    final _result = create();
    if (score != null) {
      _result.score = score;
    }
    return _result;
  }
  factory Tag_Feedback_General.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Tag_Feedback_General.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Tag_Feedback_General clone() => Tag_Feedback_General()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Tag_Feedback_General copyWith(void Function(Tag_Feedback_General) updates) => super.copyWith((message) => updates(message as Tag_Feedback_General)) as Tag_Feedback_General; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Tag_Feedback_General create() => Tag_Feedback_General._();
  Tag_Feedback_General createEmptyInstance() => create();
  static $pb.PbList<Tag_Feedback_General> createRepeated() => $pb.PbList<Tag_Feedback_General>();
  @$core.pragma('dart2js:noInline')
  static Tag_Feedback_General getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Tag_Feedback_General>(create);
  static Tag_Feedback_General? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get score => $_getIZ(0);
  @$pb.TagNumber(1)
  set score($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasScore() => $_has(0);
  @$pb.TagNumber(1)
  void clearScore() => clearField(1);
}

class Tag_Feedback_Relevance extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Tag.Feedback.Relevance', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'score', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  Tag_Feedback_Relevance._() : super();
  factory Tag_Feedback_Relevance({
    $core.int? score,
  }) {
    final _result = create();
    if (score != null) {
      _result.score = score;
    }
    return _result;
  }
  factory Tag_Feedback_Relevance.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Tag_Feedback_Relevance.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Tag_Feedback_Relevance clone() => Tag_Feedback_Relevance()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Tag_Feedback_Relevance copyWith(void Function(Tag_Feedback_Relevance) updates) => super.copyWith((message) => updates(message as Tag_Feedback_Relevance)) as Tag_Feedback_Relevance; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Tag_Feedback_Relevance create() => Tag_Feedback_Relevance._();
  Tag_Feedback_Relevance createEmptyInstance() => create();
  static $pb.PbList<Tag_Feedback_Relevance> createRepeated() => $pb.PbList<Tag_Feedback_Relevance>();
  @$core.pragma('dart2js:noInline')
  static Tag_Feedback_Relevance getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Tag_Feedback_Relevance>(create);
  static Tag_Feedback_Relevance? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get score => $_getIZ(0);
  @$pb.TagNumber(1)
  set score($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasScore() => $_has(0);
  @$pb.TagNumber(1)
  void clearScore() => clearField(1);
}

enum Tag_Feedback_Type {
  general, 
  relevance, 
  notSet
}

class Tag_Feedback extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Tag_Feedback_Type> _Tag_Feedback_TypeByTag = {
    2 : Tag_Feedback_Type.general,
    3 : Tag_Feedback_Type.relevance,
    0 : Tag_Feedback_Type.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Tag.Feedback', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..oo(0, [2, 3])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOM<Tag_Feedback_General>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'general', subBuilder: Tag_Feedback_General.create)
    ..aOM<Tag_Feedback_Relevance>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'relevance', subBuilder: Tag_Feedback_Relevance.create)
    ..hasRequiredFields = false
  ;

  Tag_Feedback._() : super();
  factory Tag_Feedback({
    $core.String? userId,
    Tag_Feedback_General? general,
    Tag_Feedback_Relevance? relevance,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (general != null) {
      _result.general = general;
    }
    if (relevance != null) {
      _result.relevance = relevance;
    }
    return _result;
  }
  factory Tag_Feedback.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Tag_Feedback.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Tag_Feedback clone() => Tag_Feedback()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Tag_Feedback copyWith(void Function(Tag_Feedback) updates) => super.copyWith((message) => updates(message as Tag_Feedback)) as Tag_Feedback; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Tag_Feedback create() => Tag_Feedback._();
  Tag_Feedback createEmptyInstance() => create();
  static $pb.PbList<Tag_Feedback> createRepeated() => $pb.PbList<Tag_Feedback>();
  @$core.pragma('dart2js:noInline')
  static Tag_Feedback getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Tag_Feedback>(create);
  static Tag_Feedback? _defaultInstance;

  Tag_Feedback_Type whichType() => _Tag_Feedback_TypeByTag[$_whichOneof(0)]!;
  void clearType() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  Tag_Feedback_General get general => $_getN(1);
  @$pb.TagNumber(2)
  set general(Tag_Feedback_General v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasGeneral() => $_has(1);
  @$pb.TagNumber(2)
  void clearGeneral() => clearField(2);
  @$pb.TagNumber(2)
  Tag_Feedback_General ensureGeneral() => $_ensure(1);

  @$pb.TagNumber(3)
  Tag_Feedback_Relevance get relevance => $_getN(2);
  @$pb.TagNumber(3)
  set relevance(Tag_Feedback_Relevance v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasRelevance() => $_has(2);
  @$pb.TagNumber(3)
  void clearRelevance() => clearField(3);
  @$pb.TagNumber(3)
  Tag_Feedback_Relevance ensureRelevance() => $_ensure(2);
}

class Tag_Context extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Tag.Context', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'content')
    ..e<Tag_Context_Type>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: Tag_Context_Type.WIKIPEDIA, valueOf: Tag_Context_Type.valueOf, enumValues: Tag_Context_Type.values)
    ..hasRequiredFields = false
  ;

  Tag_Context._() : super();
  factory Tag_Context({
    $core.String? content,
    Tag_Context_Type? type,
  }) {
    final _result = create();
    if (content != null) {
      _result.content = content;
    }
    if (type != null) {
      _result.type = type;
    }
    return _result;
  }
  factory Tag_Context.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Tag_Context.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Tag_Context clone() => Tag_Context()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Tag_Context copyWith(void Function(Tag_Context) updates) => super.copyWith((message) => updates(message as Tag_Context)) as Tag_Context; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Tag_Context create() => Tag_Context._();
  Tag_Context createEmptyInstance() => create();
  static $pb.PbList<Tag_Context> createRepeated() => $pb.PbList<Tag_Context>();
  @$core.pragma('dart2js:noInline')
  static Tag_Context getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Tag_Context>(create);
  static Tag_Context? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get content => $_getSZ(0);
  @$pb.TagNumber(1)
  set content($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContent() => $_has(0);
  @$pb.TagNumber(1)
  void clearContent() => clearField(1);

  @$pb.TagNumber(2)
  Tag_Context_Type get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(Tag_Context_Type v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);
}

enum Tag_Type {
  topic, 
  classification, 
  engine, 
  feedback, 
  context, 
  aggregatedFeedback, 
  notSet
}

class Tag extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Tag_Type> _Tag_TypeByTag = {
    2 : Tag_Type.topic,
    3 : Tag_Type.classification,
    4 : Tag_Type.engine,
    5 : Tag_Type.feedback,
    6 : Tag_Type.context,
    7 : Tag_Type.aggregatedFeedback,
    0 : Tag_Type.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Tag', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..oo(0, [2, 3, 4, 5, 6, 7])
    ..aOM<$0.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $0.Timestamp.create)
    ..aOM<Tag_Topic>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topic', subBuilder: Tag_Topic.create)
    ..aOM<Tag_Classification>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'classification', subBuilder: Tag_Classification.create)
    ..aOM<Tag_Engine>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'engine', subBuilder: Tag_Engine.create)
    ..aOM<Tag_Feedback>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'feedback', subBuilder: Tag_Feedback.create)
    ..aOM<Tag_Context>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'context', subBuilder: Tag_Context.create)
    ..aOM<Tag_Feedback>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'aggregatedFeedback', subBuilder: Tag_Feedback.create)
    ..hasRequiredFields = false
  ;

  Tag._() : super();
  factory Tag({
    $0.Timestamp? createdAt,
    Tag_Topic? topic,
    Tag_Classification? classification,
    Tag_Engine? engine,
    Tag_Feedback? feedback,
    Tag_Context? context,
    Tag_Feedback? aggregatedFeedback,
  }) {
    final _result = create();
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (topic != null) {
      _result.topic = topic;
    }
    if (classification != null) {
      _result.classification = classification;
    }
    if (engine != null) {
      _result.engine = engine;
    }
    if (feedback != null) {
      _result.feedback = feedback;
    }
    if (context != null) {
      _result.context = context;
    }
    if (aggregatedFeedback != null) {
      _result.aggregatedFeedback = aggregatedFeedback;
    }
    return _result;
  }
  factory Tag.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Tag.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Tag clone() => Tag()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Tag copyWith(void Function(Tag) updates) => super.copyWith((message) => updates(message as Tag)) as Tag; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Tag create() => Tag._();
  Tag createEmptyInstance() => create();
  static $pb.PbList<Tag> createRepeated() => $pb.PbList<Tag>();
  @$core.pragma('dart2js:noInline')
  static Tag getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Tag>(create);
  static Tag? _defaultInstance;

  Tag_Type whichType() => _Tag_TypeByTag[$_whichOneof(0)]!;
  void clearType() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $0.Timestamp get createdAt => $_getN(0);
  @$pb.TagNumber(1)
  set createdAt($0.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCreatedAt() => $_has(0);
  @$pb.TagNumber(1)
  void clearCreatedAt() => clearField(1);
  @$pb.TagNumber(1)
  $0.Timestamp ensureCreatedAt() => $_ensure(0);

  @$pb.TagNumber(2)
  Tag_Topic get topic => $_getN(1);
  @$pb.TagNumber(2)
  set topic(Tag_Topic v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTopic() => $_has(1);
  @$pb.TagNumber(2)
  void clearTopic() => clearField(2);
  @$pb.TagNumber(2)
  Tag_Topic ensureTopic() => $_ensure(1);

  @$pb.TagNumber(3)
  Tag_Classification get classification => $_getN(2);
  @$pb.TagNumber(3)
  set classification(Tag_Classification v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasClassification() => $_has(2);
  @$pb.TagNumber(3)
  void clearClassification() => clearField(3);
  @$pb.TagNumber(3)
  Tag_Classification ensureClassification() => $_ensure(2);

  @$pb.TagNumber(4)
  Tag_Engine get engine => $_getN(3);
  @$pb.TagNumber(4)
  set engine(Tag_Engine v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasEngine() => $_has(3);
  @$pb.TagNumber(4)
  void clearEngine() => clearField(4);
  @$pb.TagNumber(4)
  Tag_Engine ensureEngine() => $_ensure(3);

  @$pb.TagNumber(5)
  Tag_Feedback get feedback => $_getN(4);
  @$pb.TagNumber(5)
  set feedback(Tag_Feedback v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasFeedback() => $_has(4);
  @$pb.TagNumber(5)
  void clearFeedback() => clearField(5);
  @$pb.TagNumber(5)
  Tag_Feedback ensureFeedback() => $_ensure(4);

  @$pb.TagNumber(6)
  Tag_Context get context => $_getN(5);
  @$pb.TagNumber(6)
  set context(Tag_Context v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasContext() => $_has(5);
  @$pb.TagNumber(6)
  void clearContext() => clearField(6);
  @$pb.TagNumber(6)
  Tag_Context ensureContext() => $_ensure(5);

  @$pb.TagNumber(7)
  Tag_Feedback get aggregatedFeedback => $_getN(6);
  @$pb.TagNumber(7)
  set aggregatedFeedback(Tag_Feedback v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasAggregatedFeedback() => $_has(6);
  @$pb.TagNumber(7)
  void clearAggregatedFeedback() => clearField(7);
  @$pb.TagNumber(7)
  Tag_Feedback ensureAggregatedFeedback() => $_ensure(6);
}

class User_Device extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'User.Device', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'langameVersion')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceInfo')
    ..hasRequiredFields = false
  ;

  User_Device._() : super();
  factory User_Device({
    $core.String? langameVersion,
    $core.String? deviceInfo,
  }) {
    final _result = create();
    if (langameVersion != null) {
      _result.langameVersion = langameVersion;
    }
    if (deviceInfo != null) {
      _result.deviceInfo = deviceInfo;
    }
    return _result;
  }
  factory User_Device.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory User_Device.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  User_Device clone() => User_Device()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  User_Device copyWith(void Function(User_Device) updates) => super.copyWith((message) => updates(message as User_Device)) as User_Device; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static User_Device create() => User_Device._();
  User_Device createEmptyInstance() => create();
  static $pb.PbList<User_Device> createRepeated() => $pb.PbList<User_Device>();
  @$core.pragma('dart2js:noInline')
  static User_Device getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<User_Device>(create);
  static User_Device? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get langameVersion => $_getSZ(0);
  @$pb.TagNumber(1)
  set langameVersion($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLangameVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearLangameVersion() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get deviceInfo => $_getSZ(1);
  @$pb.TagNumber(2)
  set deviceInfo($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDeviceInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearDeviceInfo() => clearField(2);
}

class User extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'User', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uid')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'displayName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'photoUrl')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'online')
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'google')
    ..aOB(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'apple')
    ..pPS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'favouriteTopics')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tag')
    ..pPS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tokens')
    ..pPS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'latestInteractions')
    ..pPS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errors')
    ..aOM<$0.Timestamp>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastLogin', subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastLogout', subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creationTime', subBuilder: $0.Timestamp.create)
    ..aOB(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'disabled')
    ..pc<User_Device>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'devices', $pb.PbFieldType.PM, subBuilder: User_Device.create)
    ..hasRequiredFields = false
  ;

  User._() : super();
  factory User({
    $core.String? uid,
    $core.String? email,
    $core.String? displayName,
    $core.String? phoneNumber,
    $core.String? photoUrl,
    $core.bool? online,
    $core.bool? google,
    $core.bool? apple,
    $core.Iterable<$core.String>? favouriteTopics,
    $core.String? tag,
    $core.Iterable<$core.String>? tokens,
    $core.Iterable<$core.String>? latestInteractions,
    $core.Iterable<$core.String>? errors,
    $0.Timestamp? lastLogin,
    $0.Timestamp? lastLogout,
    $0.Timestamp? creationTime,
    $core.bool? disabled,
    $core.Iterable<User_Device>? devices,
  }) {
    final _result = create();
    if (uid != null) {
      _result.uid = uid;
    }
    if (email != null) {
      _result.email = email;
    }
    if (displayName != null) {
      _result.displayName = displayName;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (photoUrl != null) {
      _result.photoUrl = photoUrl;
    }
    if (online != null) {
      _result.online = online;
    }
    if (google != null) {
      _result.google = google;
    }
    if (apple != null) {
      _result.apple = apple;
    }
    if (favouriteTopics != null) {
      _result.favouriteTopics.addAll(favouriteTopics);
    }
    if (tag != null) {
      _result.tag = tag;
    }
    if (tokens != null) {
      _result.tokens.addAll(tokens);
    }
    if (latestInteractions != null) {
      _result.latestInteractions.addAll(latestInteractions);
    }
    if (errors != null) {
      _result.errors.addAll(errors);
    }
    if (lastLogin != null) {
      _result.lastLogin = lastLogin;
    }
    if (lastLogout != null) {
      _result.lastLogout = lastLogout;
    }
    if (creationTime != null) {
      _result.creationTime = creationTime;
    }
    if (disabled != null) {
      _result.disabled = disabled;
    }
    if (devices != null) {
      _result.devices.addAll(devices);
    }
    return _result;
  }
  factory User.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory User.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  User clone() => User()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  User copyWith(void Function(User) updates) => super.copyWith((message) => updates(message as User)) as User; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static User create() => User._();
  User createEmptyInstance() => create();
  static $pb.PbList<User> createRepeated() => $pb.PbList<User>();
  @$core.pragma('dart2js:noInline')
  static User getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<User>(create);
  static User? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get displayName => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDisplayName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get phoneNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set phoneNumber($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPhoneNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhoneNumber() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get photoUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set photoUrl($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPhotoUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhotoUrl() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get online => $_getBF(5);
  @$pb.TagNumber(6)
  set online($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasOnline() => $_has(5);
  @$pb.TagNumber(6)
  void clearOnline() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get google => $_getBF(6);
  @$pb.TagNumber(7)
  set google($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasGoogle() => $_has(6);
  @$pb.TagNumber(7)
  void clearGoogle() => clearField(7);

  @$pb.TagNumber(9)
  $core.bool get apple => $_getBF(7);
  @$pb.TagNumber(9)
  set apple($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasApple() => $_has(7);
  @$pb.TagNumber(9)
  void clearApple() => clearField(9);

  @$pb.TagNumber(10)
  $core.List<$core.String> get favouriteTopics => $_getList(8);

  @$pb.TagNumber(11)
  $core.String get tag => $_getSZ(9);
  @$pb.TagNumber(11)
  set tag($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(11)
  $core.bool hasTag() => $_has(9);
  @$pb.TagNumber(11)
  void clearTag() => clearField(11);

  @$pb.TagNumber(12)
  $core.List<$core.String> get tokens => $_getList(10);

  @$pb.TagNumber(13)
  $core.List<$core.String> get latestInteractions => $_getList(11);

  @$pb.TagNumber(14)
  $core.List<$core.String> get errors => $_getList(12);

  @$pb.TagNumber(15)
  $0.Timestamp get lastLogin => $_getN(13);
  @$pb.TagNumber(15)
  set lastLogin($0.Timestamp v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasLastLogin() => $_has(13);
  @$pb.TagNumber(15)
  void clearLastLogin() => clearField(15);
  @$pb.TagNumber(15)
  $0.Timestamp ensureLastLogin() => $_ensure(13);

  @$pb.TagNumber(16)
  $0.Timestamp get lastLogout => $_getN(14);
  @$pb.TagNumber(16)
  set lastLogout($0.Timestamp v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasLastLogout() => $_has(14);
  @$pb.TagNumber(16)
  void clearLastLogout() => clearField(16);
  @$pb.TagNumber(16)
  $0.Timestamp ensureLastLogout() => $_ensure(14);

  @$pb.TagNumber(17)
  $0.Timestamp get creationTime => $_getN(15);
  @$pb.TagNumber(17)
  set creationTime($0.Timestamp v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasCreationTime() => $_has(15);
  @$pb.TagNumber(17)
  void clearCreationTime() => clearField(17);
  @$pb.TagNumber(17)
  $0.Timestamp ensureCreationTime() => $_ensure(15);

  @$pb.TagNumber(18)
  $core.bool get disabled => $_getBF(16);
  @$pb.TagNumber(18)
  set disabled($core.bool v) { $_setBool(16, v); }
  @$pb.TagNumber(18)
  $core.bool hasDisabled() => $_has(16);
  @$pb.TagNumber(18)
  void clearDisabled() => clearField(18);

  @$pb.TagNumber(19)
  $core.List<User_Device> get devices => $_getList(17);
}

class UserPreference extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UserPreference', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'unknownPeopleRecommendations')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'themeIndex', $pb.PbFieldType.O3)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasDoneOnBoarding')
    ..pPS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'searchHistory')
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'shakeToFeedback')
    ..hasRequiredFields = false
  ;

  UserPreference._() : super();
  factory UserPreference({
    $core.String? userId,
    $core.bool? unknownPeopleRecommendations,
    $core.int? themeIndex,
    $core.bool? hasDoneOnBoarding,
    $core.Iterable<$core.String>? searchHistory,
    $core.bool? shakeToFeedback,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (unknownPeopleRecommendations != null) {
      _result.unknownPeopleRecommendations = unknownPeopleRecommendations;
    }
    if (themeIndex != null) {
      _result.themeIndex = themeIndex;
    }
    if (hasDoneOnBoarding != null) {
      _result.hasDoneOnBoarding = hasDoneOnBoarding;
    }
    if (searchHistory != null) {
      _result.searchHistory.addAll(searchHistory);
    }
    if (shakeToFeedback != null) {
      _result.shakeToFeedback = shakeToFeedback;
    }
    return _result;
  }
  factory UserPreference.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserPreference.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserPreference clone() => UserPreference()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserPreference copyWith(void Function(UserPreference) updates) => super.copyWith((message) => updates(message as UserPreference)) as UserPreference; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserPreference create() => UserPreference._();
  UserPreference createEmptyInstance() => create();
  static $pb.PbList<UserPreference> createRepeated() => $pb.PbList<UserPreference>();
  @$core.pragma('dart2js:noInline')
  static UserPreference getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserPreference>(create);
  static UserPreference? _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get unknownPeopleRecommendations => $_getBF(1);
  @$pb.TagNumber(3)
  set unknownPeopleRecommendations($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasUnknownPeopleRecommendations() => $_has(1);
  @$pb.TagNumber(3)
  void clearUnknownPeopleRecommendations() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get themeIndex => $_getIZ(2);
  @$pb.TagNumber(4)
  set themeIndex($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasThemeIndex() => $_has(2);
  @$pb.TagNumber(4)
  void clearThemeIndex() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get hasDoneOnBoarding => $_getBF(3);
  @$pb.TagNumber(5)
  set hasDoneOnBoarding($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasHasDoneOnBoarding() => $_has(3);
  @$pb.TagNumber(5)
  void clearHasDoneOnBoarding() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.String> get searchHistory => $_getList(4);

  @$pb.TagNumber(7)
  $core.bool get shakeToFeedback => $_getBF(5);
  @$pb.TagNumber(7)
  set shakeToFeedback($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasShakeToFeedback() => $_has(5);
  @$pb.TagNumber(7)
  void clearShakeToFeedback() => clearField(7);
}

class Langame extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Langame', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelName')
    ..pPS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'players')
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topics')
    ..pPS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memes')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'initiator')
    ..aOM<$0.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'done', subBuilder: $0.Timestamp.create)
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentMeme', $pb.PbFieldType.O3)
    ..aOM<$0.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'date', subBuilder: $0.Timestamp.create)
    ..pPS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errors')
    ..aOM<$0.Timestamp>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'started', subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextMeme', subBuilder: $0.Timestamp.create)
    ..a<$core.int>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memesSeen', $pb.PbFieldType.O3)
    ..aOM<$0.Timestamp>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memeChanged', subBuilder: $0.Timestamp.create)
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'link')
    ..pPS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reservedSpots')
    ..aOB(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isLocked')
    ..hasRequiredFields = false
  ;

  Langame._() : super();
  factory Langame({
    $core.String? channelName,
    $core.Iterable<$core.String>? players,
    $core.Iterable<$core.String>? topics,
    $core.Iterable<$core.String>? memes,
    $core.String? initiator,
    $0.Timestamp? done,
    $core.int? currentMeme,
    $0.Timestamp? date,
    $core.Iterable<$core.String>? errors,
    $0.Timestamp? started,
    $0.Timestamp? nextMeme,
    $core.int? memesSeen,
    $0.Timestamp? memeChanged,
    $core.String? link,
    $core.Iterable<$core.String>? reservedSpots,
    $core.bool? isLocked,
  }) {
    final _result = create();
    if (channelName != null) {
      _result.channelName = channelName;
    }
    if (players != null) {
      _result.players.addAll(players);
    }
    if (topics != null) {
      _result.topics.addAll(topics);
    }
    if (memes != null) {
      _result.memes.addAll(memes);
    }
    if (initiator != null) {
      _result.initiator = initiator;
    }
    if (done != null) {
      _result.done = done;
    }
    if (currentMeme != null) {
      _result.currentMeme = currentMeme;
    }
    if (date != null) {
      _result.date = date;
    }
    if (errors != null) {
      _result.errors.addAll(errors);
    }
    if (started != null) {
      _result.started = started;
    }
    if (nextMeme != null) {
      _result.nextMeme = nextMeme;
    }
    if (memesSeen != null) {
      _result.memesSeen = memesSeen;
    }
    if (memeChanged != null) {
      _result.memeChanged = memeChanged;
    }
    if (link != null) {
      _result.link = link;
    }
    if (reservedSpots != null) {
      _result.reservedSpots.addAll(reservedSpots);
    }
    if (isLocked != null) {
      _result.isLocked = isLocked;
    }
    return _result;
  }
  factory Langame.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Langame.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Langame clone() => Langame()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Langame copyWith(void Function(Langame) updates) => super.copyWith((message) => updates(message as Langame)) as Langame; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Langame create() => Langame._();
  Langame createEmptyInstance() => create();
  static $pb.PbList<Langame> createRepeated() => $pb.PbList<Langame>();
  @$core.pragma('dart2js:noInline')
  static Langame getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Langame>(create);
  static Langame? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get channelName => $_getSZ(0);
  @$pb.TagNumber(1)
  set channelName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannelName() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelName() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get players => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<$core.String> get topics => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<$core.String> get memes => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get initiator => $_getSZ(4);
  @$pb.TagNumber(5)
  set initiator($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasInitiator() => $_has(4);
  @$pb.TagNumber(5)
  void clearInitiator() => clearField(5);

  @$pb.TagNumber(7)
  $0.Timestamp get done => $_getN(5);
  @$pb.TagNumber(7)
  set done($0.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasDone() => $_has(5);
  @$pb.TagNumber(7)
  void clearDone() => clearField(7);
  @$pb.TagNumber(7)
  $0.Timestamp ensureDone() => $_ensure(5);

  @$pb.TagNumber(8)
  $core.int get currentMeme => $_getIZ(6);
  @$pb.TagNumber(8)
  set currentMeme($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasCurrentMeme() => $_has(6);
  @$pb.TagNumber(8)
  void clearCurrentMeme() => clearField(8);

  @$pb.TagNumber(9)
  $0.Timestamp get date => $_getN(7);
  @$pb.TagNumber(9)
  set date($0.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasDate() => $_has(7);
  @$pb.TagNumber(9)
  void clearDate() => clearField(9);
  @$pb.TagNumber(9)
  $0.Timestamp ensureDate() => $_ensure(7);

  @$pb.TagNumber(10)
  $core.List<$core.String> get errors => $_getList(8);

  @$pb.TagNumber(11)
  $0.Timestamp get started => $_getN(9);
  @$pb.TagNumber(11)
  set started($0.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasStarted() => $_has(9);
  @$pb.TagNumber(11)
  void clearStarted() => clearField(11);
  @$pb.TagNumber(11)
  $0.Timestamp ensureStarted() => $_ensure(9);

  @$pb.TagNumber(13)
  $0.Timestamp get nextMeme => $_getN(10);
  @$pb.TagNumber(13)
  set nextMeme($0.Timestamp v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasNextMeme() => $_has(10);
  @$pb.TagNumber(13)
  void clearNextMeme() => clearField(13);
  @$pb.TagNumber(13)
  $0.Timestamp ensureNextMeme() => $_ensure(10);

  @$pb.TagNumber(14)
  $core.int get memesSeen => $_getIZ(11);
  @$pb.TagNumber(14)
  set memesSeen($core.int v) { $_setSignedInt32(11, v); }
  @$pb.TagNumber(14)
  $core.bool hasMemesSeen() => $_has(11);
  @$pb.TagNumber(14)
  void clearMemesSeen() => clearField(14);

  @$pb.TagNumber(15)
  $0.Timestamp get memeChanged => $_getN(12);
  @$pb.TagNumber(15)
  set memeChanged($0.Timestamp v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasMemeChanged() => $_has(12);
  @$pb.TagNumber(15)
  void clearMemeChanged() => clearField(15);
  @$pb.TagNumber(15)
  $0.Timestamp ensureMemeChanged() => $_ensure(12);

  @$pb.TagNumber(16)
  $core.String get link => $_getSZ(13);
  @$pb.TagNumber(16)
  set link($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(16)
  $core.bool hasLink() => $_has(13);
  @$pb.TagNumber(16)
  void clearLink() => clearField(16);

  @$pb.TagNumber(18)
  $core.List<$core.String> get reservedSpots => $_getList(14);

  @$pb.TagNumber(19)
  $core.bool get isLocked => $_getBF(15);
  @$pb.TagNumber(19)
  set isLocked($core.bool v) { $_setBool(15, v); }
  @$pb.TagNumber(19)
  $core.bool hasIsLocked() => $_has(15);
  @$pb.TagNumber(19)
  void clearIsLocked() => clearField(19);
}

class Player extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Player', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOM<$0.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timeIn', subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timeOut', subBuilder: $0.Timestamp.create)
    ..pc<Note>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes', $pb.PbFieldType.PM, subBuilder: Note.create)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'audioId', $pb.PbFieldType.O3)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'audioToken')
    ..hasRequiredFields = false
  ;

  Player._() : super();
  factory Player({
    $core.String? userId,
    $0.Timestamp? timeIn,
    $0.Timestamp? timeOut,
    $core.Iterable<Note>? notes,
    $core.int? audioId,
    $core.String? audioToken,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (timeIn != null) {
      _result.timeIn = timeIn;
    }
    if (timeOut != null) {
      _result.timeOut = timeOut;
    }
    if (notes != null) {
      _result.notes.addAll(notes);
    }
    if (audioId != null) {
      _result.audioId = audioId;
    }
    if (audioToken != null) {
      _result.audioToken = audioToken;
    }
    return _result;
  }
  factory Player.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Player.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Player clone() => Player()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Player copyWith(void Function(Player) updates) => super.copyWith((message) => updates(message as Player)) as Player; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Player create() => Player._();
  Player createEmptyInstance() => create();
  static $pb.PbList<Player> createRepeated() => $pb.PbList<Player>();
  @$core.pragma('dart2js:noInline')
  static Player getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Player>(create);
  static Player? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $0.Timestamp get timeIn => $_getN(1);
  @$pb.TagNumber(2)
  set timeIn($0.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTimeIn() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimeIn() => clearField(2);
  @$pb.TagNumber(2)
  $0.Timestamp ensureTimeIn() => $_ensure(1);

  @$pb.TagNumber(3)
  $0.Timestamp get timeOut => $_getN(2);
  @$pb.TagNumber(3)
  set timeOut($0.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTimeOut() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimeOut() => clearField(3);
  @$pb.TagNumber(3)
  $0.Timestamp ensureTimeOut() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.List<Note> get notes => $_getList(3);

  @$pb.TagNumber(5)
  $core.int get audioId => $_getIZ(4);
  @$pb.TagNumber(5)
  set audioId($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAudioId() => $_has(4);
  @$pb.TagNumber(5)
  void clearAudioId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get audioToken => $_getSZ(5);
  @$pb.TagNumber(6)
  set audioToken($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAudioToken() => $_has(5);
  @$pb.TagNumber(6)
  void clearAudioToken() => clearField(6);
}

class Note_Generic extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Note.Generic', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'content')
    ..hasRequiredFields = false
  ;

  Note_Generic._() : super();
  factory Note_Generic({
    $core.String? content,
  }) {
    final _result = create();
    if (content != null) {
      _result.content = content;
    }
    return _result;
  }
  factory Note_Generic.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Note_Generic.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Note_Generic clone() => Note_Generic()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Note_Generic copyWith(void Function(Note_Generic) updates) => super.copyWith((message) => updates(message as Note_Generic)) as Note_Generic; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Note_Generic create() => Note_Generic._();
  Note_Generic createEmptyInstance() => create();
  static $pb.PbList<Note_Generic> createRepeated() => $pb.PbList<Note_Generic>();
  @$core.pragma('dart2js:noInline')
  static Note_Generic getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Note_Generic>(create);
  static Note_Generic? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get content => $_getSZ(0);
  @$pb.TagNumber(1)
  set content($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContent() => $_has(0);
  @$pb.TagNumber(1)
  void clearContent() => clearField(1);
}

class Note_Goal extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Note.Goal', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'content')
    ..hasRequiredFields = false
  ;

  Note_Goal._() : super();
  factory Note_Goal({
    $core.String? content,
  }) {
    final _result = create();
    if (content != null) {
      _result.content = content;
    }
    return _result;
  }
  factory Note_Goal.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Note_Goal.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Note_Goal clone() => Note_Goal()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Note_Goal copyWith(void Function(Note_Goal) updates) => super.copyWith((message) => updates(message as Note_Goal)) as Note_Goal; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Note_Goal create() => Note_Goal._();
  Note_Goal createEmptyInstance() => create();
  static $pb.PbList<Note_Goal> createRepeated() => $pb.PbList<Note_Goal>();
  @$core.pragma('dart2js:noInline')
  static Note_Goal getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Note_Goal>(create);
  static Note_Goal? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get content => $_getSZ(0);
  @$pb.TagNumber(1)
  set content($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContent() => $_has(0);
  @$pb.TagNumber(1)
  void clearContent() => clearField(1);
}

class Note_Definition extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Note.Definition', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'content')
    ..hasRequiredFields = false
  ;

  Note_Definition._() : super();
  factory Note_Definition({
    $core.String? content,
  }) {
    final _result = create();
    if (content != null) {
      _result.content = content;
    }
    return _result;
  }
  factory Note_Definition.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Note_Definition.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Note_Definition clone() => Note_Definition()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Note_Definition copyWith(void Function(Note_Definition) updates) => super.copyWith((message) => updates(message as Note_Definition)) as Note_Definition; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Note_Definition create() => Note_Definition._();
  Note_Definition createEmptyInstance() => create();
  static $pb.PbList<Note_Definition> createRepeated() => $pb.PbList<Note_Definition>();
  @$core.pragma('dart2js:noInline')
  static Note_Definition getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Note_Definition>(create);
  static Note_Definition? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get content => $_getSZ(0);
  @$pb.TagNumber(1)
  set content($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContent() => $_has(0);
  @$pb.TagNumber(1)
  void clearContent() => clearField(1);
}

enum Note_Type {
  generic, 
  goal, 
  definition, 
  notSet
}

class Note extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Note_Type> _Note_TypeByTag = {
    2 : Note_Type.generic,
    3 : Note_Type.goal,
    4 : Note_Type.definition,
    0 : Note_Type.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Note', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..oo(0, [2, 3, 4])
    ..aOM<$0.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $0.Timestamp.create)
    ..aOM<Note_Generic>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'generic', subBuilder: Note_Generic.create)
    ..aOM<Note_Goal>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'goal', subBuilder: Note_Goal.create)
    ..aOM<Note_Definition>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'definition', subBuilder: Note_Definition.create)
    ..hasRequiredFields = false
  ;

  Note._() : super();
  factory Note({
    $0.Timestamp? createdAt,
    Note_Generic? generic,
    Note_Goal? goal,
    Note_Definition? definition,
  }) {
    final _result = create();
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (generic != null) {
      _result.generic = generic;
    }
    if (goal != null) {
      _result.goal = goal;
    }
    if (definition != null) {
      _result.definition = definition;
    }
    return _result;
  }
  factory Note.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Note.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Note clone() => Note()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Note copyWith(void Function(Note) updates) => super.copyWith((message) => updates(message as Note)) as Note; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Note create() => Note._();
  Note createEmptyInstance() => create();
  static $pb.PbList<Note> createRepeated() => $pb.PbList<Note>();
  @$core.pragma('dart2js:noInline')
  static Note getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Note>(create);
  static Note? _defaultInstance;

  Note_Type whichType() => _Note_TypeByTag[$_whichOneof(0)]!;
  void clearType() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $0.Timestamp get createdAt => $_getN(0);
  @$pb.TagNumber(1)
  set createdAt($0.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCreatedAt() => $_has(0);
  @$pb.TagNumber(1)
  void clearCreatedAt() => clearField(1);
  @$pb.TagNumber(1)
  $0.Timestamp ensureCreatedAt() => $_ensure(0);

  @$pb.TagNumber(2)
  Note_Generic get generic => $_getN(1);
  @$pb.TagNumber(2)
  set generic(Note_Generic v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasGeneric() => $_has(1);
  @$pb.TagNumber(2)
  void clearGeneric() => clearField(2);
  @$pb.TagNumber(2)
  Note_Generic ensureGeneric() => $_ensure(1);

  @$pb.TagNumber(3)
  Note_Goal get goal => $_getN(2);
  @$pb.TagNumber(3)
  set goal(Note_Goal v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasGoal() => $_has(2);
  @$pb.TagNumber(3)
  void clearGoal() => clearField(3);
  @$pb.TagNumber(3)
  Note_Goal ensureGoal() => $_ensure(2);

  @$pb.TagNumber(4)
  Note_Definition get definition => $_getN(3);
  @$pb.TagNumber(4)
  set definition(Note_Definition v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasDefinition() => $_has(3);
  @$pb.TagNumber(4)
  void clearDefinition() => clearField(4);
  @$pb.TagNumber(4)
  Note_Definition ensureDefinition() => $_ensure(3);
}

class Notification extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Notification', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderUid')
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientsUid')
    ..pPS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topics')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelName')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ready')
    ..hasRequiredFields = false
  ;

  Notification._() : super();
  factory Notification({
    $core.String? id,
    $core.String? senderUid,
    $core.Iterable<$core.String>? recipientsUid,
    $core.Iterable<$core.String>? topics,
    $core.String? channelName,
    $core.bool? ready,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (senderUid != null) {
      _result.senderUid = senderUid;
    }
    if (recipientsUid != null) {
      _result.recipientsUid.addAll(recipientsUid);
    }
    if (topics != null) {
      _result.topics.addAll(topics);
    }
    if (channelName != null) {
      _result.channelName = channelName;
    }
    if (ready != null) {
      _result.ready = ready;
    }
    return _result;
  }
  factory Notification.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Notification.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Notification clone() => Notification()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Notification copyWith(void Function(Notification) updates) => super.copyWith((message) => updates(message as Notification)) as Notification; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Notification create() => Notification._();
  Notification createEmptyInstance() => create();
  static $pb.PbList<Notification> createRepeated() => $pb.PbList<Notification>();
  @$core.pragma('dart2js:noInline')
  static Notification getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Notification>(create);
  static Notification? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get senderUid => $_getSZ(1);
  @$pb.TagNumber(2)
  set senderUid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSenderUid() => $_has(1);
  @$pb.TagNumber(2)
  void clearSenderUid() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get recipientsUid => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<$core.String> get topics => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get channelName => $_getSZ(4);
  @$pb.TagNumber(5)
  set channelName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasChannelName() => $_has(4);
  @$pb.TagNumber(5)
  void clearChannelName() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get ready => $_getBF(5);
  @$pb.TagNumber(6)
  set ready($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasReady() => $_has(5);
  @$pb.TagNumber(6)
  void clearReady() => clearField(6);
}

class Subscription extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Subscription', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..hasRequiredFields = false
  ;

  Subscription._() : super();
  factory Subscription({
    $core.String? status,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory Subscription.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Subscription.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Subscription clone() => Subscription()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Subscription copyWith(void Function(Subscription) updates) => super.copyWith((message) => updates(message as Subscription)) as Subscription; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Subscription create() => Subscription._();
  Subscription createEmptyInstance() => create();
  static $pb.PbList<Subscription> createRepeated() => $pb.PbList<Subscription>();
  @$core.pragma('dart2js:noInline')
  static Subscription getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Subscription>(create);
  static Subscription? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);
}

class FunctionResponse_VersionCheck extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FunctionResponse.VersionCheck', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..e<FunctionResponse_VersionCheck_UpdateRequired>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'update', $pb.PbFieldType.OE, defaultOrMaker: FunctionResponse_VersionCheck_UpdateRequired.OK, valueOf: FunctionResponse_VersionCheck_UpdateRequired.valueOf, enumValues: FunctionResponse_VersionCheck_UpdateRequired.values)
    ..hasRequiredFields = false
  ;

  FunctionResponse_VersionCheck._() : super();
  factory FunctionResponse_VersionCheck({
    FunctionResponse_VersionCheck_UpdateRequired? update,
  }) {
    final _result = create();
    if (update != null) {
      _result.update = update;
    }
    return _result;
  }
  factory FunctionResponse_VersionCheck.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FunctionResponse_VersionCheck.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FunctionResponse_VersionCheck clone() => FunctionResponse_VersionCheck()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FunctionResponse_VersionCheck copyWith(void Function(FunctionResponse_VersionCheck) updates) => super.copyWith((message) => updates(message as FunctionResponse_VersionCheck)) as FunctionResponse_VersionCheck; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FunctionResponse_VersionCheck create() => FunctionResponse_VersionCheck._();
  FunctionResponse_VersionCheck createEmptyInstance() => create();
  static $pb.PbList<FunctionResponse_VersionCheck> createRepeated() => $pb.PbList<FunctionResponse_VersionCheck>();
  @$core.pragma('dart2js:noInline')
  static FunctionResponse_VersionCheck getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FunctionResponse_VersionCheck>(create);
  static FunctionResponse_VersionCheck? _defaultInstance;

  @$pb.TagNumber(1)
  FunctionResponse_VersionCheck_UpdateRequired get update => $_getN(0);
  @$pb.TagNumber(1)
  set update(FunctionResponse_VersionCheck_UpdateRequired v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUpdate() => $_has(0);
  @$pb.TagNumber(1)
  void clearUpdate() => clearField(1);
}

enum FunctionResponse_Type {
  versionCheck, 
  notSet
}

class FunctionResponse extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, FunctionResponse_Type> _FunctionResponse_TypeByTag = {
    1 : FunctionResponse_Type.versionCheck,
    0 : FunctionResponse_Type.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FunctionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..oo(0, [1])
    ..aOM<FunctionResponse_VersionCheck>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'versionCheck', subBuilder: FunctionResponse_VersionCheck.create)
    ..hasRequiredFields = false
  ;

  FunctionResponse._() : super();
  factory FunctionResponse({
    FunctionResponse_VersionCheck? versionCheck,
  }) {
    final _result = create();
    if (versionCheck != null) {
      _result.versionCheck = versionCheck;
    }
    return _result;
  }
  factory FunctionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FunctionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FunctionResponse clone() => FunctionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FunctionResponse copyWith(void Function(FunctionResponse) updates) => super.copyWith((message) => updates(message as FunctionResponse)) as FunctionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FunctionResponse create() => FunctionResponse._();
  FunctionResponse createEmptyInstance() => create();
  static $pb.PbList<FunctionResponse> createRepeated() => $pb.PbList<FunctionResponse>();
  @$core.pragma('dart2js:noInline')
  static FunctionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FunctionResponse>(create);
  static FunctionResponse? _defaultInstance;

  FunctionResponse_Type whichType() => _FunctionResponse_TypeByTag[$_whichOneof(0)]!;
  void clearType() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  FunctionResponse_VersionCheck get versionCheck => $_getN(0);
  @$pb.TagNumber(1)
  set versionCheck(FunctionResponse_VersionCheck v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasVersionCheck() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersionCheck() => clearField(1);
  @$pb.TagNumber(1)
  FunctionResponse_VersionCheck ensureVersionCheck() => $_ensure(0);
}

class Prompt extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Prompt', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'template')
    ..pc<Tag>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tags', $pb.PbFieldType.PM, subBuilder: Tag.create)
    ..hasRequiredFields = false
  ;

  Prompt._() : super();
  factory Prompt({
    $core.String? type,
    $core.String? template,
    $core.Iterable<Tag>? tags,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (template != null) {
      _result.template = template;
    }
    if (tags != null) {
      _result.tags.addAll(tags);
    }
    return _result;
  }
  factory Prompt.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Prompt.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Prompt clone() => Prompt()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Prompt copyWith(void Function(Prompt) updates) => super.copyWith((message) => updates(message as Prompt)) as Prompt; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Prompt create() => Prompt._();
  Prompt createEmptyInstance() => create();
  static $pb.PbList<Prompt> createRepeated() => $pb.PbList<Prompt>();
  @$core.pragma('dart2js:noInline')
  static Prompt getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Prompt>(create);
  static Prompt? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get template => $_getSZ(1);
  @$pb.TagNumber(2)
  set template($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTemplate() => $_has(1);
  @$pb.TagNumber(2)
  void clearTemplate() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<Tag> get tags => $_getList(2);
}

