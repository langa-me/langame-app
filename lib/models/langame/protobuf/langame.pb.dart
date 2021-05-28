///
//  Generated code. Do not modify.
//  source: langame/protobuf/langame.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../google/protobuf/timestamp.pb.dart' as $0;

export 'langame.pbenum.dart';

class Topic extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Topic', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'content')
    ..hasRequiredFields = false
  ;

  Topic._() : super();
  factory Topic({
    $core.String? id,
    $core.String? content,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (content != null) {
      _result.content = content;
    }
    return _result;
  }
  factory Topic.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Topic.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Topic clone() => Topic()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Topic copyWith(void Function(Topic) updates) => super.copyWith((message) => updates(message as Topic)) as Topic; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Topic create() => Topic._();
  Topic createEmptyInstance() => create();
  static $pb.PbList<Topic> createRepeated() => $pb.PbList<Topic>();
  @$core.pragma('dart2js:noInline')
  static Topic getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Topic>(create);
  static Topic? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get content => $_getSZ(1);
  @$pb.TagNumber(2)
  set content($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasContent() => $_has(1);
  @$pb.TagNumber(2)
  void clearContent() => clearField(2);
}

class Question extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Question', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'content')
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contexts')
    ..hasRequiredFields = false
  ;

  Question._() : super();
  factory Question({
    $core.String? id,
    $core.String? content,
    $core.Iterable<$core.String>? contexts,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (content != null) {
      _result.content = content;
    }
    if (contexts != null) {
      _result.contexts.addAll(contexts);
    }
    return _result;
  }
  factory Question.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Question.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Question clone() => Question()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Question copyWith(void Function(Question) updates) => super.copyWith((message) => updates(message as Question)) as Question; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Question create() => Question._();
  Question createEmptyInstance() => create();
  static $pb.PbList<Question> createRepeated() => $pb.PbList<Question>();
  @$core.pragma('dart2js:noInline')
  static Question getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Question>(create);
  static Question? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get content => $_getSZ(1);
  @$pb.TagNumber(2)
  set content($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasContent() => $_has(1);
  @$pb.TagNumber(2)
  void clearContent() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get contexts => $_getList(2);
}

class Tag extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Tag', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'content')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'score', $pb.PbFieldType.OD)
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'human')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'question')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'generated')
    ..hasRequiredFields = false
  ;

  Tag._() : super();
  factory Tag({
    $core.String? id,
    $core.String? content,
    $core.double? score,
    $core.bool? human,
    $core.String? question,
    $core.bool? generated,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (content != null) {
      _result.content = content;
    }
    if (score != null) {
      _result.score = score;
    }
    if (human != null) {
      _result.human = human;
    }
    if (question != null) {
      _result.question = question;
    }
    if (generated != null) {
      _result.generated = generated;
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

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get content => $_getSZ(1);
  @$pb.TagNumber(2)
  set content($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasContent() => $_has(1);
  @$pb.TagNumber(2)
  void clearContent() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get score => $_getN(2);
  @$pb.TagNumber(3)
  set score($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasScore() => $_has(2);
  @$pb.TagNumber(3)
  void clearScore() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get human => $_getBF(3);
  @$pb.TagNumber(4)
  set human($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHuman() => $_has(3);
  @$pb.TagNumber(4)
  void clearHuman() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get question => $_getSZ(4);
  @$pb.TagNumber(5)
  set question($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasQuestion() => $_has(4);
  @$pb.TagNumber(5)
  void clearQuestion() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get generated => $_getBF(5);
  @$pb.TagNumber(6)
  set generated($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasGenerated() => $_has(5);
  @$pb.TagNumber(6)
  void clearGenerated() => clearField(6);
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

class Langame_Player extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Langame.Player', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOM<$0.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timeIn', subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timeOut', subBuilder: $0.Timestamp.create)
    ..pc<Langame_Note>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes', $pb.PbFieldType.PM, subBuilder: Langame_Note.create)
    ..hasRequiredFields = false
  ;

  Langame_Player._() : super();
  factory Langame_Player({
    $core.String? userId,
    $0.Timestamp? timeIn,
    $0.Timestamp? timeOut,
    $core.Iterable<Langame_Note>? notes,
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
  $core.List<Langame_Note> get notes => $_getList(3);
}

class Langame_Note extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Langame.Note', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'content')
    ..aOM<$0.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false
  ;

  Langame_Note._() : super();
  factory Langame_Note({
    $core.String? content,
    $0.Timestamp? createdAt,
  }) {
    final _result = create();
    if (content != null) {
      _result.content = content;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory Langame_Note.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Langame_Note.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Langame_Note clone() => Langame_Note()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Langame_Note copyWith(void Function(Langame_Note) updates) => super.copyWith((message) => updates(message as Langame_Note)) as Langame_Note; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Langame_Note create() => Langame_Note._();
  Langame_Note createEmptyInstance() => create();
  static $pb.PbList<Langame_Note> createRepeated() => $pb.PbList<Langame_Note>();
  @$core.pragma('dart2js:noInline')
  static Langame_Note getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Langame_Note>(create);
  static Langame_Note? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get content => $_getSZ(0);
  @$pb.TagNumber(1)
  set content($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContent() => $_has(0);
  @$pb.TagNumber(1)
  void clearContent() => clearField(1);

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
}

class Langame extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Langame', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.protobuf'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelName')
    ..pc<Langame_Player>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'players', $pb.PbFieldType.PM, subBuilder: Langame_Player.create)
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topics')
    ..pc<Question>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'questions', $pb.PbFieldType.PM, subBuilder: Question.create)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'initiator')
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'done')
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentQuestion', $pb.PbFieldType.O3)
    ..aOM<$0.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'date', subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false
  ;

  Langame._() : super();
  factory Langame({
    $core.String? channelName,
    $core.Iterable<Langame_Player>? players,
    $core.Iterable<$core.String>? topics,
    $core.Iterable<Question>? questions,
    $core.String? initiator,
    $core.bool? done,
    $core.int? currentQuestion,
    $0.Timestamp? date,
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
    if (questions != null) {
      _result.questions.addAll(questions);
    }
    if (initiator != null) {
      _result.initiator = initiator;
    }
    if (done != null) {
      _result.done = done;
    }
    if (currentQuestion != null) {
      _result.currentQuestion = currentQuestion;
    }
    if (date != null) {
      _result.date = date;
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
  $core.List<Langame_Player> get players => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<$core.String> get topics => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<Question> get questions => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get initiator => $_getSZ(4);
  @$pb.TagNumber(5)
  set initiator($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasInitiator() => $_has(4);
  @$pb.TagNumber(5)
  void clearInitiator() => clearField(5);

  @$pb.TagNumber(7)
  $core.bool get done => $_getBF(5);
  @$pb.TagNumber(7)
  set done($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasDone() => $_has(5);
  @$pb.TagNumber(7)
  void clearDone() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get currentQuestion => $_getIZ(6);
  @$pb.TagNumber(8)
  set currentQuestion($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasCurrentQuestion() => $_has(6);
  @$pb.TagNumber(8)
  void clearCurrentQuestion() => clearField(8);

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

