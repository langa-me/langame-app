///
//  Generated code. Do not modify.
//  source: lib/protos/api.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use langameUserDescriptor instead')
const LangameUser$json = const {
  '1': 'LangameUser',
  '2': const [
    const {'1': 'uid', '3': 1, '4': 1, '5': 9, '10': 'uid'},
    const {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'display_name', '3': 3, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'email_verified', '3': 4, '4': 1, '5': 8, '10': 'emailVerified'},
    const {'1': 'phone_number', '3': 5, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'photo_url', '3': 6, '4': 1, '5': 9, '10': 'photoUrl'},
  ],
};

/// Descriptor for `LangameUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List langameUserDescriptor = $convert.base64Decode('CgtMYW5nYW1lVXNlchIQCgN1aWQYASABKAlSA3VpZBIUCgVlbWFpbBgCIAEoCVIFZW1haWwSIQoMZGlzcGxheV9uYW1lGAMgASgJUgtkaXNwbGF5TmFtZRIlCg5lbWFpbF92ZXJpZmllZBgEIAEoCFINZW1haWxWZXJpZmllZBIhCgxwaG9uZV9udW1iZXIYBSABKAlSC3Bob25lTnVtYmVyEhsKCXBob3RvX3VybBgGIAEoCVIIcGhvdG9Vcmw=');
@$core.Deprecated('Use interestDescriptor instead')
const Interest$json = const {
  '1': 'Interest',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 9, '10': 'value'},
    const {'1': 'sub_interests', '3': 2, '4': 3, '5': 11, '6': '.api.Interest', '10': 'subInterests'},
  ],
};

/// Descriptor for `Interest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List interestDescriptor = $convert.base64Decode('CghJbnRlcmVzdBIUCgV2YWx1ZRgBIAEoCVIFdmFsdWUSMgoNc3ViX2ludGVyZXN0cxgCIAMoCzINLmFwaS5JbnRlcmVzdFIMc3ViSW50ZXJlc3Rz');
