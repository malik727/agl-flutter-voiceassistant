import 'package:flutter/material.dart';

class ServiceStatusProvider extends ChangeNotifier {
  bool _isServiceOnline = false;
  String _wakeWord = '';

  bool get isServiceOnline => _isServiceOnline;
  String get wakeWord => _wakeWord;

  void setServiceStatus(bool isOnline) {
    _isServiceOnline = isOnline;
    notifyListeners(); // Notify listeners (i.e., widgets that depend on this value) about the change
  }

  void setWakeWord(String wakeWord) {
    _wakeWord = wakeWord;
    notifyListeners(); // Notify listeners (i.e., widgets that depend on this value) about the change
  }
}
