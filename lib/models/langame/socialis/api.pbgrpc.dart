///
//  Generated code. Do not modify.
//  source: api.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'api.pb.dart' as $0;
export 'api.pb.dart';

class SocialisClient extends $grpc.Client {
  static final _$addPlayers = $grpc.ClientMethod<$0.AddPlayersRequest, $0.Game>(
      '/langame.socialis.Socialis/AddPlayers',
      ($0.AddPlayersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Game.fromBuffer(value));
  static final _$validatePlayers =
      $grpc.ClientMethod<$0.ValidatePlayersRequest, $0.Game>(
          '/langame.socialis.Socialis/ValidatePlayers',
          ($0.ValidatePlayersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Game.fromBuffer(value));

  SocialisClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Game> addPlayers($0.AddPlayersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addPlayers, request, options: options);
  }

  $grpc.ResponseFuture<$0.Game> validatePlayers(
      $0.ValidatePlayersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validatePlayers, request, options: options);
  }
}

abstract class SocialisServiceBase extends $grpc.Service {
  $core.String get $name => 'langame.socialis.Socialis';

  SocialisServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.AddPlayersRequest, $0.Game>(
        'AddPlayers',
        addPlayers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AddPlayersRequest.fromBuffer(value),
        ($0.Game value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ValidatePlayersRequest, $0.Game>(
        'ValidatePlayers',
        validatePlayers_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ValidatePlayersRequest.fromBuffer(value),
        ($0.Game value) => value.writeToBuffer()));
  }

  $async.Future<$0.Game> addPlayers_Pre($grpc.ServiceCall call,
      $async.Future<$0.AddPlayersRequest> request) async {
    return addPlayers(call, await request);
  }

  $async.Future<$0.Game> validatePlayers_Pre($grpc.ServiceCall call,
      $async.Future<$0.ValidatePlayersRequest> request) async {
    return validatePlayers(call, await request);
  }

  $async.Future<$0.Game> addPlayers(
      $grpc.ServiceCall call, $0.AddPlayersRequest request);
  $async.Future<$0.Game> validatePlayers(
      $grpc.ServiceCall call, $0.ValidatePlayersRequest request);
}
