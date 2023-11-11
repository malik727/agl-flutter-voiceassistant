import 'dart:async';
import 'package:grpc/grpc.dart';
import './generated/voice_agent.pbgrpc.dart';

class VoiceAgentClient {
  late ClientChannel _channel;
  late VoiceAgentServiceClient _client;

  VoiceAgentClient(String host, int port) {
    // Initialize the client channel without connecting immediately
    _channel = ClientChannel(
      host,
      port: port,
      options: ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );

    _client = VoiceAgentServiceClient(_channel);
  }

  Future<ServiceStatus> checkServiceStatus() async {
    final empty = Empty();
    try {
      final response = await _client.checkServiceStatus(empty);
      return response;
    } catch (e) {
      print('Error calling CheckServiceStatus: $e');
      // Handle the error gracefully, such as returning an error status
      return ServiceStatus()..status = false;
    }
  }

  Stream<WakeWordStatus> detectWakeWord() {
    final empty = Empty();
    try {
      return _client.detectWakeWord(empty);
    } catch (e) {
      print('Error calling DetectWakeWord: $e');
      // Handle the error gracefully, such as returning a default status
      return Stream.empty(); // An empty stream as a placeholder
    }
  }

  Future<RecognizeResult> recognizeVoiceCommand(
      Stream<RecognizeVoiceControl> controlStream) async {
    try {
      final response = await _client.recognizeVoiceCommand(controlStream);
      return response;
    } catch (e) {
      print('Error calling RecognizeVoiceCommand: $e');
      // Handle the error gracefully, such as returning a default RecognizeResult
      return RecognizeResult()..status = RecognizeStatusType.REC_ERROR;
    }
  }

  Future<RecognizeResult> recognizeTextCommand(
      RecognizeTextControl controlInput) async {
    try {
      final response = await _client.recognizeTextCommand(controlInput);
      return response;
    } catch (e) {
      print('Error calling RecognizeTextCommand: $e');
      // Handle the error gracefully, such as returning a default RecognizeResult
      return RecognizeResult()..status = RecognizeStatusType.REC_ERROR;
    }
  }

  Future<ExecuteResult> executeCommand(ExecuteInput input) async {
    try {
      final response = await _client.executeCommand(input);
      return response;
    } catch (e) {
      print('Error calling ExecuteVoiceCommand: $e');
      // Handle the error gracefully, such as returning an error status
      return ExecuteResult()..status = ExecuteStatusType.EXEC_ERROR;
    }
  }

  Future<void> shutdown() async {
    await _channel.shutdown();
  }
}
