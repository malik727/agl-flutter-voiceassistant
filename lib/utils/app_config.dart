import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';

class AppConfig {
  late String grpcHost;
  late int grpcPort;
  late String theme;

  AppConfig(
      {required this.grpcHost, required this.grpcPort, required this.theme});

  factory AppConfig.fromAsset() {
    return AppConfig._();
  }

  AppConfig._();

  static Future<AppConfig> loadFromAsset() async {
    final configString = await rootBundle.loadString('assets/config.json');
    final jsonMap = json.decode(configString);

    return AppConfig(
      grpcHost: jsonMap['grpc_host'],
      grpcPort: jsonMap['grpc_port'],
      theme: jsonMap['theme'],
    );
  }
}
