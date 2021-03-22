///
//  Generated code. Do not modify.
//  source: api/api.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'api.pbenum.dart';

export 'api.pbenum.dart';

class LangameUser extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LangameUser', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uid')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'displayName')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'emailVerified')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'photoUrl')
    ..e<LangameUser_Status>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: LangameUser_Status.OFFLINE, valueOf: LangameUser_Status.valueOf, enumValues: LangameUser_Status.values)
    ..hasRequiredFields = false
  ;

  LangameUser._() : super();
  factory LangameUser({
    $core.String? uid,
    $core.String? email,
    $core.String? displayName,
    $core.bool? emailVerified,
    $core.String? phoneNumber,
    $core.String? photoUrl,
    LangameUser_Status? status,
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
    if (emailVerified != null) {
      _result.emailVerified = emailVerified;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (photoUrl != null) {
      _result.photoUrl = photoUrl;
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory LangameUser.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LangameUser.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LangameUser clone() => LangameUser()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LangameUser copyWith(void Function(LangameUser) updates) => super.copyWith((message) => updates(message as LangameUser)) as LangameUser; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LangameUser create() => LangameUser._();
  LangameUser createEmptyInstance() => create();
  static $pb.PbList<LangameUser> createRepeated() => $pb.PbList<LangameUser>();
  @$core.pragma('dart2js:noInline')
  static LangameUser getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LangameUser>(create);
  static LangameUser? _defaultInstance;

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
  $core.bool get emailVerified => $_getBF(3);
  @$pb.TagNumber(4)
  set emailVerified($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasEmailVerified() => $_has(3);
  @$pb.TagNumber(4)
  void clearEmailVerified() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get phoneNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set phoneNumber($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPhoneNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhoneNumber() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get photoUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set photoUrl($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPhotoUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearPhotoUrl() => clearField(6);

  @$pb.TagNumber(7)
  LangameUser_Status get status => $_getN(6);
  @$pb.TagNumber(7)
  set status(LangameUser_Status v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => clearField(7);
}

class TopicGroup extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TopicGroup', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..pPS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topics')
    ..hasRequiredFields = false
  ;

  TopicGroup._() : super();
  factory TopicGroup({
    $core.String? name,
    $core.Iterable<$core.String>? topics,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (topics != null) {
      _result.topics.addAll(topics);
    }
    return _result;
  }
  factory TopicGroup.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TopicGroup.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TopicGroup clone() => TopicGroup()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TopicGroup copyWith(void Function(TopicGroup) updates) => super.copyWith((message) => updates(message as TopicGroup)) as TopicGroup; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TopicGroup create() => TopicGroup._();
  TopicGroup createEmptyInstance() => create();
  static $pb.PbList<TopicGroup> createRepeated() => $pb.PbList<TopicGroup>();
  @$core.pragma('dart2js:noInline')
  static TopicGroup getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TopicGroup>(create);
  static TopicGroup? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get topics => $_getList(1);
}

class Relation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Relation', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'api'), createEmptyInstance: create)
    ..aOM<LangameUser>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstUser', subBuilder: LangameUser.create)
    ..aOM<LangameUser>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'secondUser', subBuilder: LangameUser.create)
    ..e<RelationLevel>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'level', $pb.PbFieldType.OE, defaultOrMaker: RelationLevel.BAD, valueOf: RelationLevel.valueOf, enumValues: RelationLevel.values)
    ..hasRequiredFields = false
  ;

  Relation._() : super();
  factory Relation({
    LangameUser? firstUser,
    LangameUser? secondUser,
    RelationLevel? level,
  }) {
    final _result = create();
    if (firstUser != null) {
      _result.firstUser = firstUser;
    }
    if (secondUser != null) {
      _result.secondUser = secondUser;
    }
    if (level != null) {
      _result.level = level;
    }
    return _result;
  }
  factory Relation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Relation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Relation clone() => Relation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Relation copyWith(void Function(Relation) updates) => super.copyWith((message) => updates(message as Relation)) as Relation; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Relation create() => Relation._();
  Relation createEmptyInstance() => create();
  static $pb.PbList<Relation> createRepeated() => $pb.PbList<Relation>();
  @$core.pragma('dart2js:noInline')
  static Relation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Relation>(create);
  static Relation? _defaultInstance;

  @$pb.TagNumber(1)
  LangameUser get firstUser => $_getN(0);
  @$pb.TagNumber(1)
  set firstUser(LangameUser v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFirstUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearFirstUser() => clearField(1);
  @$pb.TagNumber(1)
  LangameUser ensureFirstUser() => $_ensure(0);

  @$pb.TagNumber(2)
  LangameUser get secondUser => $_getN(1);
  @$pb.TagNumber(2)
  set secondUser(LangameUser v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSecondUser() => $_has(1);
  @$pb.TagNumber(2)
  void clearSecondUser() => clearField(2);
  @$pb.TagNumber(2)
  LangameUser ensureSecondUser() => $_ensure(1);

  @$pb.TagNumber(3)
  RelationLevel get level => $_getN(2);
  @$pb.TagNumber(3)
  set level(RelationLevel v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasLevel() => $_has(2);
  @$pb.TagNumber(3)
  void clearLevel() => clearField(3);
}

class LangameNotification extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LangameNotification', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOM<LangameUser>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sender', subBuilder: LangameUser.create)
    ..e<LangameNotification_Type>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: LangameNotification_Type.INVITATION, valueOf: LangameNotification_Type.valueOf, enumValues: LangameNotification_Type.values)
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'background')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topic')
    ..e<RelationLevel>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'relation', $pb.PbFieldType.OE, defaultOrMaker: RelationLevel.BAD, valueOf: RelationLevel.valueOf, enumValues: RelationLevel.values)
    ..hasRequiredFields = false
  ;

  LangameNotification._() : super();
  factory LangameNotification({
    $core.String? id,
    LangameUser? sender,
    LangameNotification_Type? type,
    $core.bool? background,
    $core.String? topic,
    RelationLevel? relation,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (sender != null) {
      _result.sender = sender;
    }
    if (type != null) {
      _result.type = type;
    }
    if (background != null) {
      _result.background = background;
    }
    if (topic != null) {
      _result.topic = topic;
    }
    if (relation != null) {
      _result.relation = relation;
    }
    return _result;
  }
  factory LangameNotification.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LangameNotification.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LangameNotification clone() => LangameNotification()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LangameNotification copyWith(void Function(LangameNotification) updates) => super.copyWith((message) => updates(message as LangameNotification)) as LangameNotification; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LangameNotification create() => LangameNotification._();
  LangameNotification createEmptyInstance() => create();
  static $pb.PbList<LangameNotification> createRepeated() => $pb.PbList<LangameNotification>();
  @$core.pragma('dart2js:noInline')
  static LangameNotification getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LangameNotification>(create);
  static LangameNotification? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  LangameUser get sender => $_getN(1);
  @$pb.TagNumber(2)
  set sender(LangameUser v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSender() => $_has(1);
  @$pb.TagNumber(2)
  void clearSender() => clearField(2);
  @$pb.TagNumber(2)
  LangameUser ensureSender() => $_ensure(1);

  @$pb.TagNumber(3)
  LangameNotification_Type get type => $_getN(2);
  @$pb.TagNumber(3)
  set type(LangameNotification_Type v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get background => $_getBF(3);
  @$pb.TagNumber(4)
  set background($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBackground() => $_has(3);
  @$pb.TagNumber(4)
  void clearBackground() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get topic => $_getSZ(4);
  @$pb.TagNumber(5)
  set topic($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTopic() => $_has(4);
  @$pb.TagNumber(5)
  void clearTopic() => clearField(5);

  @$pb.TagNumber(6)
  RelationLevel get relation => $_getN(5);
  @$pb.TagNumber(6)
  set relation(RelationLevel v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasRelation() => $_has(5);
  @$pb.TagNumber(6)
  void clearRelation() => clearField(6);
}

