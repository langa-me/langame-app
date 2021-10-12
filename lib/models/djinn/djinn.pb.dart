///
//  Generated code. Do not modify.
//  source: djinn.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class MagnificationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MagnificationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.djinn'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'text')
    ..hasRequiredFields = false
  ;

  MagnificationRequest._() : super();
  factory MagnificationRequest({
    $core.String? text,
  }) {
    final _result = create();
    if (text != null) {
      _result.text = text;
    }
    return _result;
  }
  factory MagnificationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MagnificationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MagnificationRequest clone() => MagnificationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MagnificationRequest copyWith(void Function(MagnificationRequest) updates) => super.copyWith((message) => updates(message as MagnificationRequest)) as MagnificationRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MagnificationRequest create() => MagnificationRequest._();
  MagnificationRequest createEmptyInstance() => create();
  static $pb.PbList<MagnificationRequest> createRepeated() => $pb.PbList<MagnificationRequest>();
  @$core.pragma('dart2js:noInline')
  static MagnificationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MagnificationRequest>(create);
  static MagnificationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => clearField(1);
}

class MagnificationResponse_Sentiment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MagnificationResponse.Sentiment', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.djinn'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'positive', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'negative', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  MagnificationResponse_Sentiment._() : super();
  factory MagnificationResponse_Sentiment({
    $core.double? positive,
    $core.double? negative,
  }) {
    final _result = create();
    if (positive != null) {
      _result.positive = positive;
    }
    if (negative != null) {
      _result.negative = negative;
    }
    return _result;
  }
  factory MagnificationResponse_Sentiment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MagnificationResponse_Sentiment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MagnificationResponse_Sentiment clone() => MagnificationResponse_Sentiment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MagnificationResponse_Sentiment copyWith(void Function(MagnificationResponse_Sentiment) updates) => super.copyWith((message) => updates(message as MagnificationResponse_Sentiment)) as MagnificationResponse_Sentiment; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MagnificationResponse_Sentiment create() => MagnificationResponse_Sentiment._();
  MagnificationResponse_Sentiment createEmptyInstance() => create();
  static $pb.PbList<MagnificationResponse_Sentiment> createRepeated() => $pb.PbList<MagnificationResponse_Sentiment>();
  @$core.pragma('dart2js:noInline')
  static MagnificationResponse_Sentiment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MagnificationResponse_Sentiment>(create);
  static MagnificationResponse_Sentiment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get positive => $_getN(0);
  @$pb.TagNumber(1)
  set positive($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPositive() => $_has(0);
  @$pb.TagNumber(1)
  void clearPositive() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get negative => $_getN(1);
  @$pb.TagNumber(2)
  set negative($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNegative() => $_has(1);
  @$pb.TagNumber(2)
  void clearNegative() => clearField(2);
}

enum MagnificationResponse_Type {
  sentimentResponse, 
  notSet
}

class MagnificationResponse extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, MagnificationResponse_Type> _MagnificationResponse_TypeByTag = {
    2 : MagnificationResponse_Type.sentimentResponse,
    0 : MagnificationResponse_Type.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MagnificationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'langame.djinn'), createEmptyInstance: create)
    ..oo(0, [2])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'text')
    ..aOM<MagnificationResponse_Sentiment>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sentimentResponse', subBuilder: MagnificationResponse_Sentiment.create)
    ..hasRequiredFields = false
  ;

  MagnificationResponse._() : super();
  factory MagnificationResponse({
    $core.String? text,
    MagnificationResponse_Sentiment? sentimentResponse,
  }) {
    final _result = create();
    if (text != null) {
      _result.text = text;
    }
    if (sentimentResponse != null) {
      _result.sentimentResponse = sentimentResponse;
    }
    return _result;
  }
  factory MagnificationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MagnificationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MagnificationResponse clone() => MagnificationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MagnificationResponse copyWith(void Function(MagnificationResponse) updates) => super.copyWith((message) => updates(message as MagnificationResponse)) as MagnificationResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MagnificationResponse create() => MagnificationResponse._();
  MagnificationResponse createEmptyInstance() => create();
  static $pb.PbList<MagnificationResponse> createRepeated() => $pb.PbList<MagnificationResponse>();
  @$core.pragma('dart2js:noInline')
  static MagnificationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MagnificationResponse>(create);
  static MagnificationResponse? _defaultInstance;

  MagnificationResponse_Type whichType() => _MagnificationResponse_TypeByTag[$_whichOneof(0)]!;
  void clearType() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => clearField(1);

  @$pb.TagNumber(2)
  MagnificationResponse_Sentiment get sentimentResponse => $_getN(1);
  @$pb.TagNumber(2)
  set sentimentResponse(MagnificationResponse_Sentiment v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSentimentResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearSentimentResponse() => clearField(2);
  @$pb.TagNumber(2)
  MagnificationResponse_Sentiment ensureSentimentResponse() => $_ensure(1);
}

