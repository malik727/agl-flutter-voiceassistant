import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool isWakeWordDetected = false;
  bool isWakeWordMode = false;
  String intentEngine = "snips";
  String streamId = "";
}
