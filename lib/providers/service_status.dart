import 'package:flutter/material.dart';

class ServiceStatusProvider extends ChangeNotifier {
  bool _isServiceOnline = false;

  bool get isServiceOnline => _isServiceOnline;

  void setServiceStatus(bool isOnline) {
    _isServiceOnline = isOnline;
    notifyListeners(); // Notify listeners (i.e., widgets that depend on this value) about the change
  }
}
