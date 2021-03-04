///
//  Generated code. Do not modify.
//  source: lib/protos/api.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use langameUserDescriptor instead')
const LangameUser$json = const {
  '1': 'LangameUser',
  '2': const [
    const {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'first_name', '3': 2, '4': 1, '5': 9, '10': 'firstName'},
    const {'1': 'last_name', '3': 3, '4': 1, '5': 9, '10': 'lastName'},
    const {'1': 'picture', '3': 4, '4': 1, '5': 9, '10': 'picture'},
    const {'1': 'linked_accounts', '3': 5, '4': 3, '5': 9, '10': 'linkedAccounts'},
    const {'1': 'email', '3': 6, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'phone_number', '3': 7, '4': 1, '5': 9, '10': 'phoneNumber'},
    const {'1': 'email_verified', '3': 8, '4': 1, '5': 8, '10': 'emailVerified'},
  ],
};

/// Descriptor for `LangameUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List langameUserDescriptor = $convert.base64Decode('CgtMYW5nYW1lVXNlchIaCgh1c2VybmFtZRgBIAEoCVIIdXNlcm5hbWUSHQoKZmlyc3RfbmFtZRgCIAEoCVIJZmlyc3ROYW1lEhsKCWxhc3RfbmFtZRgDIAEoCVIIbGFzdE5hbWUSGAoHcGljdHVyZRgEIAEoCVIHcGljdHVyZRInCg9saW5rZWRfYWNjb3VudHMYBSADKAlSDmxpbmtlZEFjY291bnRzEhQKBWVtYWlsGAYgASgJUgVlbWFpbBIhCgxwaG9uZV9udW1iZXIYByABKAlSC3Bob25lTnVtYmVyEiUKDmVtYWlsX3ZlcmlmaWVkGAggASgIUg1lbWFpbFZlcmlmaWVk');
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
