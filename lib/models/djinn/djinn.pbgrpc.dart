///
//  Generated code. Do not modify.
//  source: djinn.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'djinn.pb.dart' as $0;
export 'djinn.pb.dart';

class ConversationMagnifierClient extends $grpc.Client {
  static final _$magnify =
      $grpc.ClientMethod<$0.MagnificationRequest, $0.MagnificationResponse>(
          '/langame.djinn.ConversationMagnifier/Magnify',
          ($0.MagnificationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.MagnificationResponse.fromBuffer(value));

  ConversationMagnifierClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.MagnificationResponse> magnify(
      $async.Stream<$0.MagnificationRequest> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$magnify, request, options: options);
  }
}

abstract class ConversationMagnifierServiceBase extends $grpc.Service {
  $core.String get $name => 'langame.djinn.ConversationMagnifier';

  ConversationMagnifierServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.MagnificationRequest, $0.MagnificationResponse>(
            'Magnify',
            magnify,
            true,
            true,
            ($core.List<$core.int> value) =>
                $0.MagnificationRequest.fromBuffer(value),
            ($0.MagnificationResponse value) => value.writeToBuffer()));
  }

  $async.Stream<$0.MagnificationResponse> magnify(
      $grpc.ServiceCall call, $async.Stream<$0.MagnificationRequest> request);
}
