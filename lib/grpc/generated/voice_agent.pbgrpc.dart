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
  static final _$s_DetectWakeWord =
      $grpc.ClientMethod<$0.VoiceAudio, $0.WakeWordStatus>(
          '/VoiceAgentService/S_DetectWakeWord',
          ($0.VoiceAudio value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.WakeWordStatus.fromBuffer(value));
  static final _$detectWakeWord =
      $grpc.ClientMethod<$0.Empty, $0.WakeWordStatus>(
          '/VoiceAgentService/DetectWakeWord',
          ($0.Empty value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.WakeWordStatus.fromBuffer(value));
  static final _$s_RecognizeVoiceCommand =
      $grpc.ClientMethod<$0.S_RecognizeVoiceControl, $0.RecognizeResult>(
          '/VoiceAgentService/S_RecognizeVoiceCommand',
          ($0.S_RecognizeVoiceControl value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.RecognizeResult.fromBuffer(value));
  static final _$recognizeVoiceCommand =
      $grpc.ClientMethod<$0.RecognizeVoiceControl, $0.RecognizeResult>(
          '/VoiceAgentService/RecognizeVoiceCommand',
          ($0.RecognizeVoiceControl value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.RecognizeResult.fromBuffer(value));
  static final _$recognizeTextCommand =
      $grpc.ClientMethod<$0.RecognizeTextControl, $0.RecognizeResult>(
          '/VoiceAgentService/RecognizeTextCommand',
          ($0.RecognizeTextControl value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.RecognizeResult.fromBuffer(value));
  static final _$executeCommand =
      $grpc.ClientMethod<$0.ExecuteInput, $0.ExecuteResult>(
          '/VoiceAgentService/ExecuteCommand',
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

  $grpc.ResponseStream<$0.WakeWordStatus> s_DetectWakeWord(
      $async.Stream<$0.VoiceAudio> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$s_DetectWakeWord, request, options: options);
  }

  $grpc.ResponseStream<$0.WakeWordStatus> detectWakeWord($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$detectWakeWord, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.RecognizeResult> s_RecognizeVoiceCommand(
      $async.Stream<$0.S_RecognizeVoiceControl> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$s_RecognizeVoiceCommand, request,
            options: options)
        .single;
  }

  $grpc.ResponseFuture<$0.RecognizeResult> recognizeVoiceCommand(
      $async.Stream<$0.RecognizeVoiceControl> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$recognizeVoiceCommand, request,
            options: options)
        .single;
  }

  $grpc.ResponseFuture<$0.RecognizeResult> recognizeTextCommand(
      $0.RecognizeTextControl request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$recognizeTextCommand, request, options: options);
  }

  $grpc.ResponseFuture<$0.ExecuteResult> executeCommand($0.ExecuteInput request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$executeCommand, request, options: options);
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
    $addMethod($grpc.ServiceMethod<$0.VoiceAudio, $0.WakeWordStatus>(
        'S_DetectWakeWord',
        s_DetectWakeWord,
        true,
        true,
        ($core.List<$core.int> value) => $0.VoiceAudio.fromBuffer(value),
        ($0.WakeWordStatus value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.WakeWordStatus>(
        'DetectWakeWord',
        detectWakeWord_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.WakeWordStatus value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.S_RecognizeVoiceControl, $0.RecognizeResult>(
            'S_RecognizeVoiceCommand',
            s_RecognizeVoiceCommand,
            true,
            false,
            ($core.List<$core.int> value) =>
                $0.S_RecognizeVoiceControl.fromBuffer(value),
            ($0.RecognizeResult value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.RecognizeVoiceControl, $0.RecognizeResult>(
            'RecognizeVoiceCommand',
            recognizeVoiceCommand,
            true,
            false,
            ($core.List<$core.int> value) =>
                $0.RecognizeVoiceControl.fromBuffer(value),
            ($0.RecognizeResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RecognizeTextControl, $0.RecognizeResult>(
        'RecognizeTextCommand',
        recognizeTextCommand_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RecognizeTextControl.fromBuffer(value),
        ($0.RecognizeResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ExecuteInput, $0.ExecuteResult>(
        'ExecuteCommand',
        executeCommand_Pre,
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

  $async.Future<$0.RecognizeResult> recognizeTextCommand_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RecognizeTextControl> request) async {
    return recognizeTextCommand(call, await request);
  }

  $async.Future<$0.ExecuteResult> executeCommand_Pre(
      $grpc.ServiceCall call, $async.Future<$0.ExecuteInput> request) async {
    return executeCommand(call, await request);
  }

  $async.Future<$0.ServiceStatus> checkServiceStatus(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Stream<$0.WakeWordStatus> s_DetectWakeWord(
      $grpc.ServiceCall call, $async.Stream<$0.VoiceAudio> request);
  $async.Stream<$0.WakeWordStatus> detectWakeWord(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.RecognizeResult> s_RecognizeVoiceCommand(
      $grpc.ServiceCall call,
      $async.Stream<$0.S_RecognizeVoiceControl> request);
  $async.Future<$0.RecognizeResult> recognizeVoiceCommand(
      $grpc.ServiceCall call, $async.Stream<$0.RecognizeVoiceControl> request);
  $async.Future<$0.RecognizeResult> recognizeTextCommand(
      $grpc.ServiceCall call, $0.RecognizeTextControl request);
  $async.Future<$0.ExecuteResult> executeCommand(
      $grpc.ServiceCall call, $0.ExecuteInput request);
}
