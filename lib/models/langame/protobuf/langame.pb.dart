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
    ..hasRequiredFields = false
  ;

  Meme._() : super();
  factory Meme({
    $0.Timestamp? createdAt,
    $core.String? content,
    $core.Iterable<Tag>? tags,
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

class Tag_Origin_OpenAI extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Tag.Origin.OpenAI', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'version', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  Tag_Origin_OpenAI._() : super();
  factory Tag_Origin_OpenAI({
    $core.int? version,
  }) {
    final _result = create();
    if (version != null) {
      _result.version = version;
    }
    return _result;
  }
  factory Tag_Origin_OpenAI.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Tag_Origin_OpenAI.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Tag_Origin_OpenAI clone() => Tag_Origin_OpenAI()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Tag_Origin_OpenAI copyWith(void Function(Tag_Origin_OpenAI) updates) => super.copyWith((message) => updates(message as Tag_Origin_OpenAI)) as Tag_Origin_OpenAI; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Tag_Origin_OpenAI create() => Tag_Origin_OpenAI._();
  Tag_Origin_OpenAI createEmptyInstance() => create();
  static $pb.PbList<Tag_Origin_OpenAI> createRepeated() => $pb.PbList<Tag_Origin_OpenAI>();
  @$core.pragma('dart2js:noInline')
  static Tag_Origin_OpenAI getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Tag_Origin_OpenAI>(create);
  static Tag_Origin_OpenAI? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get version => $_getIZ(0);
  @$pb.TagNumber(1)
  set version($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => clearField(1);
}

enum Tag_Origin_Type {
  openai, 
  notSet
}

class Tag_Origin extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Tag_Origin_Type> _Tag_Origin_TypeByTag = {
    2 : Tag_Origin_Type.openai,
    0 : Tag_Origin_Type.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Tag.Origin', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..oo(0, [2])
    ..aOM<Tag_Origin_OpenAI>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'openai', subBuilder: Tag_Origin_OpenAI.create)
    ..hasRequiredFields = false
  ;

  Tag_Origin._() : super();
  factory Tag_Origin({
    Tag_Origin_OpenAI? openai,
  }) {
    final _result = create();
    if (openai != null) {
      _result.openai = openai;
    }
    return _result;
  }
  factory Tag_Origin.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Tag_Origin.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Tag_Origin clone() => Tag_Origin()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Tag_Origin copyWith(void Function(Tag_Origin) updates) => super.copyWith((message) => updates(message as Tag_Origin)) as Tag_Origin; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Tag_Origin create() => Tag_Origin._();
  Tag_Origin createEmptyInstance() => create();
  static $pb.PbList<Tag_Origin> createRepeated() => $pb.PbList<Tag_Origin>();
  @$core.pragma('dart2js:noInline')
  static Tag_Origin getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Tag_Origin>(create);
  static Tag_Origin? _defaultInstance;

  Tag_Origin_Type whichType() => _Tag_Origin_TypeByTag[$_whichOneof(0)]!;
  void clearType() => clearField($_whichOneof(0));

  @$pb.TagNumber(2)
  Tag_Origin_OpenAI get openai => $_getN(0);
  @$pb.TagNumber(2)
  set openai(Tag_Origin_OpenAI v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasOpenai() => $_has(0);
  @$pb.TagNumber(2)
  void clearOpenai() => clearField(2);
  @$pb.TagNumber(2)
  Tag_Origin_OpenAI ensureOpenai() => $_ensure(0);
}

class Tag_Feedback_GeneralScore extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Tag.Feedback.GeneralScore', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'score', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  Tag_Feedback_GeneralScore._() : super();
  factory Tag_Feedback_GeneralScore({
    $core.int? score,
  }) {
    final _result = create();
    if (score != null) {
      _result.score = score;
    }
    return _result;
  }
  factory Tag_Feedback_GeneralScore.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Tag_Feedback_GeneralScore.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Tag_Feedback_GeneralScore clone() => Tag_Feedback_GeneralScore()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Tag_Feedback_GeneralScore copyWith(void Function(Tag_Feedback_GeneralScore) updates) => super.copyWith((message) => updates(message as Tag_Feedback_GeneralScore)) as Tag_Feedback_GeneralScore; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Tag_Feedback_GeneralScore create() => Tag_Feedback_GeneralScore._();
  Tag_Feedback_GeneralScore createEmptyInstance() => create();
  static $pb.PbList<Tag_Feedback_GeneralScore> createRepeated() => $pb.PbList<Tag_Feedback_GeneralScore>();
  @$core.pragma('dart2js:noInline')
  static Tag_Feedback_GeneralScore getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Tag_Feedback_GeneralScore>(create);
  static Tag_Feedback_GeneralScore? _defaultInstance;

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
  score, 
  relevance, 
  notSet
}

class Tag_Feedback extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Tag_Feedback_Type> _Tag_Feedback_TypeByTag = {
    2 : Tag_Feedback_Type.score,
    3 : Tag_Feedback_Type.relevance,
    0 : Tag_Feedback_Type.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Tag.Feedback', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..oo(0, [2, 3])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOM<Tag_Feedback_GeneralScore>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'score', subBuilder: Tag_Feedback_GeneralScore.create)
    ..aOM<Tag_Feedback_Relevance>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'relevance', subBuilder: Tag_Feedback_Relevance.create)
    ..hasRequiredFields = false
  ;

  Tag_Feedback._() : super();
  factory Tag_Feedback({
    $core.String? userId,
    Tag_Feedback_GeneralScore? score,
    Tag_Feedback_Relevance? relevance,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (score != null) {
      _result.score = score;
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
  Tag_Feedback_GeneralScore get score => $_getN(1);
  @$pb.TagNumber(2)
  set score(Tag_Feedback_GeneralScore v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasScore() => $_has(1);
  @$pb.TagNumber(2)
  void clearScore() => clearField(2);
  @$pb.TagNumber(2)
  Tag_Feedback_GeneralScore ensureScore() => $_ensure(1);

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
  origin, 
  feedback, 
  context, 
  notSet
}

class Tag extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Tag_Type> _Tag_TypeByTag = {
    2 : Tag_Type.topic,
    3 : Tag_Type.classification,
    4 : Tag_Type.origin,
    5 : Tag_Type.feedback,
    6 : Tag_Type.context,
    0 : Tag_Type.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Tag', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..oo(0, [2, 3, 4, 5, 6])
    ..aOM<$0.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $0.Timestamp.create)
    ..aOM<Tag_Topic>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topic', subBuilder: Tag_Topic.create)
    ..aOM<Tag_Classification>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'classification', subBuilder: Tag_Classification.create)
    ..aOM<Tag_Origin>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'origin', subBuilder: Tag_Origin.create)
    ..aOM<Tag_Feedback>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'feedback', subBuilder: Tag_Feedback.create)
    ..aOM<Tag_Context>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'context', subBuilder: Tag_Context.create)
    ..hasRequiredFields = false
  ;

  Tag._() : super();
  factory Tag({
    $0.Timestamp? createdAt,
    Tag_Topic? topic,
    Tag_Classification? classification,
    Tag_Origin? origin,
    Tag_Feedback? feedback,
    Tag_Context? context,
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
    if (origin != null) {
      _result.origin = origin;
    }
    if (feedback != null) {
      _result.feedback = feedback;
    }
    if (context != null) {
      _result.context = context;
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
  Tag_Origin get origin => $_getN(3);
  @$pb.TagNumber(4)
  set origin(Tag_Origin v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasOrigin() => $_has(3);
  @$pb.TagNumber(4)
  void clearOrigin() => clearField(4);
  @$pb.TagNumber(4)
  Tag_Origin ensureOrigin() => $_ensure(3);

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
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'facebook')
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
    $core.bool? facebook,
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
    if (facebook != null) {
      _result.facebook = facebook;
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

  @$pb.TagNumber(8)
  $core.bool get facebook => $_getBF(7);
  @$pb.TagNumber(8)
  set facebook($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasFacebook() => $_has(7);
  @$pb.TagNumber(8)
  void clearFacebook() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get apple => $_getBF(8);
  @$pb.TagNumber(9)
  set apple($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasApple() => $_has(8);
  @$pb.TagNumber(9)
  void clearApple() => clearField(9);

  @$pb.TagNumber(10)
  $core.List<$core.String> get favouriteTopics => $_getList(9);

  @$pb.TagNumber(11)
  $core.String get tag => $_getSZ(10);
  @$pb.TagNumber(11)
  set tag($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasTag() => $_has(10);
  @$pb.TagNumber(11)
  void clearTag() => clearField(11);

  @$pb.TagNumber(12)
  $core.List<$core.String> get tokens => $_getList(11);

  @$pb.TagNumber(13)
  $core.List<$core.String> get latestInteractions => $_getList(12);

  @$pb.TagNumber(14)
  $core.List<$core.String> get errors => $_getList(13);

  @$pb.TagNumber(15)
  $0.Timestamp get lastLogin => $_getN(14);
  @$pb.TagNumber(15)
  set lastLogin($0.Timestamp v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasLastLogin() => $_has(14);
  @$pb.TagNumber(15)
  void clearLastLogin() => clearField(15);
  @$pb.TagNumber(15)
  $0.Timestamp ensureLastLogin() => $_ensure(14);

  @$pb.TagNumber(16)
  $0.Timestamp get lastLogout => $_getN(15);
  @$pb.TagNumber(16)
  set lastLogout($0.Timestamp v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasLastLogout() => $_has(15);
  @$pb.TagNumber(16)
  void clearLastLogout() => clearField(16);
  @$pb.TagNumber(16)
  $0.Timestamp ensureLastLogout() => $_ensure(15);

  @$pb.TagNumber(17)
  $0.Timestamp get creationTime => $_getN(16);
  @$pb.TagNumber(17)
  set creationTime($0.Timestamp v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasCreationTime() => $_has(16);
  @$pb.TagNumber(17)
  void clearCreationTime() => clearField(17);
  @$pb.TagNumber(17)
  $0.Timestamp ensureCreationTime() => $_ensure(16);

  @$pb.TagNumber(18)
  $core.bool get disabled => $_getBF(17);
  @$pb.TagNumber(18)
  set disabled($core.bool v) { $_setBool(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasDisabled() => $_has(17);
  @$pb.TagNumber(18)
  void clearDisabled() => clearField(18);
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
    ..a<$core.int>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentAudioId', $pb.PbFieldType.O3)
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
    $core.int? currentAudioId,
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
    if (currentAudioId != null) {
      _result.currentAudioId = currentAudioId;
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

  @$pb.TagNumber(12)
  $core.int get currentAudioId => $_getIZ(10);
  @$pb.TagNumber(12)
  set currentAudioId($core.int v) { $_setSignedInt32(10, v); }
  @$pb.TagNumber(12)
  $core.bool hasCurrentAudioId() => $_has(10);
  @$pb.TagNumber(12)
  void clearCurrentAudioId() => clearField(12);
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

class Paint_SelectionRectangle extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Paint.SelectionRectangle', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOM<Paint_DrawShape>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'shapeProperties', subBuilder: Paint_DrawShape.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'shiftX', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'shiftY', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  Paint_SelectionRectangle._() : super();
  factory Paint_SelectionRectangle({
    Paint_DrawShape? shapeProperties,
    $core.double? shiftX,
    $core.double? shiftY,
  }) {
    final _result = create();
    if (shapeProperties != null) {
      _result.shapeProperties = shapeProperties;
    }
    if (shiftX != null) {
      _result.shiftX = shiftX;
    }
    if (shiftY != null) {
      _result.shiftY = shiftY;
    }
    return _result;
  }
  factory Paint_SelectionRectangle.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Paint_SelectionRectangle.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Paint_SelectionRectangle clone() => Paint_SelectionRectangle()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Paint_SelectionRectangle copyWith(void Function(Paint_SelectionRectangle) updates) => super.copyWith((message) => updates(message as Paint_SelectionRectangle)) as Paint_SelectionRectangle; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Paint_SelectionRectangle create() => Paint_SelectionRectangle._();
  Paint_SelectionRectangle createEmptyInstance() => create();
  static $pb.PbList<Paint_SelectionRectangle> createRepeated() => $pb.PbList<Paint_SelectionRectangle>();
  @$core.pragma('dart2js:noInline')
  static Paint_SelectionRectangle getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Paint_SelectionRectangle>(create);
  static Paint_SelectionRectangle? _defaultInstance;

  @$pb.TagNumber(1)
  Paint_DrawShape get shapeProperties => $_getN(0);
  @$pb.TagNumber(1)
  set shapeProperties(Paint_DrawShape v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasShapeProperties() => $_has(0);
  @$pb.TagNumber(1)
  void clearShapeProperties() => clearField(1);
  @$pb.TagNumber(1)
  Paint_DrawShape ensureShapeProperties() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get shiftX => $_getN(1);
  @$pb.TagNumber(2)
  set shiftX($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasShiftX() => $_has(1);
  @$pb.TagNumber(2)
  void clearShiftX() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get shiftY => $_getN(2);
  @$pb.TagNumber(3)
  set shiftY($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasShiftY() => $_has(2);
  @$pb.TagNumber(3)
  void clearShiftY() => clearField(3);
}

class Paint_SelectionCircle extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Paint.SelectionCircle', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOM<Paint_DrawShape>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'shapeProperties', subBuilder: Paint_DrawShape.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'shiftX', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'shiftY', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  Paint_SelectionCircle._() : super();
  factory Paint_SelectionCircle({
    Paint_DrawShape? shapeProperties,
    $core.double? shiftX,
    $core.double? shiftY,
  }) {
    final _result = create();
    if (shapeProperties != null) {
      _result.shapeProperties = shapeProperties;
    }
    if (shiftX != null) {
      _result.shiftX = shiftX;
    }
    if (shiftY != null) {
      _result.shiftY = shiftY;
    }
    return _result;
  }
  factory Paint_SelectionCircle.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Paint_SelectionCircle.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Paint_SelectionCircle clone() => Paint_SelectionCircle()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Paint_SelectionCircle copyWith(void Function(Paint_SelectionCircle) updates) => super.copyWith((message) => updates(message as Paint_SelectionCircle)) as Paint_SelectionCircle; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Paint_SelectionCircle create() => Paint_SelectionCircle._();
  Paint_SelectionCircle createEmptyInstance() => create();
  static $pb.PbList<Paint_SelectionCircle> createRepeated() => $pb.PbList<Paint_SelectionCircle>();
  @$core.pragma('dart2js:noInline')
  static Paint_SelectionCircle getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Paint_SelectionCircle>(create);
  static Paint_SelectionCircle? _defaultInstance;

  @$pb.TagNumber(1)
  Paint_DrawShape get shapeProperties => $_getN(0);
  @$pb.TagNumber(1)
  set shapeProperties(Paint_DrawShape v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasShapeProperties() => $_has(0);
  @$pb.TagNumber(1)
  void clearShapeProperties() => clearField(1);
  @$pb.TagNumber(1)
  Paint_DrawShape ensureShapeProperties() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get shiftX => $_getN(1);
  @$pb.TagNumber(2)
  set shiftX($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasShiftX() => $_has(1);
  @$pb.TagNumber(2)
  void clearShiftX() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get shiftY => $_getN(2);
  @$pb.TagNumber(3)
  set shiftY($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasShiftY() => $_has(2);
  @$pb.TagNumber(3)
  void clearShiftY() => clearField(3);
}

class Paint_SelectionLine extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Paint.SelectionLine', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOM<Paint_DrawShape>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'shapeProperties', subBuilder: Paint_DrawShape.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isP1')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newX', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newY', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  Paint_SelectionLine._() : super();
  factory Paint_SelectionLine({
    Paint_DrawShape? shapeProperties,
    $core.bool? isP1,
    $core.double? newX,
    $core.double? newY,
  }) {
    final _result = create();
    if (shapeProperties != null) {
      _result.shapeProperties = shapeProperties;
    }
    if (isP1 != null) {
      _result.isP1 = isP1;
    }
    if (newX != null) {
      _result.newX = newX;
    }
    if (newY != null) {
      _result.newY = newY;
    }
    return _result;
  }
  factory Paint_SelectionLine.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Paint_SelectionLine.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Paint_SelectionLine clone() => Paint_SelectionLine()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Paint_SelectionLine copyWith(void Function(Paint_SelectionLine) updates) => super.copyWith((message) => updates(message as Paint_SelectionLine)) as Paint_SelectionLine; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Paint_SelectionLine create() => Paint_SelectionLine._();
  Paint_SelectionLine createEmptyInstance() => create();
  static $pb.PbList<Paint_SelectionLine> createRepeated() => $pb.PbList<Paint_SelectionLine>();
  @$core.pragma('dart2js:noInline')
  static Paint_SelectionLine getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Paint_SelectionLine>(create);
  static Paint_SelectionLine? _defaultInstance;

  @$pb.TagNumber(1)
  Paint_DrawShape get shapeProperties => $_getN(0);
  @$pb.TagNumber(1)
  set shapeProperties(Paint_DrawShape v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasShapeProperties() => $_has(0);
  @$pb.TagNumber(1)
  void clearShapeProperties() => clearField(1);
  @$pb.TagNumber(1)
  Paint_DrawShape ensureShapeProperties() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get isP1 => $_getBF(1);
  @$pb.TagNumber(2)
  set isP1($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsP1() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsP1() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get newX => $_getN(2);
  @$pb.TagNumber(3)
  set newX($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNewX() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewX() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get newY => $_getN(3);
  @$pb.TagNumber(4)
  set newY($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNewY() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewY() => clearField(4);
}

class Paint_SelectionText extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Paint.SelectionText', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOM<Paint_DrawShape>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'shapeProperties', subBuilder: Paint_DrawShape.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newX', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newY', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  Paint_SelectionText._() : super();
  factory Paint_SelectionText({
    Paint_DrawShape? shapeProperties,
    $core.double? newX,
    $core.double? newY,
  }) {
    final _result = create();
    if (shapeProperties != null) {
      _result.shapeProperties = shapeProperties;
    }
    if (newX != null) {
      _result.newX = newX;
    }
    if (newY != null) {
      _result.newY = newY;
    }
    return _result;
  }
  factory Paint_SelectionText.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Paint_SelectionText.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Paint_SelectionText clone() => Paint_SelectionText()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Paint_SelectionText copyWith(void Function(Paint_SelectionText) updates) => super.copyWith((message) => updates(message as Paint_SelectionText)) as Paint_SelectionText; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Paint_SelectionText create() => Paint_SelectionText._();
  Paint_SelectionText createEmptyInstance() => create();
  static $pb.PbList<Paint_SelectionText> createRepeated() => $pb.PbList<Paint_SelectionText>();
  @$core.pragma('dart2js:noInline')
  static Paint_SelectionText getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Paint_SelectionText>(create);
  static Paint_SelectionText? _defaultInstance;

  @$pb.TagNumber(1)
  Paint_DrawShape get shapeProperties => $_getN(0);
  @$pb.TagNumber(1)
  set shapeProperties(Paint_DrawShape v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasShapeProperties() => $_has(0);
  @$pb.TagNumber(1)
  void clearShapeProperties() => clearField(1);
  @$pb.TagNumber(1)
  Paint_DrawShape ensureShapeProperties() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newX => $_getN(1);
  @$pb.TagNumber(2)
  set newX($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewX() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewX() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get newY => $_getN(2);
  @$pb.TagNumber(3)
  set newY($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNewY() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewY() => clearField(3);
}

class Paint_DrawShape extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Paint.DrawShape', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'r', $pb.PbFieldType.O3)
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'g', $pb.PbFieldType.O3)
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'b', $pb.PbFieldType.O3)
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'screenWidth', $pb.PbFieldType.OD, protoName: 'screenWidth')
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'screenHeight', $pb.PbFieldType.OD, protoName: 'screenHeight')
    ..hasRequiredFields = false
  ;

  Paint_DrawShape._() : super();
  factory Paint_DrawShape({
    $core.String? id,
    $core.int? r,
    $core.int? g,
    $core.int? b,
    $core.double? screenWidth,
    $core.double? screenHeight,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (r != null) {
      _result.r = r;
    }
    if (g != null) {
      _result.g = g;
    }
    if (b != null) {
      _result.b = b;
    }
    if (screenWidth != null) {
      _result.screenWidth = screenWidth;
    }
    if (screenHeight != null) {
      _result.screenHeight = screenHeight;
    }
    return _result;
  }
  factory Paint_DrawShape.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Paint_DrawShape.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Paint_DrawShape clone() => Paint_DrawShape()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Paint_DrawShape copyWith(void Function(Paint_DrawShape) updates) => super.copyWith((message) => updates(message as Paint_DrawShape)) as Paint_DrawShape; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Paint_DrawShape create() => Paint_DrawShape._();
  Paint_DrawShape createEmptyInstance() => create();
  static $pb.PbList<Paint_DrawShape> createRepeated() => $pb.PbList<Paint_DrawShape>();
  @$core.pragma('dart2js:noInline')
  static Paint_DrawShape getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Paint_DrawShape>(create);
  static Paint_DrawShape? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(6)
  $core.int get r => $_getIZ(1);
  @$pb.TagNumber(6)
  set r($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(6)
  $core.bool hasR() => $_has(1);
  @$pb.TagNumber(6)
  void clearR() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get g => $_getIZ(2);
  @$pb.TagNumber(7)
  set g($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(7)
  $core.bool hasG() => $_has(2);
  @$pb.TagNumber(7)
  void clearG() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get b => $_getIZ(3);
  @$pb.TagNumber(8)
  set b($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(8)
  $core.bool hasB() => $_has(3);
  @$pb.TagNumber(8)
  void clearB() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get screenWidth => $_getN(4);
  @$pb.TagNumber(9)
  set screenWidth($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(9)
  $core.bool hasScreenWidth() => $_has(4);
  @$pb.TagNumber(9)
  void clearScreenWidth() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get screenHeight => $_getN(5);
  @$pb.TagNumber(10)
  set screenHeight($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(10)
  $core.bool hasScreenHeight() => $_has(5);
  @$pb.TagNumber(10)
  void clearScreenHeight() => clearField(10);
}

class Paint_DrawRectangle extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Paint.DrawRectangle', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOM<Paint_DrawShape>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'shapeProperties', subBuilder: Paint_DrawShape.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bottomLeftX', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bottomLeftY', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topRightX', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topRightY', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  Paint_DrawRectangle._() : super();
  factory Paint_DrawRectangle({
    Paint_DrawShape? shapeProperties,
    $core.double? bottomLeftX,
    $core.double? bottomLeftY,
    $core.double? topRightX,
    $core.double? topRightY,
  }) {
    final _result = create();
    if (shapeProperties != null) {
      _result.shapeProperties = shapeProperties;
    }
    if (bottomLeftX != null) {
      _result.bottomLeftX = bottomLeftX;
    }
    if (bottomLeftY != null) {
      _result.bottomLeftY = bottomLeftY;
    }
    if (topRightX != null) {
      _result.topRightX = topRightX;
    }
    if (topRightY != null) {
      _result.topRightY = topRightY;
    }
    return _result;
  }
  factory Paint_DrawRectangle.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Paint_DrawRectangle.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Paint_DrawRectangle clone() => Paint_DrawRectangle()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Paint_DrawRectangle copyWith(void Function(Paint_DrawRectangle) updates) => super.copyWith((message) => updates(message as Paint_DrawRectangle)) as Paint_DrawRectangle; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Paint_DrawRectangle create() => Paint_DrawRectangle._();
  Paint_DrawRectangle createEmptyInstance() => create();
  static $pb.PbList<Paint_DrawRectangle> createRepeated() => $pb.PbList<Paint_DrawRectangle>();
  @$core.pragma('dart2js:noInline')
  static Paint_DrawRectangle getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Paint_DrawRectangle>(create);
  static Paint_DrawRectangle? _defaultInstance;

  @$pb.TagNumber(1)
  Paint_DrawShape get shapeProperties => $_getN(0);
  @$pb.TagNumber(1)
  set shapeProperties(Paint_DrawShape v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasShapeProperties() => $_has(0);
  @$pb.TagNumber(1)
  void clearShapeProperties() => clearField(1);
  @$pb.TagNumber(1)
  Paint_DrawShape ensureShapeProperties() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get bottomLeftX => $_getN(1);
  @$pb.TagNumber(2)
  set bottomLeftX($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBottomLeftX() => $_has(1);
  @$pb.TagNumber(2)
  void clearBottomLeftX() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get bottomLeftY => $_getN(2);
  @$pb.TagNumber(3)
  set bottomLeftY($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBottomLeftY() => $_has(2);
  @$pb.TagNumber(3)
  void clearBottomLeftY() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get topRightX => $_getN(3);
  @$pb.TagNumber(4)
  set topRightX($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTopRightX() => $_has(3);
  @$pb.TagNumber(4)
  void clearTopRightX() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get topRightY => $_getN(4);
  @$pb.TagNumber(5)
  set topRightY($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTopRightY() => $_has(4);
  @$pb.TagNumber(5)
  void clearTopRightY() => clearField(5);
}

class Paint_DrawCircle extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Paint.DrawCircle', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOM<Paint_DrawShape>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'shapeProperties', subBuilder: Paint_DrawShape.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'centerX', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'centerY', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'radius', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  Paint_DrawCircle._() : super();
  factory Paint_DrawCircle({
    Paint_DrawShape? shapeProperties,
    $core.double? centerX,
    $core.double? centerY,
    $core.double? radius,
  }) {
    final _result = create();
    if (shapeProperties != null) {
      _result.shapeProperties = shapeProperties;
    }
    if (centerX != null) {
      _result.centerX = centerX;
    }
    if (centerY != null) {
      _result.centerY = centerY;
    }
    if (radius != null) {
      _result.radius = radius;
    }
    return _result;
  }
  factory Paint_DrawCircle.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Paint_DrawCircle.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Paint_DrawCircle clone() => Paint_DrawCircle()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Paint_DrawCircle copyWith(void Function(Paint_DrawCircle) updates) => super.copyWith((message) => updates(message as Paint_DrawCircle)) as Paint_DrawCircle; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Paint_DrawCircle create() => Paint_DrawCircle._();
  Paint_DrawCircle createEmptyInstance() => create();
  static $pb.PbList<Paint_DrawCircle> createRepeated() => $pb.PbList<Paint_DrawCircle>();
  @$core.pragma('dart2js:noInline')
  static Paint_DrawCircle getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Paint_DrawCircle>(create);
  static Paint_DrawCircle? _defaultInstance;

  @$pb.TagNumber(1)
  Paint_DrawShape get shapeProperties => $_getN(0);
  @$pb.TagNumber(1)
  set shapeProperties(Paint_DrawShape v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasShapeProperties() => $_has(0);
  @$pb.TagNumber(1)
  void clearShapeProperties() => clearField(1);
  @$pb.TagNumber(1)
  Paint_DrawShape ensureShapeProperties() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get centerX => $_getN(1);
  @$pb.TagNumber(2)
  set centerX($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCenterX() => $_has(1);
  @$pb.TagNumber(2)
  void clearCenterX() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get centerY => $_getN(2);
  @$pb.TagNumber(3)
  set centerY($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCenterY() => $_has(2);
  @$pb.TagNumber(3)
  void clearCenterY() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get radius => $_getN(3);
  @$pb.TagNumber(4)
  set radius($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRadius() => $_has(3);
  @$pb.TagNumber(4)
  void clearRadius() => clearField(4);
}

class Paint_DrawLine extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Paint.DrawLine', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOM<Paint_DrawShape>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'shapeProperties', subBuilder: Paint_DrawShape.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'p1X', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'p1Y', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'p2X', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'p2Y', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  Paint_DrawLine._() : super();
  factory Paint_DrawLine({
    Paint_DrawShape? shapeProperties,
    $core.double? p1X,
    $core.double? p1Y,
    $core.double? p2X,
    $core.double? p2Y,
  }) {
    final _result = create();
    if (shapeProperties != null) {
      _result.shapeProperties = shapeProperties;
    }
    if (p1X != null) {
      _result.p1X = p1X;
    }
    if (p1Y != null) {
      _result.p1Y = p1Y;
    }
    if (p2X != null) {
      _result.p2X = p2X;
    }
    if (p2Y != null) {
      _result.p2Y = p2Y;
    }
    return _result;
  }
  factory Paint_DrawLine.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Paint_DrawLine.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Paint_DrawLine clone() => Paint_DrawLine()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Paint_DrawLine copyWith(void Function(Paint_DrawLine) updates) => super.copyWith((message) => updates(message as Paint_DrawLine)) as Paint_DrawLine; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Paint_DrawLine create() => Paint_DrawLine._();
  Paint_DrawLine createEmptyInstance() => create();
  static $pb.PbList<Paint_DrawLine> createRepeated() => $pb.PbList<Paint_DrawLine>();
  @$core.pragma('dart2js:noInline')
  static Paint_DrawLine getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Paint_DrawLine>(create);
  static Paint_DrawLine? _defaultInstance;

  @$pb.TagNumber(1)
  Paint_DrawShape get shapeProperties => $_getN(0);
  @$pb.TagNumber(1)
  set shapeProperties(Paint_DrawShape v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasShapeProperties() => $_has(0);
  @$pb.TagNumber(1)
  void clearShapeProperties() => clearField(1);
  @$pb.TagNumber(1)
  Paint_DrawShape ensureShapeProperties() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get p1X => $_getN(1);
  @$pb.TagNumber(2)
  set p1X($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasP1X() => $_has(1);
  @$pb.TagNumber(2)
  void clearP1X() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get p1Y => $_getN(2);
  @$pb.TagNumber(3)
  set p1Y($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasP1Y() => $_has(2);
  @$pb.TagNumber(3)
  void clearP1Y() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get p2X => $_getN(3);
  @$pb.TagNumber(4)
  set p2X($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasP2X() => $_has(3);
  @$pb.TagNumber(4)
  void clearP2X() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get p2Y => $_getN(4);
  @$pb.TagNumber(5)
  set p2Y($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasP2Y() => $_has(4);
  @$pb.TagNumber(5)
  void clearP2Y() => clearField(5);
}

class Paint_DrawPoints extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Paint.DrawPoints', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOM<Paint_DrawShape>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'shapeProperties', subBuilder: Paint_DrawShape.create)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'positionX', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'positionY', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  Paint_DrawPoints._() : super();
  factory Paint_DrawPoints({
    Paint_DrawShape? shapeProperties,
    $core.double? positionX,
    $core.double? positionY,
  }) {
    final _result = create();
    if (shapeProperties != null) {
      _result.shapeProperties = shapeProperties;
    }
    if (positionX != null) {
      _result.positionX = positionX;
    }
    if (positionY != null) {
      _result.positionY = positionY;
    }
    return _result;
  }
  factory Paint_DrawPoints.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Paint_DrawPoints.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Paint_DrawPoints clone() => Paint_DrawPoints()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Paint_DrawPoints copyWith(void Function(Paint_DrawPoints) updates) => super.copyWith((message) => updates(message as Paint_DrawPoints)) as Paint_DrawPoints; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Paint_DrawPoints create() => Paint_DrawPoints._();
  Paint_DrawPoints createEmptyInstance() => create();
  static $pb.PbList<Paint_DrawPoints> createRepeated() => $pb.PbList<Paint_DrawPoints>();
  @$core.pragma('dart2js:noInline')
  static Paint_DrawPoints getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Paint_DrawPoints>(create);
  static Paint_DrawPoints? _defaultInstance;

  @$pb.TagNumber(1)
  Paint_DrawShape get shapeProperties => $_getN(0);
  @$pb.TagNumber(1)
  set shapeProperties(Paint_DrawShape v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasShapeProperties() => $_has(0);
  @$pb.TagNumber(1)
  void clearShapeProperties() => clearField(1);
  @$pb.TagNumber(1)
  Paint_DrawShape ensureShapeProperties() => $_ensure(0);

  @$pb.TagNumber(4)
  $core.double get positionX => $_getN(1);
  @$pb.TagNumber(4)
  set positionX($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(4)
  $core.bool hasPositionX() => $_has(1);
  @$pb.TagNumber(4)
  void clearPositionX() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get positionY => $_getN(2);
  @$pb.TagNumber(5)
  set positionY($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(5)
  $core.bool hasPositionY() => $_has(2);
  @$pb.TagNumber(5)
  void clearPositionY() => clearField(5);
}

class Paint_DrawText extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Paint.DrawText', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOM<Paint_DrawShape>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'shapeProperties', subBuilder: Paint_DrawShape.create)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'positionX', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'positionY', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  Paint_DrawText._() : super();
  factory Paint_DrawText({
    Paint_DrawShape? shapeProperties,
    $core.double? positionX,
    $core.double? positionY,
  }) {
    final _result = create();
    if (shapeProperties != null) {
      _result.shapeProperties = shapeProperties;
    }
    if (positionX != null) {
      _result.positionX = positionX;
    }
    if (positionY != null) {
      _result.positionY = positionY;
    }
    return _result;
  }
  factory Paint_DrawText.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Paint_DrawText.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Paint_DrawText clone() => Paint_DrawText()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Paint_DrawText copyWith(void Function(Paint_DrawText) updates) => super.copyWith((message) => updates(message as Paint_DrawText)) as Paint_DrawText; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Paint_DrawText create() => Paint_DrawText._();
  Paint_DrawText createEmptyInstance() => create();
  static $pb.PbList<Paint_DrawText> createRepeated() => $pb.PbList<Paint_DrawText>();
  @$core.pragma('dart2js:noInline')
  static Paint_DrawText getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Paint_DrawText>(create);
  static Paint_DrawText? _defaultInstance;

  @$pb.TagNumber(1)
  Paint_DrawShape get shapeProperties => $_getN(0);
  @$pb.TagNumber(1)
  set shapeProperties(Paint_DrawShape v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasShapeProperties() => $_has(0);
  @$pb.TagNumber(1)
  void clearShapeProperties() => clearField(1);
  @$pb.TagNumber(1)
  Paint_DrawShape ensureShapeProperties() => $_ensure(0);

  @$pb.TagNumber(4)
  $core.double get positionX => $_getN(1);
  @$pb.TagNumber(4)
  set positionX($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(4)
  $core.bool hasPositionX() => $_has(1);
  @$pb.TagNumber(4)
  void clearPositionX() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get positionY => $_getN(2);
  @$pb.TagNumber(5)
  set positionY($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(5)
  $core.bool hasPositionY() => $_has(2);
  @$pb.TagNumber(5)
  void clearPositionY() => clearField(5);
}

class Paint_Clear extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Paint.Clear', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  Paint_Clear._() : super();
  factory Paint_Clear() => create();
  factory Paint_Clear.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Paint_Clear.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Paint_Clear clone() => Paint_Clear()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Paint_Clear copyWith(void Function(Paint_Clear) updates) => super.copyWith((message) => updates(message as Paint_Clear)) as Paint_Clear; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Paint_Clear create() => Paint_Clear._();
  Paint_Clear createEmptyInstance() => create();
  static $pb.PbList<Paint_Clear> createRepeated() => $pb.PbList<Paint_Clear>();
  @$core.pragma('dart2js:noInline')
  static Paint_Clear getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Paint_Clear>(create);
  static Paint_Clear? _defaultInstance;
}

class Paint_EditText extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Paint.EditText', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'text')
    ..hasRequiredFields = false
  ;

  Paint_EditText._() : super();
  factory Paint_EditText({
    $core.String? id,
    $core.String? text,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (text != null) {
      _result.text = text;
    }
    return _result;
  }
  factory Paint_EditText.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Paint_EditText.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Paint_EditText clone() => Paint_EditText()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Paint_EditText copyWith(void Function(Paint_EditText) updates) => super.copyWith((message) => updates(message as Paint_EditText)) as Paint_EditText; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Paint_EditText create() => Paint_EditText._();
  Paint_EditText createEmptyInstance() => create();
  static $pb.PbList<Paint_EditText> createRepeated() => $pb.PbList<Paint_EditText>();
  @$core.pragma('dart2js:noInline')
  static Paint_EditText getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Paint_EditText>(create);
  static Paint_EditText? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get text => $_getSZ(1);
  @$pb.TagNumber(2)
  set text($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasText() => $_has(1);
  @$pb.TagNumber(2)
  void clearText() => clearField(2);
}

enum Paint_Action {
  selectionRectangle, 
  selectionCircle, 
  selectionLine, 
  selectionText, 
  drawRectangle, 
  drawCircle, 
  drawLine, 
  drawPoints, 
  drawText, 
  clearAll, 
  editText, 
  notSet
}

class Paint extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Paint_Action> _Paint_ActionByTag = {
    1 : Paint_Action.selectionRectangle,
    2 : Paint_Action.selectionCircle,
    3 : Paint_Action.selectionLine,
    4 : Paint_Action.selectionText,
    5 : Paint_Action.drawRectangle,
    6 : Paint_Action.drawCircle,
    7 : Paint_Action.drawLine,
    8 : Paint_Action.drawPoints,
    9 : Paint_Action.drawText,
    10 : Paint_Action.clearAll,
    11 : Paint_Action.editText,
    0 : Paint_Action.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Paint', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11])
    ..aOM<Paint_SelectionRectangle>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'selectionRectangle', subBuilder: Paint_SelectionRectangle.create)
    ..aOM<Paint_SelectionCircle>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'selectionCircle', subBuilder: Paint_SelectionCircle.create)
    ..aOM<Paint_SelectionLine>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'selectionLine', subBuilder: Paint_SelectionLine.create)
    ..aOM<Paint_SelectionText>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'selectionText', subBuilder: Paint_SelectionText.create)
    ..aOM<Paint_DrawRectangle>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'drawRectangle', subBuilder: Paint_DrawRectangle.create)
    ..aOM<Paint_DrawCircle>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'drawCircle', subBuilder: Paint_DrawCircle.create)
    ..aOM<Paint_DrawLine>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'drawLine', subBuilder: Paint_DrawLine.create)
    ..aOM<Paint_DrawPoints>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'drawPoints', subBuilder: Paint_DrawPoints.create)
    ..aOM<Paint_DrawText>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'drawText', subBuilder: Paint_DrawText.create)
    ..aOM<Paint_Clear>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'clearAll', subBuilder: Paint_Clear.create)
    ..aOM<Paint_EditText>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'editText', subBuilder: Paint_EditText.create)
    ..hasRequiredFields = false
  ;

  Paint._() : super();
  factory Paint({
    Paint_SelectionRectangle? selectionRectangle,
    Paint_SelectionCircle? selectionCircle,
    Paint_SelectionLine? selectionLine,
    Paint_SelectionText? selectionText,
    Paint_DrawRectangle? drawRectangle,
    Paint_DrawCircle? drawCircle,
    Paint_DrawLine? drawLine,
    Paint_DrawPoints? drawPoints,
    Paint_DrawText? drawText,
    Paint_Clear? clearAll,
    Paint_EditText? editText,
  }) {
    final _result = create();
    if (selectionRectangle != null) {
      _result.selectionRectangle = selectionRectangle;
    }
    if (selectionCircle != null) {
      _result.selectionCircle = selectionCircle;
    }
    if (selectionLine != null) {
      _result.selectionLine = selectionLine;
    }
    if (selectionText != null) {
      _result.selectionText = selectionText;
    }
    if (drawRectangle != null) {
      _result.drawRectangle = drawRectangle;
    }
    if (drawCircle != null) {
      _result.drawCircle = drawCircle;
    }
    if (drawLine != null) {
      _result.drawLine = drawLine;
    }
    if (drawPoints != null) {
      _result.drawPoints = drawPoints;
    }
    if (drawText != null) {
      _result.drawText = drawText;
    }
    if (clearAll != null) {
      _result.clearAll = clearAll;
    }
    if (editText != null) {
      _result.editText = editText;
    }
    return _result;
  }
  factory Paint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Paint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Paint clone() => Paint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Paint copyWith(void Function(Paint) updates) => super.copyWith((message) => updates(message as Paint)) as Paint; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Paint create() => Paint._();
  Paint createEmptyInstance() => create();
  static $pb.PbList<Paint> createRepeated() => $pb.PbList<Paint>();
  @$core.pragma('dart2js:noInline')
  static Paint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Paint>(create);
  static Paint? _defaultInstance;

  Paint_Action whichAction() => _Paint_ActionByTag[$_whichOneof(0)]!;
  void clearAction() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Paint_SelectionRectangle get selectionRectangle => $_getN(0);
  @$pb.TagNumber(1)
  set selectionRectangle(Paint_SelectionRectangle v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSelectionRectangle() => $_has(0);
  @$pb.TagNumber(1)
  void clearSelectionRectangle() => clearField(1);
  @$pb.TagNumber(1)
  Paint_SelectionRectangle ensureSelectionRectangle() => $_ensure(0);

  @$pb.TagNumber(2)
  Paint_SelectionCircle get selectionCircle => $_getN(1);
  @$pb.TagNumber(2)
  set selectionCircle(Paint_SelectionCircle v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSelectionCircle() => $_has(1);
  @$pb.TagNumber(2)
  void clearSelectionCircle() => clearField(2);
  @$pb.TagNumber(2)
  Paint_SelectionCircle ensureSelectionCircle() => $_ensure(1);

  @$pb.TagNumber(3)
  Paint_SelectionLine get selectionLine => $_getN(2);
  @$pb.TagNumber(3)
  set selectionLine(Paint_SelectionLine v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSelectionLine() => $_has(2);
  @$pb.TagNumber(3)
  void clearSelectionLine() => clearField(3);
  @$pb.TagNumber(3)
  Paint_SelectionLine ensureSelectionLine() => $_ensure(2);

  @$pb.TagNumber(4)
  Paint_SelectionText get selectionText => $_getN(3);
  @$pb.TagNumber(4)
  set selectionText(Paint_SelectionText v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasSelectionText() => $_has(3);
  @$pb.TagNumber(4)
  void clearSelectionText() => clearField(4);
  @$pb.TagNumber(4)
  Paint_SelectionText ensureSelectionText() => $_ensure(3);

  @$pb.TagNumber(5)
  Paint_DrawRectangle get drawRectangle => $_getN(4);
  @$pb.TagNumber(5)
  set drawRectangle(Paint_DrawRectangle v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasDrawRectangle() => $_has(4);
  @$pb.TagNumber(5)
  void clearDrawRectangle() => clearField(5);
  @$pb.TagNumber(5)
  Paint_DrawRectangle ensureDrawRectangle() => $_ensure(4);

  @$pb.TagNumber(6)
  Paint_DrawCircle get drawCircle => $_getN(5);
  @$pb.TagNumber(6)
  set drawCircle(Paint_DrawCircle v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasDrawCircle() => $_has(5);
  @$pb.TagNumber(6)
  void clearDrawCircle() => clearField(6);
  @$pb.TagNumber(6)
  Paint_DrawCircle ensureDrawCircle() => $_ensure(5);

  @$pb.TagNumber(7)
  Paint_DrawLine get drawLine => $_getN(6);
  @$pb.TagNumber(7)
  set drawLine(Paint_DrawLine v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasDrawLine() => $_has(6);
  @$pb.TagNumber(7)
  void clearDrawLine() => clearField(7);
  @$pb.TagNumber(7)
  Paint_DrawLine ensureDrawLine() => $_ensure(6);

  @$pb.TagNumber(8)
  Paint_DrawPoints get drawPoints => $_getN(7);
  @$pb.TagNumber(8)
  set drawPoints(Paint_DrawPoints v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasDrawPoints() => $_has(7);
  @$pb.TagNumber(8)
  void clearDrawPoints() => clearField(8);
  @$pb.TagNumber(8)
  Paint_DrawPoints ensureDrawPoints() => $_ensure(7);

  @$pb.TagNumber(9)
  Paint_DrawText get drawText => $_getN(8);
  @$pb.TagNumber(9)
  set drawText(Paint_DrawText v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasDrawText() => $_has(8);
  @$pb.TagNumber(9)
  void clearDrawText() => clearField(9);
  @$pb.TagNumber(9)
  Paint_DrawText ensureDrawText() => $_ensure(8);

  @$pb.TagNumber(10)
  Paint_Clear get clearAll => $_getN(9);
  @$pb.TagNumber(10)
  set clearAll(Paint_Clear v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasClearAll() => $_has(9);
  @$pb.TagNumber(10)
  void clearClearAll() => clearField(10);
  @$pb.TagNumber(10)
  Paint_Clear ensureClearAll() => $_ensure(9);

  @$pb.TagNumber(11)
  Paint_EditText get editText => $_getN(10);
  @$pb.TagNumber(11)
  set editText(Paint_EditText v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasEditText() => $_has(10);
  @$pb.TagNumber(11)
  void clearEditText() => clearField(11);
  @$pb.TagNumber(11)
  Paint_EditText ensureEditText() => $_ensure(10);
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

