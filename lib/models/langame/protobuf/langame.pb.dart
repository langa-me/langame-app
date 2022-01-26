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

class Error extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Error', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'developerMessage', protoName: 'developerMessage')
    ..aOM<$0.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', protoName: 'createdAt', subBuilder: $0.Timestamp.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userMessage', protoName: 'userMessage')
    ..hasRequiredFields = false
  ;

  Error._() : super();
  factory Error({
    $core.String? developerMessage,
    $0.Timestamp? createdAt,
    $core.String? code,
    $core.String? userMessage,
  }) {
    final _result = create();
    if (developerMessage != null) {
      _result.developerMessage = developerMessage;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (code != null) {
      _result.code = code;
    }
    if (userMessage != null) {
      _result.userMessage = userMessage;
    }
    return _result;
  }
  factory Error.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Error.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Error clone() => Error()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Error copyWith(void Function(Error) updates) => super.copyWith((message) => updates(message as Error)) as Error; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Error create() => Error._();
  Error createEmptyInstance() => create();
  static $pb.PbList<Error> createRepeated() => $pb.PbList<Error>();
  @$core.pragma('dart2js:noInline')
  static Error getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Error>(create);
  static Error? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get developerMessage => $_getSZ(0);
  @$pb.TagNumber(1)
  set developerMessage($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDeveloperMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeveloperMessage() => clearField(1);

  @$pb.TagNumber(2)
  $0.Timestamp get createdAt => $_getN(1);
  @$pb.TagNumber(2)
  set createdAt($0.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCreatedAt() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreatedAt() => clearField(2);
  @$pb.TagNumber(2)
  $0.Timestamp ensureCreatedAt() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get code => $_getSZ(2);
  @$pb.TagNumber(3)
  set code($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCode() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get userMessage => $_getSZ(3);
  @$pb.TagNumber(4)
  set userMessage($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUserMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserMessage() => clearField(4);
}

class SeenMemes_Seen_Single extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SeenMemes.Seen.Single', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOM<$0.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'date', subBuilder: $0.Timestamp.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'meme')
    ..hasRequiredFields = false
  ;

  SeenMemes_Seen_Single._() : super();
  factory SeenMemes_Seen_Single({
    $0.Timestamp? date,
    $core.String? meme,
  }) {
    final _result = create();
    if (date != null) {
      _result.date = date;
    }
    if (meme != null) {
      _result.meme = meme;
    }
    return _result;
  }
  factory SeenMemes_Seen_Single.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SeenMemes_Seen_Single.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SeenMemes_Seen_Single clone() => SeenMemes_Seen_Single()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SeenMemes_Seen_Single copyWith(void Function(SeenMemes_Seen_Single) updates) => super.copyWith((message) => updates(message as SeenMemes_Seen_Single)) as SeenMemes_Seen_Single; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SeenMemes_Seen_Single create() => SeenMemes_Seen_Single._();
  SeenMemes_Seen_Single createEmptyInstance() => create();
  static $pb.PbList<SeenMemes_Seen_Single> createRepeated() => $pb.PbList<SeenMemes_Seen_Single>();
  @$core.pragma('dart2js:noInline')
  static SeenMemes_Seen_Single getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SeenMemes_Seen_Single>(create);
  static SeenMemes_Seen_Single? _defaultInstance;

  @$pb.TagNumber(1)
  $0.Timestamp get date => $_getN(0);
  @$pb.TagNumber(1)
  set date($0.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearDate() => clearField(1);
  @$pb.TagNumber(1)
  $0.Timestamp ensureDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get meme => $_getSZ(1);
  @$pb.TagNumber(2)
  set meme($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMeme() => $_has(1);
  @$pb.TagNumber(2)
  void clearMeme() => clearField(2);
}

class SeenMemes_Seen extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SeenMemes.Seen', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..pc<SeenMemes_Seen_Single>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 's', $pb.PbFieldType.PM, subBuilder: SeenMemes_Seen_Single.create)
    ..hasRequiredFields = false
  ;

  SeenMemes_Seen._() : super();
  factory SeenMemes_Seen({
    $core.Iterable<SeenMemes_Seen_Single>? s,
  }) {
    final _result = create();
    if (s != null) {
      _result.s.addAll(s);
    }
    return _result;
  }
  factory SeenMemes_Seen.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SeenMemes_Seen.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SeenMemes_Seen clone() => SeenMemes_Seen()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SeenMemes_Seen copyWith(void Function(SeenMemes_Seen) updates) => super.copyWith((message) => updates(message as SeenMemes_Seen)) as SeenMemes_Seen; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SeenMemes_Seen create() => SeenMemes_Seen._();
  SeenMemes_Seen createEmptyInstance() => create();
  static $pb.PbList<SeenMemes_Seen> createRepeated() => $pb.PbList<SeenMemes_Seen>();
  @$core.pragma('dart2js:noInline')
  static SeenMemes_Seen getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SeenMemes_Seen>(create);
  static SeenMemes_Seen? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SeenMemes_Seen_Single> get s => $_getList(0);
}

class SeenMemes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SeenMemes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOM<SeenMemes_Seen>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'seen', subBuilder: SeenMemes_Seen.create)
    ..hasRequiredFields = false
  ;

  SeenMemes._() : super();
  factory SeenMemes({
    SeenMemes_Seen? seen,
  }) {
    final _result = create();
    if (seen != null) {
      _result.seen = seen;
    }
    return _result;
  }
  factory SeenMemes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SeenMemes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SeenMemes clone() => SeenMemes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SeenMemes copyWith(void Function(SeenMemes) updates) => super.copyWith((message) => updates(message as SeenMemes)) as SeenMemes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SeenMemes create() => SeenMemes._();
  SeenMemes createEmptyInstance() => create();
  static $pb.PbList<SeenMemes> createRepeated() => $pb.PbList<SeenMemes>();
  @$core.pragma('dart2js:noInline')
  static SeenMemes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SeenMemes>(create);
  static SeenMemes? _defaultInstance;

  @$pb.TagNumber(1)
  SeenMemes_Seen get seen => $_getN(0);
  @$pb.TagNumber(1)
  set seen(SeenMemes_Seen v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSeen() => $_has(0);
  @$pb.TagNumber(1)
  void clearSeen() => clearField(1);
  @$pb.TagNumber(1)
  SeenMemes_Seen ensureSeen() => $_ensure(0);
}

class Meme extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Meme', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOM<$0.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $0.Timestamp.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'content')
    ..pPS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topics')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'promptId')
    ..m<$core.String, $core.String>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'translated', entryClassName: 'Meme.TranslatedEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('langame.protobuf'))
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'disabled')
    ..aOB(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tweet')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'error')
    ..hasRequiredFields = false
  ;

  Meme._() : super();
  factory Meme({
    $0.Timestamp? createdAt,
    $core.String? content,
    $core.Iterable<$core.String>? topics,
    $core.String? promptId,
    $core.Map<$core.String, $core.String>? translated,
    $core.String? id,
    $core.bool? disabled,
    $core.bool? tweet,
    $core.String? state,
    $core.String? error,
  }) {
    final _result = create();
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (content != null) {
      _result.content = content;
    }
    if (topics != null) {
      _result.topics.addAll(topics);
    }
    if (promptId != null) {
      _result.promptId = promptId;
    }
    if (translated != null) {
      _result.translated.addAll(translated);
    }
    if (id != null) {
      _result.id = id;
    }
    if (disabled != null) {
      _result.disabled = disabled;
    }
    if (tweet != null) {
      _result.tweet = tweet;
    }
    if (state != null) {
      _result.state = state;
    }
    if (error != null) {
      _result.error = error;
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
  $core.List<$core.String> get topics => $_getList(2);

  @$pb.TagNumber(5)
  $core.String get promptId => $_getSZ(3);
  @$pb.TagNumber(5)
  set promptId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasPromptId() => $_has(3);
  @$pb.TagNumber(5)
  void clearPromptId() => clearField(5);

  @$pb.TagNumber(6)
  $core.Map<$core.String, $core.String> get translated => $_getMap(4);

  @$pb.TagNumber(7)
  $core.String get id => $_getSZ(5);
  @$pb.TagNumber(7)
  set id($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasId() => $_has(5);
  @$pb.TagNumber(7)
  void clearId() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get disabled => $_getBF(6);
  @$pb.TagNumber(8)
  set disabled($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasDisabled() => $_has(6);
  @$pb.TagNumber(8)
  void clearDisabled() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get tweet => $_getBF(7);
  @$pb.TagNumber(9)
  set tweet($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasTweet() => $_has(7);
  @$pb.TagNumber(9)
  void clearTweet() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get state => $_getSZ(8);
  @$pb.TagNumber(10)
  set state($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(10)
  $core.bool hasState() => $_has(8);
  @$pb.TagNumber(10)
  void clearState() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get error => $_getSZ(9);
  @$pb.TagNumber(11)
  set error($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(11)
  $core.bool hasError() => $_has(9);
  @$pb.TagNumber(11)
  void clearError() => clearField(11);
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
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tag')
    ..pPS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tokens')
    ..pPS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'latestInteractions')
    ..pc<Error>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errors', $pb.PbFieldType.PM, subBuilder: Error.create)
    ..aOM<$0.Timestamp>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastLogin', subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastLogout', subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creationTime', subBuilder: $0.Timestamp.create)
    ..aOB(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'disabled')
    ..pc<User_Device>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'devices', $pb.PbFieldType.PM, subBuilder: User_Device.create)
    ..a<$core.int>(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'credits', $pb.PbFieldType.O3)
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'role')
    ..aOB(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bot')
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
    $core.String? tag,
    $core.Iterable<$core.String>? tokens,
    $core.Iterable<$core.String>? latestInteractions,
    $core.Iterable<Error>? errors,
    $0.Timestamp? lastLogin,
    $0.Timestamp? lastLogout,
    $0.Timestamp? creationTime,
    $core.bool? disabled,
    $core.Iterable<User_Device>? devices,
    $core.int? credits,
    $core.String? role,
    $core.bool? bot,
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
    if (credits != null) {
      _result.credits = credits;
    }
    if (role != null) {
      _result.role = role;
    }
    if (bot != null) {
      _result.bot = bot;
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

  @$pb.TagNumber(11)
  $core.String get tag => $_getSZ(8);
  @$pb.TagNumber(11)
  set tag($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(11)
  $core.bool hasTag() => $_has(8);
  @$pb.TagNumber(11)
  void clearTag() => clearField(11);

  @$pb.TagNumber(12)
  $core.List<$core.String> get tokens => $_getList(9);

  @$pb.TagNumber(13)
  $core.List<$core.String> get latestInteractions => $_getList(10);

  @$pb.TagNumber(14)
  $core.List<Error> get errors => $_getList(11);

  @$pb.TagNumber(15)
  $0.Timestamp get lastLogin => $_getN(12);
  @$pb.TagNumber(15)
  set lastLogin($0.Timestamp v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasLastLogin() => $_has(12);
  @$pb.TagNumber(15)
  void clearLastLogin() => clearField(15);
  @$pb.TagNumber(15)
  $0.Timestamp ensureLastLogin() => $_ensure(12);

  @$pb.TagNumber(16)
  $0.Timestamp get lastLogout => $_getN(13);
  @$pb.TagNumber(16)
  set lastLogout($0.Timestamp v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasLastLogout() => $_has(13);
  @$pb.TagNumber(16)
  void clearLastLogout() => clearField(16);
  @$pb.TagNumber(16)
  $0.Timestamp ensureLastLogout() => $_ensure(13);

  @$pb.TagNumber(17)
  $0.Timestamp get creationTime => $_getN(14);
  @$pb.TagNumber(17)
  set creationTime($0.Timestamp v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasCreationTime() => $_has(14);
  @$pb.TagNumber(17)
  void clearCreationTime() => clearField(17);
  @$pb.TagNumber(17)
  $0.Timestamp ensureCreationTime() => $_ensure(14);

  @$pb.TagNumber(18)
  $core.bool get disabled => $_getBF(15);
  @$pb.TagNumber(18)
  set disabled($core.bool v) { $_setBool(15, v); }
  @$pb.TagNumber(18)
  $core.bool hasDisabled() => $_has(15);
  @$pb.TagNumber(18)
  void clearDisabled() => clearField(18);

  @$pb.TagNumber(19)
  $core.List<User_Device> get devices => $_getList(16);

  @$pb.TagNumber(20)
  $core.int get credits => $_getIZ(17);
  @$pb.TagNumber(20)
  set credits($core.int v) { $_setSignedInt32(17, v); }
  @$pb.TagNumber(20)
  $core.bool hasCredits() => $_has(17);
  @$pb.TagNumber(20)
  void clearCredits() => clearField(20);

  @$pb.TagNumber(21)
  $core.String get role => $_getSZ(18);
  @$pb.TagNumber(21)
  set role($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(21)
  $core.bool hasRole() => $_has(18);
  @$pb.TagNumber(21)
  void clearRole() => clearField(21);

  @$pb.TagNumber(22)
  $core.bool get bot => $_getBF(19);
  @$pb.TagNumber(22)
  set bot($core.bool v) { $_setBool(19, v); }
  @$pb.TagNumber(22)
  $core.bool hasBot() => $_has(19);
  @$pb.TagNumber(22)
  void clearBot() => clearField(22);
}

class UserPreference_Notification_Invite extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UserPreference.Notification.Invite', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'push')
    ..hasRequiredFields = false
  ;

  UserPreference_Notification_Invite._() : super();
  factory UserPreference_Notification_Invite({
    $core.bool? email,
    $core.bool? push,
  }) {
    final _result = create();
    if (email != null) {
      _result.email = email;
    }
    if (push != null) {
      _result.push = push;
    }
    return _result;
  }
  factory UserPreference_Notification_Invite.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserPreference_Notification_Invite.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserPreference_Notification_Invite clone() => UserPreference_Notification_Invite()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserPreference_Notification_Invite copyWith(void Function(UserPreference_Notification_Invite) updates) => super.copyWith((message) => updates(message as UserPreference_Notification_Invite)) as UserPreference_Notification_Invite; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserPreference_Notification_Invite create() => UserPreference_Notification_Invite._();
  UserPreference_Notification_Invite createEmptyInstance() => create();
  static $pb.PbList<UserPreference_Notification_Invite> createRepeated() => $pb.PbList<UserPreference_Notification_Invite>();
  @$core.pragma('dart2js:noInline')
  static UserPreference_Notification_Invite getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserPreference_Notification_Invite>(create);
  static UserPreference_Notification_Invite? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get email => $_getBF(0);
  @$pb.TagNumber(1)
  set email($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get push => $_getBF(1);
  @$pb.TagNumber(2)
  set push($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPush() => $_has(1);
  @$pb.TagNumber(2)
  void clearPush() => clearField(2);
}

class UserPreference_Notification_Message extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UserPreference.Notification.Message', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'push')
    ..hasRequiredFields = false
  ;

  UserPreference_Notification_Message._() : super();
  factory UserPreference_Notification_Message({
    $core.bool? email,
    $core.bool? push,
  }) {
    final _result = create();
    if (email != null) {
      _result.email = email;
    }
    if (push != null) {
      _result.push = push;
    }
    return _result;
  }
  factory UserPreference_Notification_Message.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserPreference_Notification_Message.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserPreference_Notification_Message clone() => UserPreference_Notification_Message()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserPreference_Notification_Message copyWith(void Function(UserPreference_Notification_Message) updates) => super.copyWith((message) => updates(message as UserPreference_Notification_Message)) as UserPreference_Notification_Message; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserPreference_Notification_Message create() => UserPreference_Notification_Message._();
  UserPreference_Notification_Message createEmptyInstance() => create();
  static $pb.PbList<UserPreference_Notification_Message> createRepeated() => $pb.PbList<UserPreference_Notification_Message>();
  @$core.pragma('dart2js:noInline')
  static UserPreference_Notification_Message getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserPreference_Notification_Message>(create);
  static UserPreference_Notification_Message? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get email => $_getBF(0);
  @$pb.TagNumber(1)
  set email($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get push => $_getBF(1);
  @$pb.TagNumber(2)
  set push($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPush() => $_has(1);
  @$pb.TagNumber(2)
  void clearPush() => clearField(2);
}

class UserPreference_Notification_NewVersion extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UserPreference.Notification.NewVersion', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'push')
    ..hasRequiredFields = false
  ;

  UserPreference_Notification_NewVersion._() : super();
  factory UserPreference_Notification_NewVersion({
    $core.bool? email,
    $core.bool? push,
  }) {
    final _result = create();
    if (email != null) {
      _result.email = email;
    }
    if (push != null) {
      _result.push = push;
    }
    return _result;
  }
  factory UserPreference_Notification_NewVersion.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserPreference_Notification_NewVersion.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserPreference_Notification_NewVersion clone() => UserPreference_Notification_NewVersion()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserPreference_Notification_NewVersion copyWith(void Function(UserPreference_Notification_NewVersion) updates) => super.copyWith((message) => updates(message as UserPreference_Notification_NewVersion)) as UserPreference_Notification_NewVersion; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserPreference_Notification_NewVersion create() => UserPreference_Notification_NewVersion._();
  UserPreference_Notification_NewVersion createEmptyInstance() => create();
  static $pb.PbList<UserPreference_Notification_NewVersion> createRepeated() => $pb.PbList<UserPreference_Notification_NewVersion>();
  @$core.pragma('dart2js:noInline')
  static UserPreference_Notification_NewVersion getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserPreference_Notification_NewVersion>(create);
  static UserPreference_Notification_NewVersion? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get email => $_getBF(0);
  @$pb.TagNumber(1)
  set email($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get push => $_getBF(1);
  @$pb.TagNumber(2)
  set push($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPush() => $_has(1);
  @$pb.TagNumber(2)
  void clearPush() => clearField(2);
}

class UserPreference_Notification extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UserPreference.Notification', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOM<UserPreference_Notification_Invite>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invite', subBuilder: UserPreference_Notification_Invite.create)
    ..aOM<UserPreference_Notification_Message>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message', subBuilder: UserPreference_Notification_Message.create)
    ..aOM<UserPreference_Notification_NewVersion>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newVersion', subBuilder: UserPreference_Notification_NewVersion.create)
    ..hasRequiredFields = false
  ;

  UserPreference_Notification._() : super();
  factory UserPreference_Notification({
    UserPreference_Notification_Invite? invite,
    UserPreference_Notification_Message? message,
    UserPreference_Notification_NewVersion? newVersion,
  }) {
    final _result = create();
    if (invite != null) {
      _result.invite = invite;
    }
    if (message != null) {
      _result.message = message;
    }
    if (newVersion != null) {
      _result.newVersion = newVersion;
    }
    return _result;
  }
  factory UserPreference_Notification.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserPreference_Notification.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserPreference_Notification clone() => UserPreference_Notification()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserPreference_Notification copyWith(void Function(UserPreference_Notification) updates) => super.copyWith((message) => updates(message as UserPreference_Notification)) as UserPreference_Notification; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserPreference_Notification create() => UserPreference_Notification._();
  UserPreference_Notification createEmptyInstance() => create();
  static $pb.PbList<UserPreference_Notification> createRepeated() => $pb.PbList<UserPreference_Notification>();
  @$core.pragma('dart2js:noInline')
  static UserPreference_Notification getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserPreference_Notification>(create);
  static UserPreference_Notification? _defaultInstance;

  @$pb.TagNumber(1)
  UserPreference_Notification_Invite get invite => $_getN(0);
  @$pb.TagNumber(1)
  set invite(UserPreference_Notification_Invite v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvite() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvite() => clearField(1);
  @$pb.TagNumber(1)
  UserPreference_Notification_Invite ensureInvite() => $_ensure(0);

  @$pb.TagNumber(2)
  UserPreference_Notification_Message get message => $_getN(1);
  @$pb.TagNumber(2)
  set message(UserPreference_Notification_Message v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
  @$pb.TagNumber(2)
  UserPreference_Notification_Message ensureMessage() => $_ensure(1);

  @$pb.TagNumber(3)
  UserPreference_Notification_NewVersion get newVersion => $_getN(2);
  @$pb.TagNumber(3)
  set newVersion(UserPreference_Notification_NewVersion v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasNewVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewVersion() => clearField(3);
  @$pb.TagNumber(3)
  UserPreference_Notification_NewVersion ensureNewVersion() => $_ensure(2);
}

class UserPreference_Goals extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UserPreference.Goals', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'growRelationships')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'compoundRelationships')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'learn')
    ..hasRequiredFields = false
  ;

  UserPreference_Goals._() : super();
  factory UserPreference_Goals({
    $core.bool? growRelationships,
    $core.bool? compoundRelationships,
    $core.bool? learn,
  }) {
    final _result = create();
    if (growRelationships != null) {
      _result.growRelationships = growRelationships;
    }
    if (compoundRelationships != null) {
      _result.compoundRelationships = compoundRelationships;
    }
    if (learn != null) {
      _result.learn = learn;
    }
    return _result;
  }
  factory UserPreference_Goals.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserPreference_Goals.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserPreference_Goals clone() => UserPreference_Goals()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserPreference_Goals copyWith(void Function(UserPreference_Goals) updates) => super.copyWith((message) => updates(message as UserPreference_Goals)) as UserPreference_Goals; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserPreference_Goals create() => UserPreference_Goals._();
  UserPreference_Goals createEmptyInstance() => create();
  static $pb.PbList<UserPreference_Goals> createRepeated() => $pb.PbList<UserPreference_Goals>();
  @$core.pragma('dart2js:noInline')
  static UserPreference_Goals getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserPreference_Goals>(create);
  static UserPreference_Goals? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get growRelationships => $_getBF(0);
  @$pb.TagNumber(1)
  set growRelationships($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGrowRelationships() => $_has(0);
  @$pb.TagNumber(1)
  void clearGrowRelationships() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get compoundRelationships => $_getBF(1);
  @$pb.TagNumber(2)
  set compoundRelationships($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCompoundRelationships() => $_has(1);
  @$pb.TagNumber(2)
  void clearCompoundRelationships() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get learn => $_getBF(2);
  @$pb.TagNumber(3)
  set learn($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLearn() => $_has(2);
  @$pb.TagNumber(3)
  void clearLearn() => clearField(3);
}

class UserPreference extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UserPreference', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userRecommendations')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'themeIndex', $pb.PbFieldType.O3)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasDoneOnBoarding')
    ..pPS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userSearchHistory')
    ..pPS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'favoriteTopics')
    ..pPS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topicSearchHistory')
    ..pc<Error>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errors', $pb.PbFieldType.PM, subBuilder: Error.create)
    ..aOB(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sawWhatsNew')
    ..aOM<UserPreference_Notification>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notification', subBuilder: UserPreference_Notification.create)
    ..aOB(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'previewMode')
    ..aOM<UserPreference_Goals>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'goals', subBuilder: UserPreference_Goals.create)
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'langamesSubscriptionFrequency')
    ..hasRequiredFields = false
  ;

  UserPreference._() : super();
  factory UserPreference({
    $core.String? userId,
    $core.bool? userRecommendations,
    $core.int? themeIndex,
    $core.bool? hasDoneOnBoarding,
    $core.Iterable<$core.String>? userSearchHistory,
    $core.Iterable<$core.String>? favoriteTopics,
    $core.Iterable<$core.String>? topicSearchHistory,
    $core.Iterable<Error>? errors,
    $core.bool? sawWhatsNew,
    UserPreference_Notification? notification,
    $core.bool? previewMode,
    UserPreference_Goals? goals,
    $core.String? langamesSubscriptionFrequency,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (userRecommendations != null) {
      _result.userRecommendations = userRecommendations;
    }
    if (themeIndex != null) {
      _result.themeIndex = themeIndex;
    }
    if (hasDoneOnBoarding != null) {
      _result.hasDoneOnBoarding = hasDoneOnBoarding;
    }
    if (userSearchHistory != null) {
      _result.userSearchHistory.addAll(userSearchHistory);
    }
    if (favoriteTopics != null) {
      _result.favoriteTopics.addAll(favoriteTopics);
    }
    if (topicSearchHistory != null) {
      _result.topicSearchHistory.addAll(topicSearchHistory);
    }
    if (errors != null) {
      _result.errors.addAll(errors);
    }
    if (sawWhatsNew != null) {
      _result.sawWhatsNew = sawWhatsNew;
    }
    if (notification != null) {
      _result.notification = notification;
    }
    if (previewMode != null) {
      _result.previewMode = previewMode;
    }
    if (goals != null) {
      _result.goals = goals;
    }
    if (langamesSubscriptionFrequency != null) {
      _result.langamesSubscriptionFrequency = langamesSubscriptionFrequency;
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
  $core.bool get userRecommendations => $_getBF(1);
  @$pb.TagNumber(3)
  set userRecommendations($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserRecommendations() => $_has(1);
  @$pb.TagNumber(3)
  void clearUserRecommendations() => clearField(3);

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
  $core.List<$core.String> get userSearchHistory => $_getList(4);

  @$pb.TagNumber(8)
  $core.List<$core.String> get favoriteTopics => $_getList(5);

  @$pb.TagNumber(9)
  $core.List<$core.String> get topicSearchHistory => $_getList(6);

  @$pb.TagNumber(10)
  $core.List<Error> get errors => $_getList(7);

  @$pb.TagNumber(13)
  $core.bool get sawWhatsNew => $_getBF(8);
  @$pb.TagNumber(13)
  set sawWhatsNew($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(13)
  $core.bool hasSawWhatsNew() => $_has(8);
  @$pb.TagNumber(13)
  void clearSawWhatsNew() => clearField(13);

  @$pb.TagNumber(14)
  UserPreference_Notification get notification => $_getN(9);
  @$pb.TagNumber(14)
  set notification(UserPreference_Notification v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasNotification() => $_has(9);
  @$pb.TagNumber(14)
  void clearNotification() => clearField(14);
  @$pb.TagNumber(14)
  UserPreference_Notification ensureNotification() => $_ensure(9);

  @$pb.TagNumber(15)
  $core.bool get previewMode => $_getBF(10);
  @$pb.TagNumber(15)
  set previewMode($core.bool v) { $_setBool(10, v); }
  @$pb.TagNumber(15)
  $core.bool hasPreviewMode() => $_has(10);
  @$pb.TagNumber(15)
  void clearPreviewMode() => clearField(15);

  @$pb.TagNumber(16)
  UserPreference_Goals get goals => $_getN(11);
  @$pb.TagNumber(16)
  set goals(UserPreference_Goals v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasGoals() => $_has(11);
  @$pb.TagNumber(16)
  void clearGoals() => clearField(16);
  @$pb.TagNumber(16)
  UserPreference_Goals ensureGoals() => $_ensure(11);

  @$pb.TagNumber(17)
  $core.String get langamesSubscriptionFrequency => $_getSZ(12);
  @$pb.TagNumber(17)
  set langamesSubscriptionFrequency($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(17)
  $core.bool hasLangamesSubscriptionFrequency() => $_has(12);
  @$pb.TagNumber(17)
  void clearLangamesSubscriptionFrequency() => clearField(17);
}

class Langame_Player extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Langame.Player', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tag')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'photoUrl')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bot')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locale')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..hasRequiredFields = false
  ;

  Langame_Player._() : super();
  factory Langame_Player({
    $core.String? id,
    $core.String? tag,
    $core.String? photoUrl,
    $core.bool? bot,
    $core.String? locale,
    $core.String? email,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (tag != null) {
      _result.tag = tag;
    }
    if (photoUrl != null) {
      _result.photoUrl = photoUrl;
    }
    if (bot != null) {
      _result.bot = bot;
    }
    if (locale != null) {
      _result.locale = locale;
    }
    if (email != null) {
      _result.email = email;
    }
    return _result;
  }
  factory Langame_Player.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Langame_Player.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Langame_Player clone() => Langame_Player()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Langame_Player copyWith(void Function(Langame_Player) updates) => super.copyWith((message) => updates(message as Langame_Player)) as Langame_Player; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Langame_Player create() => Langame_Player._();
  Langame_Player createEmptyInstance() => create();
  static $pb.PbList<Langame_Player> createRepeated() => $pb.PbList<Langame_Player>();
  @$core.pragma('dart2js:noInline')
  static Langame_Player getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Langame_Player>(create);
  static Langame_Player? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get tag => $_getSZ(1);
  @$pb.TagNumber(2)
  set tag($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTag() => $_has(1);
  @$pb.TagNumber(2)
  void clearTag() => clearField(2);

  @$pb.TagNumber(4)
  $core.String get photoUrl => $_getSZ(2);
  @$pb.TagNumber(4)
  set photoUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasPhotoUrl() => $_has(2);
  @$pb.TagNumber(4)
  void clearPhotoUrl() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get bot => $_getBF(3);
  @$pb.TagNumber(5)
  set bot($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasBot() => $_has(3);
  @$pb.TagNumber(5)
  void clearBot() => clearField(5);

  @$pb.TagNumber(10)
  $core.String get locale => $_getSZ(4);
  @$pb.TagNumber(10)
  set locale($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(10)
  $core.bool hasLocale() => $_has(4);
  @$pb.TagNumber(10)
  void clearLocale() => clearField(10);

  @$pb.TagNumber(12)
  $core.String get email => $_getSZ(5);
  @$pb.TagNumber(12)
  set email($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(12)
  $core.bool hasEmail() => $_has(5);
  @$pb.TagNumber(12)
  void clearEmail() => clearField(12);
}

class Langame_Reflection extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Langame.Reflection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastMessageId')
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'alternatives')
    ..aOM<$0.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $0.Timestamp.create)
    ..e<ContentFilter>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contentFilter', $pb.PbFieldType.OE, defaultOrMaker: ContentFilter.Safe, valueOf: ContentFilter.valueOf, enumValues: ContentFilter.values)
    ..m<$core.String, $core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userFeedbacks', protoName: 'userFeedbacks', entryClassName: 'Langame.Reflection.UserFeedbacksEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OU3, packageName: const $pb.PackageName('langame.protobuf'))
    ..hasRequiredFields = false
  ;

  Langame_Reflection._() : super();
  factory Langame_Reflection({
    $core.String? userId,
    $core.String? lastMessageId,
    $core.Iterable<$core.String>? alternatives,
    $0.Timestamp? createdAt,
    ContentFilter? contentFilter,
    $core.Map<$core.String, $core.int>? userFeedbacks,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (lastMessageId != null) {
      _result.lastMessageId = lastMessageId;
    }
    if (alternatives != null) {
      _result.alternatives.addAll(alternatives);
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (contentFilter != null) {
      _result.contentFilter = contentFilter;
    }
    if (userFeedbacks != null) {
      _result.userFeedbacks.addAll(userFeedbacks);
    }
    return _result;
  }
  factory Langame_Reflection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Langame_Reflection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Langame_Reflection clone() => Langame_Reflection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Langame_Reflection copyWith(void Function(Langame_Reflection) updates) => super.copyWith((message) => updates(message as Langame_Reflection)) as Langame_Reflection; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Langame_Reflection create() => Langame_Reflection._();
  Langame_Reflection createEmptyInstance() => create();
  static $pb.PbList<Langame_Reflection> createRepeated() => $pb.PbList<Langame_Reflection>();
  @$core.pragma('dart2js:noInline')
  static Langame_Reflection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Langame_Reflection>(create);
  static Langame_Reflection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get lastMessageId => $_getSZ(1);
  @$pb.TagNumber(2)
  set lastMessageId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLastMessageId() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastMessageId() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get alternatives => $_getList(2);

  @$pb.TagNumber(4)
  $0.Timestamp get createdAt => $_getN(3);
  @$pb.TagNumber(4)
  set createdAt($0.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasCreatedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatedAt() => clearField(4);
  @$pb.TagNumber(4)
  $0.Timestamp ensureCreatedAt() => $_ensure(3);

  @$pb.TagNumber(5)
  ContentFilter get contentFilter => $_getN(4);
  @$pb.TagNumber(5)
  set contentFilter(ContentFilter v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasContentFilter() => $_has(4);
  @$pb.TagNumber(5)
  void clearContentFilter() => clearField(5);

  @$pb.TagNumber(6)
  $core.Map<$core.String, $core.int> get userFeedbacks => $_getMap(5);
}

class Langame extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Langame', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..pc<Langame_Player>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'players', $pb.PbFieldType.PM, subBuilder: Langame_Player.create)
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topics')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'initiator')
    ..aOM<$0.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'done', subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $0.Timestamp.create)
    ..pc<Error>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errors', $pb.PbFieldType.PM, subBuilder: Error.create)
    ..pc<Langame_Reflection>(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reflections', $pb.PbFieldType.PM, subBuilder: Langame_Reflection.create)
    ..pPS(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tags')
    ..hasRequiredFields = false
  ;

  Langame._() : super();
  factory Langame({
    $core.String? id,
    $core.Iterable<Langame_Player>? players,
    $core.Iterable<$core.String>? topics,
    $core.String? initiator,
    $0.Timestamp? done,
    $0.Timestamp? createdAt,
    $core.Iterable<Error>? errors,
    $core.Iterable<Langame_Reflection>? reflections,
    $core.Iterable<$core.String>? tags,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (players != null) {
      _result.players.addAll(players);
    }
    if (topics != null) {
      _result.topics.addAll(topics);
    }
    if (initiator != null) {
      _result.initiator = initiator;
    }
    if (done != null) {
      _result.done = done;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (errors != null) {
      _result.errors.addAll(errors);
    }
    if (reflections != null) {
      _result.reflections.addAll(reflections);
    }
    if (tags != null) {
      _result.tags.addAll(tags);
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
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<Langame_Player> get players => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<$core.String> get topics => $_getList(2);

  @$pb.TagNumber(5)
  $core.String get initiator => $_getSZ(3);
  @$pb.TagNumber(5)
  set initiator($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasInitiator() => $_has(3);
  @$pb.TagNumber(5)
  void clearInitiator() => clearField(5);

  @$pb.TagNumber(7)
  $0.Timestamp get done => $_getN(4);
  @$pb.TagNumber(7)
  set done($0.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasDone() => $_has(4);
  @$pb.TagNumber(7)
  void clearDone() => clearField(7);
  @$pb.TagNumber(7)
  $0.Timestamp ensureDone() => $_ensure(4);

  @$pb.TagNumber(9)
  $0.Timestamp get createdAt => $_getN(5);
  @$pb.TagNumber(9)
  set createdAt($0.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(5);
  @$pb.TagNumber(9)
  void clearCreatedAt() => clearField(9);
  @$pb.TagNumber(9)
  $0.Timestamp ensureCreatedAt() => $_ensure(5);

  @$pb.TagNumber(10)
  $core.List<Error> get errors => $_getList(6);

  @$pb.TagNumber(21)
  $core.List<Langame_Reflection> get reflections => $_getList(7);

  @$pb.TagNumber(23)
  $core.List<$core.String> get tags => $_getList(8);
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

class Message_Author extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Message.Author', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tag')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'photoUrl')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bot')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locale')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..hasRequiredFields = false
  ;

  Message_Author._() : super();
  factory Message_Author({
    $core.String? id,
    $core.String? tag,
    $core.String? photoUrl,
    $core.bool? bot,
    $core.String? locale,
    $core.String? email,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (tag != null) {
      _result.tag = tag;
    }
    if (photoUrl != null) {
      _result.photoUrl = photoUrl;
    }
    if (bot != null) {
      _result.bot = bot;
    }
    if (locale != null) {
      _result.locale = locale;
    }
    if (email != null) {
      _result.email = email;
    }
    return _result;
  }
  factory Message_Author.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Message_Author.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Message_Author clone() => Message_Author()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Message_Author copyWith(void Function(Message_Author) updates) => super.copyWith((message) => updates(message as Message_Author)) as Message_Author; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Message_Author create() => Message_Author._();
  Message_Author createEmptyInstance() => create();
  static $pb.PbList<Message_Author> createRepeated() => $pb.PbList<Message_Author>();
  @$core.pragma('dart2js:noInline')
  static Message_Author getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Message_Author>(create);
  static Message_Author? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get tag => $_getSZ(1);
  @$pb.TagNumber(2)
  set tag($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTag() => $_has(1);
  @$pb.TagNumber(2)
  void clearTag() => clearField(2);

  @$pb.TagNumber(4)
  $core.String get photoUrl => $_getSZ(2);
  @$pb.TagNumber(4)
  set photoUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasPhotoUrl() => $_has(2);
  @$pb.TagNumber(4)
  void clearPhotoUrl() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get bot => $_getBF(3);
  @$pb.TagNumber(5)
  set bot($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasBot() => $_has(3);
  @$pb.TagNumber(5)
  void clearBot() => clearField(5);

  @$pb.TagNumber(10)
  $core.String get locale => $_getSZ(4);
  @$pb.TagNumber(10)
  set locale($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(10)
  $core.bool hasLocale() => $_has(4);
  @$pb.TagNumber(10)
  void clearLocale() => clearField(10);

  @$pb.TagNumber(12)
  $core.String get email => $_getSZ(5);
  @$pb.TagNumber(12)
  set email($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(12)
  $core.bool hasEmail() => $_has(5);
  @$pb.TagNumber(12)
  void clearEmail() => clearField(12);
}

class Message_Component_Option extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Message.Component.Option', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'label')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'emoji')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'default')
    ..hasRequiredFields = false
  ;

  Message_Component_Option._() : super();
  factory Message_Component_Option({
    $core.String? label,
    $core.String? value,
    $core.String? description,
    $core.String? emoji,
    $core.bool? default_5,
  }) {
    final _result = create();
    if (label != null) {
      _result.label = label;
    }
    if (value != null) {
      _result.value = value;
    }
    if (description != null) {
      _result.description = description;
    }
    if (emoji != null) {
      _result.emoji = emoji;
    }
    if (default_5 != null) {
      _result.default_5 = default_5;
    }
    return _result;
  }
  factory Message_Component_Option.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Message_Component_Option.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Message_Component_Option clone() => Message_Component_Option()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Message_Component_Option copyWith(void Function(Message_Component_Option) updates) => super.copyWith((message) => updates(message as Message_Component_Option)) as Message_Component_Option; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Message_Component_Option create() => Message_Component_Option._();
  Message_Component_Option createEmptyInstance() => create();
  static $pb.PbList<Message_Component_Option> createRepeated() => $pb.PbList<Message_Component_Option>();
  @$core.pragma('dart2js:noInline')
  static Message_Component_Option getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Message_Component_Option>(create);
  static Message_Component_Option? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get label => $_getSZ(0);
  @$pb.TagNumber(1)
  set label($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLabel() => $_has(0);
  @$pb.TagNumber(1)
  void clearLabel() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get value => $_getSZ(1);
  @$pb.TagNumber(2)
  set value($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get emoji => $_getSZ(3);
  @$pb.TagNumber(4)
  set emoji($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasEmoji() => $_has(3);
  @$pb.TagNumber(4)
  void clearEmoji() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get default_5 => $_getBF(4);
  @$pb.TagNumber(5)
  set default_5($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDefault_5() => $_has(4);
  @$pb.TagNumber(5)
  void clearDefault_5() => clearField(5);
}

class Message_Component extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Message.Component', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OU3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customId')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'disabled')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'style', $pb.PbFieldType.OU3)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'label')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'emoji')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'url')
    ..pc<Message_Component_Option>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'options', $pb.PbFieldType.PM, subBuilder: Message_Component_Option.create)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'placeholder')
    ..a<$core.int>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minValues', $pb.PbFieldType.O3)
    ..a<$core.int>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxValues', $pb.PbFieldType.O3)
    ..pc<Message_Component>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'components', $pb.PbFieldType.PM, subBuilder: Message_Component.create)
    ..hasRequiredFields = false
  ;

  Message_Component._() : super();
  factory Message_Component({
    $core.int? type,
    $core.String? customId,
    $core.bool? disabled,
    $core.int? style,
    $core.String? label,
    $core.String? emoji,
    $core.String? url,
    $core.Iterable<Message_Component_Option>? options,
    $core.String? placeholder,
    $core.int? minValues,
    $core.int? maxValues,
    $core.Iterable<Message_Component>? components,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (customId != null) {
      _result.customId = customId;
    }
    if (disabled != null) {
      _result.disabled = disabled;
    }
    if (style != null) {
      _result.style = style;
    }
    if (label != null) {
      _result.label = label;
    }
    if (emoji != null) {
      _result.emoji = emoji;
    }
    if (url != null) {
      _result.url = url;
    }
    if (options != null) {
      _result.options.addAll(options);
    }
    if (placeholder != null) {
      _result.placeholder = placeholder;
    }
    if (minValues != null) {
      _result.minValues = minValues;
    }
    if (maxValues != null) {
      _result.maxValues = maxValues;
    }
    if (components != null) {
      _result.components.addAll(components);
    }
    return _result;
  }
  factory Message_Component.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Message_Component.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Message_Component clone() => Message_Component()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Message_Component copyWith(void Function(Message_Component) updates) => super.copyWith((message) => updates(message as Message_Component)) as Message_Component; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Message_Component create() => Message_Component._();
  Message_Component createEmptyInstance() => create();
  static $pb.PbList<Message_Component> createRepeated() => $pb.PbList<Message_Component>();
  @$core.pragma('dart2js:noInline')
  static Message_Component getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Message_Component>(create);
  static Message_Component? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get type => $_getIZ(0);
  @$pb.TagNumber(1)
  set type($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get customId => $_getSZ(1);
  @$pb.TagNumber(2)
  set customId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCustomId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCustomId() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get disabled => $_getBF(2);
  @$pb.TagNumber(3)
  set disabled($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDisabled() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisabled() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get style => $_getIZ(3);
  @$pb.TagNumber(4)
  set style($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStyle() => $_has(3);
  @$pb.TagNumber(4)
  void clearStyle() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get label => $_getSZ(4);
  @$pb.TagNumber(5)
  set label($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLabel() => $_has(4);
  @$pb.TagNumber(5)
  void clearLabel() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get emoji => $_getSZ(5);
  @$pb.TagNumber(6)
  set emoji($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasEmoji() => $_has(5);
  @$pb.TagNumber(6)
  void clearEmoji() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get url => $_getSZ(6);
  @$pb.TagNumber(7)
  set url($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearUrl() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<Message_Component_Option> get options => $_getList(7);

  @$pb.TagNumber(9)
  $core.String get placeholder => $_getSZ(8);
  @$pb.TagNumber(9)
  set placeholder($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasPlaceholder() => $_has(8);
  @$pb.TagNumber(9)
  void clearPlaceholder() => clearField(9);

  @$pb.TagNumber(10)
  $core.int get minValues => $_getIZ(9);
  @$pb.TagNumber(10)
  set minValues($core.int v) { $_setSignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasMinValues() => $_has(9);
  @$pb.TagNumber(10)
  void clearMinValues() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get maxValues => $_getIZ(10);
  @$pb.TagNumber(11)
  set maxValues($core.int v) { $_setSignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasMaxValues() => $_has(10);
  @$pb.TagNumber(11)
  void clearMaxValues() => clearField(11);

  @$pb.TagNumber(12)
  $core.List<Message_Component> get components => $_getList(11);
}

class Message_Delivery extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Message.Delivery', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'attempts', $pb.PbFieldType.OU3)
    ..aOM<$0.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endTime', subBuilder: $0.Timestamp.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'error')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..hasRequiredFields = false
  ;

  Message_Delivery._() : super();
  factory Message_Delivery({
    $core.int? attempts,
    $0.Timestamp? endTime,
    $core.String? error,
    $core.String? status,
  }) {
    final _result = create();
    if (attempts != null) {
      _result.attempts = attempts;
    }
    if (endTime != null) {
      _result.endTime = endTime;
    }
    if (error != null) {
      _result.error = error;
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory Message_Delivery.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Message_Delivery.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Message_Delivery clone() => Message_Delivery()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Message_Delivery copyWith(void Function(Message_Delivery) updates) => super.copyWith((message) => updates(message as Message_Delivery)) as Message_Delivery; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Message_Delivery create() => Message_Delivery._();
  Message_Delivery createEmptyInstance() => create();
  static $pb.PbList<Message_Delivery> createRepeated() => $pb.PbList<Message_Delivery>();
  @$core.pragma('dart2js:noInline')
  static Message_Delivery getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Message_Delivery>(create);
  static Message_Delivery? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get attempts => $_getIZ(0);
  @$pb.TagNumber(1)
  set attempts($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAttempts() => $_has(0);
  @$pb.TagNumber(1)
  void clearAttempts() => clearField(1);

  @$pb.TagNumber(2)
  $0.Timestamp get endTime => $_getN(1);
  @$pb.TagNumber(2)
  set endTime($0.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasEndTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndTime() => clearField(2);
  @$pb.TagNumber(2)
  $0.Timestamp ensureEndTime() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get error => $_getSZ(2);
  @$pb.TagNumber(3)
  set error($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);
}

class Message_Analysis_Error extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Message.Analysis.Error', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'developerMessage')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tries', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  Message_Analysis_Error._() : super();
  factory Message_Analysis_Error({
    $core.String? developerMessage,
    $core.int? tries,
  }) {
    final _result = create();
    if (developerMessage != null) {
      _result.developerMessage = developerMessage;
    }
    if (tries != null) {
      _result.tries = tries;
    }
    return _result;
  }
  factory Message_Analysis_Error.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Message_Analysis_Error.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Message_Analysis_Error clone() => Message_Analysis_Error()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Message_Analysis_Error copyWith(void Function(Message_Analysis_Error) updates) => super.copyWith((message) => updates(message as Message_Analysis_Error)) as Message_Analysis_Error; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Message_Analysis_Error create() => Message_Analysis_Error._();
  Message_Analysis_Error createEmptyInstance() => create();
  static $pb.PbList<Message_Analysis_Error> createRepeated() => $pb.PbList<Message_Analysis_Error>();
  @$core.pragma('dart2js:noInline')
  static Message_Analysis_Error getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Message_Analysis_Error>(create);
  static Message_Analysis_Error? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get developerMessage => $_getSZ(0);
  @$pb.TagNumber(1)
  set developerMessage($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDeveloperMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeveloperMessage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get tries => $_getIZ(1);
  @$pb.TagNumber(2)
  set tries($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTries() => $_has(1);
  @$pb.TagNumber(2)
  void clearTries() => clearField(2);
}

class Message_Analysis_Sentiment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Message.Analysis.Sentiment', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'score', $pb.PbFieldType.OF)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'label')
    ..hasRequiredFields = false
  ;

  Message_Analysis_Sentiment._() : super();
  factory Message_Analysis_Sentiment({
    $core.double? score,
    $core.String? label,
  }) {
    final _result = create();
    if (score != null) {
      _result.score = score;
    }
    if (label != null) {
      _result.label = label;
    }
    return _result;
  }
  factory Message_Analysis_Sentiment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Message_Analysis_Sentiment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Message_Analysis_Sentiment clone() => Message_Analysis_Sentiment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Message_Analysis_Sentiment copyWith(void Function(Message_Analysis_Sentiment) updates) => super.copyWith((message) => updates(message as Message_Analysis_Sentiment)) as Message_Analysis_Sentiment; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Message_Analysis_Sentiment create() => Message_Analysis_Sentiment._();
  Message_Analysis_Sentiment createEmptyInstance() => create();
  static $pb.PbList<Message_Analysis_Sentiment> createRepeated() => $pb.PbList<Message_Analysis_Sentiment>();
  @$core.pragma('dart2js:noInline')
  static Message_Analysis_Sentiment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Message_Analysis_Sentiment>(create);
  static Message_Analysis_Sentiment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get score => $_getN(0);
  @$pb.TagNumber(1)
  set score($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasScore() => $_has(0);
  @$pb.TagNumber(1)
  void clearScore() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get label => $_getSZ(1);
  @$pb.TagNumber(2)
  set label($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearLabel() => clearField(2);
}

class Message_Analysis_Token extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Message.Analysis.Token', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'start', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'end', $pb.PbFieldType.OU3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'word')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'entityGroup')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'score', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  Message_Analysis_Token._() : super();
  factory Message_Analysis_Token({
    $core.int? start,
    $core.int? end,
    $core.String? word,
    $core.String? entityGroup,
    $core.double? score,
  }) {
    final _result = create();
    if (start != null) {
      _result.start = start;
    }
    if (end != null) {
      _result.end = end;
    }
    if (word != null) {
      _result.word = word;
    }
    if (entityGroup != null) {
      _result.entityGroup = entityGroup;
    }
    if (score != null) {
      _result.score = score;
    }
    return _result;
  }
  factory Message_Analysis_Token.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Message_Analysis_Token.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Message_Analysis_Token clone() => Message_Analysis_Token()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Message_Analysis_Token copyWith(void Function(Message_Analysis_Token) updates) => super.copyWith((message) => updates(message as Message_Analysis_Token)) as Message_Analysis_Token; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Message_Analysis_Token create() => Message_Analysis_Token._();
  Message_Analysis_Token createEmptyInstance() => create();
  static $pb.PbList<Message_Analysis_Token> createRepeated() => $pb.PbList<Message_Analysis_Token>();
  @$core.pragma('dart2js:noInline')
  static Message_Analysis_Token getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Message_Analysis_Token>(create);
  static Message_Analysis_Token? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get start => $_getIZ(0);
  @$pb.TagNumber(1)
  set start($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStart() => $_has(0);
  @$pb.TagNumber(1)
  void clearStart() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get end => $_getIZ(1);
  @$pb.TagNumber(2)
  set end($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEnd() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnd() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get word => $_getSZ(2);
  @$pb.TagNumber(3)
  set word($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasWord() => $_has(2);
  @$pb.TagNumber(3)
  void clearWord() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get entityGroup => $_getSZ(3);
  @$pb.TagNumber(4)
  set entityGroup($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasEntityGroup() => $_has(3);
  @$pb.TagNumber(4)
  void clearEntityGroup() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get score => $_getN(4);
  @$pb.TagNumber(5)
  set score($core.double v) { $_setFloat(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasScore() => $_has(4);
  @$pb.TagNumber(5)
  void clearScore() => clearField(5);
}

class Message_Analysis extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Message.Analysis', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topics')
    ..pc<Message_Analysis_Sentiment>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sentiments', $pb.PbFieldType.PM, subBuilder: Message_Analysis_Sentiment.create)
    ..aOM<Message_Analysis_Error>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'error', subBuilder: Message_Analysis_Error.create)
    ..e<ContentFilter>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'filter', $pb.PbFieldType.OE, defaultOrMaker: ContentFilter.Safe, valueOf: ContentFilter.valueOf, enumValues: ContentFilter.values)
    ..pc<Message_Analysis_Token>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'token', $pb.PbFieldType.PM, subBuilder: Message_Analysis_Token.create)
    ..hasRequiredFields = false
  ;

  Message_Analysis._() : super();
  factory Message_Analysis({
    $core.Iterable<$core.String>? topics,
    $core.Iterable<Message_Analysis_Sentiment>? sentiments,
    Message_Analysis_Error? error,
    ContentFilter? filter,
    $core.Iterable<Message_Analysis_Token>? token,
  }) {
    final _result = create();
    if (topics != null) {
      _result.topics.addAll(topics);
    }
    if (sentiments != null) {
      _result.sentiments.addAll(sentiments);
    }
    if (error != null) {
      _result.error = error;
    }
    if (filter != null) {
      _result.filter = filter;
    }
    if (token != null) {
      _result.token.addAll(token);
    }
    return _result;
  }
  factory Message_Analysis.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Message_Analysis.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Message_Analysis clone() => Message_Analysis()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Message_Analysis copyWith(void Function(Message_Analysis) updates) => super.copyWith((message) => updates(message as Message_Analysis)) as Message_Analysis; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Message_Analysis create() => Message_Analysis._();
  Message_Analysis createEmptyInstance() => create();
  static $pb.PbList<Message_Analysis> createRepeated() => $pb.PbList<Message_Analysis>();
  @$core.pragma('dart2js:noInline')
  static Message_Analysis getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Message_Analysis>(create);
  static Message_Analysis? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get topics => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<Message_Analysis_Sentiment> get sentiments => $_getList(1);

  @$pb.TagNumber(3)
  Message_Analysis_Error get error => $_getN(2);
  @$pb.TagNumber(3)
  set error(Message_Analysis_Error v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => clearField(3);
  @$pb.TagNumber(3)
  Message_Analysis_Error ensureError() => $_ensure(2);

  @$pb.TagNumber(4)
  ContentFilter get filter => $_getN(3);
  @$pb.TagNumber(4)
  set filter(ContentFilter v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasFilter() => $_has(3);
  @$pb.TagNumber(4)
  void clearFilter() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<Message_Analysis_Token> get token => $_getList(4);
}

class Message extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Message', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOM<$0.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $0.Timestamp.create)
    ..aOM<Message_Author>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'author', subBuilder: Message_Author.create)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'langameId')
    ..e<Message_Type>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: Message_Type.INVITE, valueOf: Message_Type.valueOf, enumValues: Message_Type.values)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'body')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOM<Message_Analysis>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'analysis', subBuilder: Message_Analysis.create)
    ..aOM<Message_Delivery>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'delivery', subBuilder: Message_Delivery.create)
    ..pc<Message_Component>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'components', $pb.PbFieldType.PM, subBuilder: Message_Component.create)
    ..hasRequiredFields = false
  ;

  Message._() : super();
  factory Message({
    $0.Timestamp? createdAt,
    Message_Author? author,
    $core.String? langameId,
    Message_Type? type,
    $core.String? body,
    $core.String? title,
    $core.String? id,
    Message_Analysis? analysis,
    Message_Delivery? delivery,
    $core.Iterable<Message_Component>? components,
  }) {
    final _result = create();
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (author != null) {
      _result.author = author;
    }
    if (langameId != null) {
      _result.langameId = langameId;
    }
    if (type != null) {
      _result.type = type;
    }
    if (body != null) {
      _result.body = body;
    }
    if (title != null) {
      _result.title = title;
    }
    if (id != null) {
      _result.id = id;
    }
    if (analysis != null) {
      _result.analysis = analysis;
    }
    if (delivery != null) {
      _result.delivery = delivery;
    }
    if (components != null) {
      _result.components.addAll(components);
    }
    return _result;
  }
  factory Message.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Message.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Message clone() => Message()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Message copyWith(void Function(Message) updates) => super.copyWith((message) => updates(message as Message)) as Message; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Message create() => Message._();
  Message createEmptyInstance() => create();
  static $pb.PbList<Message> createRepeated() => $pb.PbList<Message>();
  @$core.pragma('dart2js:noInline')
  static Message getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Message>(create);
  static Message? _defaultInstance;

  @$pb.TagNumber(3)
  $0.Timestamp get createdAt => $_getN(0);
  @$pb.TagNumber(3)
  set createdAt($0.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCreatedAt() => $_has(0);
  @$pb.TagNumber(3)
  void clearCreatedAt() => clearField(3);
  @$pb.TagNumber(3)
  $0.Timestamp ensureCreatedAt() => $_ensure(0);

  @$pb.TagNumber(4)
  Message_Author get author => $_getN(1);
  @$pb.TagNumber(4)
  set author(Message_Author v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasAuthor() => $_has(1);
  @$pb.TagNumber(4)
  void clearAuthor() => clearField(4);
  @$pb.TagNumber(4)
  Message_Author ensureAuthor() => $_ensure(1);

  @$pb.TagNumber(7)
  $core.String get langameId => $_getSZ(2);
  @$pb.TagNumber(7)
  set langameId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(7)
  $core.bool hasLangameId() => $_has(2);
  @$pb.TagNumber(7)
  void clearLangameId() => clearField(7);

  @$pb.TagNumber(8)
  Message_Type get type => $_getN(3);
  @$pb.TagNumber(8)
  set type(Message_Type v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasType() => $_has(3);
  @$pb.TagNumber(8)
  void clearType() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get body => $_getSZ(4);
  @$pb.TagNumber(9)
  set body($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(9)
  $core.bool hasBody() => $_has(4);
  @$pb.TagNumber(9)
  void clearBody() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get title => $_getSZ(5);
  @$pb.TagNumber(10)
  set title($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(10)
  $core.bool hasTitle() => $_has(5);
  @$pb.TagNumber(10)
  void clearTitle() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get id => $_getSZ(6);
  @$pb.TagNumber(11)
  set id($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(11)
  $core.bool hasId() => $_has(6);
  @$pb.TagNumber(11)
  void clearId() => clearField(11);

  @$pb.TagNumber(12)
  Message_Analysis get analysis => $_getN(7);
  @$pb.TagNumber(12)
  set analysis(Message_Analysis v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasAnalysis() => $_has(7);
  @$pb.TagNumber(12)
  void clearAnalysis() => clearField(12);
  @$pb.TagNumber(12)
  Message_Analysis ensureAnalysis() => $_ensure(7);

  @$pb.TagNumber(13)
  Message_Delivery get delivery => $_getN(8);
  @$pb.TagNumber(13)
  set delivery(Message_Delivery v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasDelivery() => $_has(8);
  @$pb.TagNumber(13)
  void clearDelivery() => clearField(13);
  @$pb.TagNumber(13)
  Message_Delivery ensureDelivery() => $_ensure(8);

  @$pb.TagNumber(14)
  $core.List<Message_Component> get components => $_getList(9);
}

