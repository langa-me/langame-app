///
//  Generated code. Do not modify.
//  source: djinn.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use magnificationRequestDescriptor instead')
const MagnificationRequest$json = const {
  '1': 'MagnificationRequest',
  '2': const [
    const {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
  ],
};

/// Descriptor for `MagnificationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List magnificationRequestDescriptor = $convert.base64Decode('ChRNYWduaWZpY2F0aW9uUmVxdWVzdBISCgR0ZXh0GAEgASgJUgR0ZXh0');
@$core.Deprecated('Use magnificationResponseDescriptor instead')
const MagnificationResponse$json = const {
  '1': 'MagnificationResponse',
  '2': const [
    const {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
    const {'1': 'sentiment_response', '3': 2, '4': 1, '5': 11, '6': '.langame.djinn.MagnificationResponse.Sentiment', '9': 0, '10': 'sentimentResponse'},
  ],
  '3': const [MagnificationResponse_Sentiment$json],
  '8': const [
    const {'1': 'type'},
  ],
};

@$core.Deprecated('Use magnificationResponseDescriptor instead')
const MagnificationResponse_Sentiment$json = const {
  '1': 'Sentiment',
  '2': const [
    const {'1': 'positive', '3': 1, '4': 1, '5': 1, '10': 'positive'},
    const {'1': 'negative', '3': 2, '4': 1, '5': 1, '10': 'negative'},
  ],
};

/// Descriptor for `MagnificationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List magnificationResponseDescriptor = $convert.base64Decode('ChVNYWduaWZpY2F0aW9uUmVzcG9uc2USEgoEdGV4dBgBIAEoCVIEdGV4dBJfChJzZW50aW1lbnRfcmVzcG9uc2UYAiABKAsyLi5sYW5nYW1lLmRqaW5uLk1hZ25pZmljYXRpb25SZXNwb25zZS5TZW50aW1lbnRIAFIRc2VudGltZW50UmVzcG9uc2UaQwoJU2VudGltZW50EhoKCHBvc2l0aXZlGAEgASgBUghwb3NpdGl2ZRIaCghuZWdhdGl2ZRgCIAEoAVIIbmVnYXRpdmVCBgoEdHlwZQ==');
