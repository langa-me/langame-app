///
//  Generated code. Do not modify.
//  source: langame/protobuf/langame.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../google/protobuf/timestamp.pb.dart' as $0;
import '../../google/protobuf/any.pb.dart' as $1;

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

class UserPreference_Notification extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UserPreference.Notification', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOM<UserPreference_Notification_Invite>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invite', subBuilder: UserPreference_Notification_Invite.create)
    ..aOM<UserPreference_Notification_Message>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message', subBuilder: UserPreference_Notification_Message.create)
    ..hasRequiredFields = false
  ;

  UserPreference_Notification._() : super();
  factory UserPreference_Notification({
    UserPreference_Notification_Invite? invite,
    UserPreference_Notification_Message? message,
  }) {
    final _result = create();
    if (invite != null) {
      _result.invite = invite;
    }
    if (message != null) {
      _result.message = message;
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
}

class UserPreference extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UserPreference', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..e<UserPreference_RecommendationType>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userRecommendations', $pb.PbFieldType.OE, defaultOrMaker: UserPreference_RecommendationType.NONE, valueOf: UserPreference_RecommendationType.valueOf, enumValues: UserPreference_RecommendationType.values)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'themeIndex', $pb.PbFieldType.O3)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasDoneOnBoarding')
    ..pPS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userSearchHistory')
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'shakeToFeedback')
    ..pPS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'favoriteTopics')
    ..pPS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topicSearchHistory')
    ..pc<Error>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errors', $pb.PbFieldType.PM, subBuilder: Error.create)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'speechToTextLocale')
    ..aOB(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sawWhatsNew')
    ..aOM<UserPreference_Notification>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notification', subBuilder: UserPreference_Notification.create)
    ..aOB(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'previewMode')
    ..hasRequiredFields = false
  ;

  UserPreference._() : super();
  factory UserPreference({
    $core.String? userId,
    UserPreference_RecommendationType? userRecommendations,
    $core.int? themeIndex,
    $core.bool? hasDoneOnBoarding,
    $core.Iterable<$core.String>? userSearchHistory,
    $core.bool? shakeToFeedback,
    $core.Iterable<$core.String>? favoriteTopics,
    $core.Iterable<$core.String>? topicSearchHistory,
    $core.Iterable<Error>? errors,
    $core.String? speechToTextLocale,
    $core.bool? sawWhatsNew,
    UserPreference_Notification? notification,
    $core.bool? previewMode,
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
    if (shakeToFeedback != null) {
      _result.shakeToFeedback = shakeToFeedback;
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
    if (speechToTextLocale != null) {
      _result.speechToTextLocale = speechToTextLocale;
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
  UserPreference_RecommendationType get userRecommendations => $_getN(1);
  @$pb.TagNumber(3)
  set userRecommendations(UserPreference_RecommendationType v) { setField(3, v); }
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

  @$pb.TagNumber(7)
  $core.bool get shakeToFeedback => $_getBF(5);
  @$pb.TagNumber(7)
  set shakeToFeedback($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasShakeToFeedback() => $_has(5);
  @$pb.TagNumber(7)
  void clearShakeToFeedback() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<$core.String> get favoriteTopics => $_getList(6);

  @$pb.TagNumber(9)
  $core.List<$core.String> get topicSearchHistory => $_getList(7);

  @$pb.TagNumber(10)
  $core.List<Error> get errors => $_getList(8);

  @$pb.TagNumber(11)
  $core.String get speechToTextLocale => $_getSZ(9);
  @$pb.TagNumber(11)
  set speechToTextLocale($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(11)
  $core.bool hasSpeechToTextLocale() => $_has(9);
  @$pb.TagNumber(11)
  void clearSpeechToTextLocale() => clearField(11);

  @$pb.TagNumber(13)
  $core.bool get sawWhatsNew => $_getBF(10);
  @$pb.TagNumber(13)
  set sawWhatsNew($core.bool v) { $_setBool(10, v); }
  @$pb.TagNumber(13)
  $core.bool hasSawWhatsNew() => $_has(10);
  @$pb.TagNumber(13)
  void clearSawWhatsNew() => clearField(13);

  @$pb.TagNumber(14)
  UserPreference_Notification get notification => $_getN(11);
  @$pb.TagNumber(14)
  set notification(UserPreference_Notification v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasNotification() => $_has(11);
  @$pb.TagNumber(14)
  void clearNotification() => clearField(14);
  @$pb.TagNumber(14)
  UserPreference_Notification ensureNotification() => $_ensure(11);

  @$pb.TagNumber(15)
  $core.bool get previewMode => $_getBF(12);
  @$pb.TagNumber(15)
  set previewMode($core.bool v) { $_setBool(12, v); }
  @$pb.TagNumber(15)
  $core.bool hasPreviewMode() => $_has(12);
  @$pb.TagNumber(15)
  void clearPreviewMode() => clearField(15);
}

class Langame_Reflection extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Langame.Reflection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastMessageId')
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'alternatives')
    ..aOM<$0.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $0.Timestamp.create)
    ..e<ContentFilter>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contentFilter', $pb.PbFieldType.OE, defaultOrMaker: ContentFilter.Safe, valueOf: ContentFilter.valueOf, enumValues: ContentFilter.values)
    ..hasRequiredFields = false
  ;

  Langame_Reflection._() : super();
  factory Langame_Reflection({
    $core.String? userId,
    $core.String? lastMessageId,
    $core.Iterable<$core.String>? alternatives,
    $0.Timestamp? createdAt,
    ContentFilter? contentFilter,
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
}

class Langame_Suggestion extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Langame.Suggestion', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastMessageId')
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'alternatives')
    ..aOM<$0.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $0.Timestamp.create)
    ..e<ContentFilter>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contentFilter', $pb.PbFieldType.OE, defaultOrMaker: ContentFilter.Safe, valueOf: ContentFilter.valueOf, enumValues: ContentFilter.values)
    ..hasRequiredFields = false
  ;

  Langame_Suggestion._() : super();
  factory Langame_Suggestion({
    $core.String? userId,
    $core.String? lastMessageId,
    $core.Iterable<$core.String>? alternatives,
    $0.Timestamp? createdAt,
    ContentFilter? contentFilter,
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
    return _result;
  }
  factory Langame_Suggestion.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Langame_Suggestion.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Langame_Suggestion clone() => Langame_Suggestion()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Langame_Suggestion copyWith(void Function(Langame_Suggestion) updates) => super.copyWith((message) => updates(message as Langame_Suggestion)) as Langame_Suggestion; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Langame_Suggestion create() => Langame_Suggestion._();
  Langame_Suggestion createEmptyInstance() => create();
  static $pb.PbList<Langame_Suggestion> createRepeated() => $pb.PbList<Langame_Suggestion>();
  @$core.pragma('dart2js:noInline')
  static Langame_Suggestion getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Langame_Suggestion>(create);
  static Langame_Suggestion? _defaultInstance;

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
}

class Langame extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Langame', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelName')
    ..pPS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'players')
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topics')
    ..pc<Meme>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memes', $pb.PbFieldType.PM, subBuilder: Meme.create)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'initiator')
    ..aOM<$0.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'done', subBuilder: $0.Timestamp.create)
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentMeme', $pb.PbFieldType.O3)
    ..aOM<$0.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'date', subBuilder: $0.Timestamp.create)
    ..pc<Error>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errors', $pb.PbFieldType.PM, subBuilder: Error.create)
    ..aOM<$0.Timestamp>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'started', subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextMeme', subBuilder: $0.Timestamp.create)
    ..a<$core.int>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memesSeen', $pb.PbFieldType.O3)
    ..aOM<$0.Timestamp>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memeChanged', subBuilder: $0.Timestamp.create)
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'link')
    ..pPS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reservedSpots')
    ..aOB(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isLocked')
    ..aOB(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isText')
    ..pc<Langame_Reflection>(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reflections', $pb.PbFieldType.PM, subBuilder: Langame_Reflection.create)
    ..pc<Langame_Suggestion>(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'suggestions', $pb.PbFieldType.PM, subBuilder: Langame_Suggestion.create)
    ..hasRequiredFields = false
  ;

  Langame._() : super();
  factory Langame({
    $core.String? channelName,
    $core.Iterable<$core.String>? players,
    $core.Iterable<$core.String>? topics,
    $core.Iterable<Meme>? memes,
    $core.String? initiator,
    $0.Timestamp? done,
    $core.int? currentMeme,
    $0.Timestamp? date,
    $core.Iterable<Error>? errors,
    $0.Timestamp? started,
    $0.Timestamp? nextMeme,
    $core.int? memesSeen,
    $0.Timestamp? memeChanged,
    $core.String? link,
    $core.Iterable<$core.String>? reservedSpots,
    $core.bool? isLocked,
    $core.bool? isText,
    $core.Iterable<Langame_Reflection>? reflections,
    $core.Iterable<Langame_Suggestion>? suggestions,
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
    if (isText != null) {
      _result.isText = isText;
    }
    if (reflections != null) {
      _result.reflections.addAll(reflections);
    }
    if (suggestions != null) {
      _result.suggestions.addAll(suggestions);
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
  $core.List<Meme> get memes => $_getList(3);

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
  $core.List<Error> get errors => $_getList(8);

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

  @$pb.TagNumber(20)
  $core.bool get isText => $_getBF(16);
  @$pb.TagNumber(20)
  set isText($core.bool v) { $_setBool(16, v); }
  @$pb.TagNumber(20)
  $core.bool hasIsText() => $_has(16);
  @$pb.TagNumber(20)
  void clearIsText() => clearField(20);

  @$pb.TagNumber(21)
  $core.List<Langame_Reflection> get reflections => $_getList(17);

  @$pb.TagNumber(22)
  $core.List<Langame_Suggestion> get suggestions => $_getList(18);
}

class Player extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Player', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOM<$0.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timeIn', subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timeOut', subBuilder: $0.Timestamp.create)
    ..pc<Note>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes', $pb.PbFieldType.PM, subBuilder: Note.create)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'audioId', $pb.PbFieldType.O3)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'audioToken')
    ..pc<Error>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errors', $pb.PbFieldType.PM, subBuilder: Error.create)
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
    $core.Iterable<Error>? errors,
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
    if (errors != null) {
      _result.errors.addAll(errors);
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

  @$pb.TagNumber(7)
  $core.List<Error> get errors => $_getList(6);
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
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOM<$1.Any>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'parameters', subBuilder: $1.Any.create)
    ..hasRequiredFields = false
  ;

  Prompt._() : super();
  factory Prompt({
    $core.String? type,
    $core.String? template,
    $core.String? id,
    $1.Any? parameters,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (template != null) {
      _result.template = template;
    }
    if (id != null) {
      _result.id = id;
    }
    if (parameters != null) {
      _result.parameters = parameters;
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

  @$pb.TagNumber(4)
  $core.String get id => $_getSZ(2);
  @$pb.TagNumber(4)
  set id($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasId() => $_has(2);
  @$pb.TagNumber(4)
  void clearId() => clearField(4);

  @$pb.TagNumber(5)
  $1.Any get parameters => $_getN(3);
  @$pb.TagNumber(5)
  set parameters($1.Any v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasParameters() => $_has(3);
  @$pb.TagNumber(5)
  void clearParameters() => clearField(5);
  @$pb.TagNumber(5)
  $1.Any ensureParameters() => $_ensure(3);
}

class Recording extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Recording', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOM<$0.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $0.Timestamp.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'text')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..m<$core.String, $core.String>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata', entryClassName: 'Recording.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('langame.protobuf'))
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'note')
    ..hasRequiredFields = false
  ;

  Recording._() : super();
  factory Recording({
    $0.Timestamp? createdAt,
    $core.String? text,
    $core.String? userId,
    $core.Map<$core.String, $core.String>? metadata,
    $core.String? note,
  }) {
    final _result = create();
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (text != null) {
      _result.text = text;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (metadata != null) {
      _result.metadata.addAll(metadata);
    }
    if (note != null) {
      _result.note = note;
    }
    return _result;
  }
  factory Recording.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Recording.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Recording clone() => Recording()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Recording copyWith(void Function(Recording) updates) => super.copyWith((message) => updates(message as Recording)) as Recording; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Recording create() => Recording._();
  Recording createEmptyInstance() => create();
  static $pb.PbList<Recording> createRepeated() => $pb.PbList<Recording>();
  @$core.pragma('dart2js:noInline')
  static Recording getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Recording>(create);
  static Recording? _defaultInstance;

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
  $core.String get text => $_getSZ(1);
  @$pb.TagNumber(2)
  set text($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasText() => $_has(1);
  @$pb.TagNumber(2)
  void clearText() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(3);

  @$pb.TagNumber(5)
  $core.String get note => $_getSZ(4);
  @$pb.TagNumber(5)
  set note($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNote() => $_has(4);
  @$pb.TagNumber(5)
  void clearNote() => clearField(5);
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

class Message_Analysis extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Message.Analysis', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..pc<Message_Analysis_Sentiment>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sentiments', $pb.PbFieldType.PM, subBuilder: Message_Analysis_Sentiment.create)
    ..hasRequiredFields = false
  ;

  Message_Analysis._() : super();
  factory Message_Analysis({
    $core.Iterable<Message_Analysis_Sentiment>? sentiments,
  }) {
    final _result = create();
    if (sentiments != null) {
      _result.sentiments.addAll(sentiments);
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

  @$pb.TagNumber(2)
  $core.List<Message_Analysis_Sentiment> get sentiments => $_getList(0);
}

class Message extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Message', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOM<$0.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $0.Timestamp.create)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fromUid')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'toUid')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelName')
    ..e<Message_Type>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: Message_Type.INVITE, valueOf: Message_Type.valueOf, enumValues: Message_Type.values)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'body')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..hasRequiredFields = false
  ;

  Message._() : super();
  factory Message({
    $0.Timestamp? createdAt,
    $core.String? fromUid,
    $core.String? toUid,
    $core.String? channelName,
    Message_Type? type,
    $core.String? body,
    $core.String? title,
  }) {
    final _result = create();
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (fromUid != null) {
      _result.fromUid = fromUid;
    }
    if (toUid != null) {
      _result.toUid = toUid;
    }
    if (channelName != null) {
      _result.channelName = channelName;
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
  $core.String get fromUid => $_getSZ(1);
  @$pb.TagNumber(4)
  set fromUid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(4)
  $core.bool hasFromUid() => $_has(1);
  @$pb.TagNumber(4)
  void clearFromUid() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get toUid => $_getSZ(2);
  @$pb.TagNumber(5)
  set toUid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(5)
  $core.bool hasToUid() => $_has(2);
  @$pb.TagNumber(5)
  void clearToUid() => clearField(5);

  @$pb.TagNumber(7)
  $core.String get channelName => $_getSZ(3);
  @$pb.TagNumber(7)
  set channelName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(7)
  $core.bool hasChannelName() => $_has(3);
  @$pb.TagNumber(7)
  void clearChannelName() => clearField(7);

  @$pb.TagNumber(8)
  Message_Type get type => $_getN(4);
  @$pb.TagNumber(8)
  set type(Message_Type v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasType() => $_has(4);
  @$pb.TagNumber(8)
  void clearType() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get body => $_getSZ(5);
  @$pb.TagNumber(9)
  set body($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(9)
  $core.bool hasBody() => $_has(5);
  @$pb.TagNumber(9)
  void clearBody() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get title => $_getSZ(6);
  @$pb.TagNumber(10)
  set title($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(10)
  $core.bool hasTitle() => $_has(6);
  @$pb.TagNumber(10)
  void clearTitle() => clearField(10);
}

