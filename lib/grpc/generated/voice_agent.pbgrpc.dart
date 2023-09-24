//
//  Generated code. Do not modify.
//  source: voice_agent.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'voice_agent.pb.dart' as $0;

export 'voice_agent.pb.dart';

// @$pb.GrpcServiceName('VoiceAgentService')
class VoiceAgentServiceClient extends $grpc.Client {
  static final _$checkServiceStatus =
      $grpc.ClientMethod<$0.Empty, $0.ServiceStatus>(
          '/VoiceAgentService/CheckServiceStatus',
          ($0.Empty value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.ServiceStatus.fromBuffer(value));
  static final _$detectWakeWord =
      $grpc.ClientMethod<$0.Empty, $0.WakeWordStatus>(
          '/VoiceAgentService/DetectWakeWord',
          ($0.Empty value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.WakeWordStatus.fromBuffer(value));
  static final _$recognizeVoiceCommand =
      $grpc.ClientMethod<$0.RecognizeControl, $0.RecognizeResult>(
          '/VoiceAgentService/RecognizeVoiceCommand',
          ($0.RecognizeControl value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.RecognizeResult.fromBuffer(value));
  static final _$executeVoiceCommand =
      $grpc.ClientMethod<$0.ExecuteInput, $0.ExecuteResult>(
          '/VoiceAgentService/ExecuteVoiceCommand',
          ($0.ExecuteInput value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.ExecuteResult.fromBuffer(value));

  VoiceAgentServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.ServiceStatus> checkServiceStatus($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkServiceStatus, request, options: options);
  }

  $grpc.ResponseStream<$0.WakeWordStatus> detectWakeWord($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$detectWakeWord, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.RecognizeResult> recognizeVoiceCommand(
      $async.Stream<$0.RecognizeControl> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$recognizeVoiceCommand, request,
            options: options)
        .single;
  }

  $grpc.ResponseFuture<$0.ExecuteResult> executeVoiceCommand(
      $0.ExecuteInput request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$executeVoiceCommand, request, options: options);
  }
}

// @$pb.GrpcServiceName('VoiceAgentService')
abstract class VoiceAgentServiceBase extends $grpc.Service {
  $core.String get $name => 'VoiceAgentService';

  VoiceAgentServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.ServiceStatus>(
        'CheckServiceStatus',
        checkServiceStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.ServiceStatus value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.WakeWordStatus>(
        'DetectWakeWord',
        detectWakeWord_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.WakeWordStatus value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RecognizeControl, $0.RecognizeResult>(
        'RecognizeVoiceCommand',
        recognizeVoiceCommand,
        true,
        false,
        ($core.List<$core.int> value) => $0.RecognizeControl.fromBuffer(value),
        ($0.RecognizeResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ExecuteInput, $0.ExecuteResult>(
        'ExecuteVoiceCommand',
        executeVoiceCommand_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ExecuteInput.fromBuffer(value),
        ($0.ExecuteResult value) => value.writeToBuffer()));
  }

  $async.Future<$0.ServiceStatus> checkServiceStatus_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return checkServiceStatus(call, await request);
  }

  $async.Stream<$0.WakeWordStatus> detectWakeWord_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async* {
    yield* detectWakeWord(call, await request);
  }

  $async.Future<$0.ExecuteResult> executeVoiceCommand_Pre(
      $grpc.ServiceCall call, $async.Future<$0.ExecuteInput> request) async {
    return executeVoiceCommand(call, await request);
  }

  $async.Future<$0.ServiceStatus> checkServiceStatus(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Stream<$0.WakeWordStatus> detectWakeWord(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.RecognizeResult> recognizeVoiceCommand(
      $grpc.ServiceCall call, $async.Stream<$0.RecognizeControl> request);
  $async.Future<$0.ExecuteResult> executeVoiceCommand(
      $grpc.ServiceCall call, $0.ExecuteInput request);
}
