import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool isWakeWordDetected = false;
  bool isWakeWordMode = false;
  String intentEngine = "snips";
  String streamId = "";
  bool isCommandProcessing = false;
  String commandProcessingText = "Processing...";
}
