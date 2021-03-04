///
//  Generated code. Do not modify.
//  source: lib/protos/api.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class LangameUser extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LangameUser', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'username')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'picture')
    ..pPS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'linkedAccounts')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'emailVerified')
    ..hasRequiredFields = false
  ;

  LangameUser._() : super();
  factory LangameUser({
    $core.String username,
    $core.String firstName,
    $core.String lastName,
    $core.String picture,
    $core.Iterable<$core.String> linkedAccounts,
    $core.String email,
    $core.String phoneNumber,
    $core.bool emailVerified,
  }) {
    final _result = create();
    if (username != null) {
      _result.username = username;
    }
    if (firstName != null) {
      _result.firstName = firstName;
    }
    if (lastName != null) {
      _result.lastName = lastName;
    }
    if (picture != null) {
      _result.picture = picture;
    }
    if (linkedAccounts != null) {
      _result.linkedAccounts.addAll(linkedAccounts);
    }
    if (email != null) {
      _result.email = email;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (emailVerified != null) {
      _result.emailVerified = emailVerified;
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
  static LangameUser _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get firstName => $_getSZ(1);
  @$pb.TagNumber(2)
  set firstName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFirstName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFirstName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get lastName => $_getSZ(2);
  @$pb.TagNumber(3)
  set lastName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLastName() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get picture => $_getSZ(3);
  @$pb.TagNumber(4)
  set picture($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPicture() => $_has(3);
  @$pb.TagNumber(4)
  void clearPicture() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.String> get linkedAccounts => $_getList(4);

  @$pb.TagNumber(6)
  $core.String get email => $_getSZ(5);
  @$pb.TagNumber(6)
  set email($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasEmail() => $_has(5);
  @$pb.TagNumber(6)
  void clearEmail() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get phoneNumber => $_getSZ(6);
  @$pb.TagNumber(7)
  set phoneNumber($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPhoneNumber() => $_has(6);
  @$pb.TagNumber(7)
  void clearPhoneNumber() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get emailVerified => $_getBF(7);
  @$pb.TagNumber(8)
  set emailVerified($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasEmailVerified() => $_has(7);
  @$pb.TagNumber(8)
  void clearEmailVerified() => clearField(8);
}

class Interest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Interest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value')
    ..pc<Interest>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subInterests', $pb.PbFieldType.PM, subBuilder: Interest.create)
    ..hasRequiredFields = false
  ;

  Interest._() : super();
  factory Interest({
    $core.String value,
    $core.Iterable<Interest> subInterests,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    if (subInterests != null) {
      _result.subInterests.addAll(subInterests);
    }
    return _result;
  }
  factory Interest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Interest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Interest clone() => Interest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Interest copyWith(void Function(Interest) updates) => super.copyWith((message) => updates(message as Interest)) as Interest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Interest create() => Interest._();
  Interest createEmptyInstance() => create();
  static $pb.PbList<Interest> createRepeated() => $pb.PbList<Interest>();
  @$core.pragma('dart2js:noInline')
  static Interest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Interest>(create);
  static Interest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get value => $_getSZ(0);
  @$pb.TagNumber(1)
  set value($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<Interest> get subInterests => $_getList(1);
}

