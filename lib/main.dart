import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/app_state.dart';
import 'screens/home_screen.dart';
import 'screens/error_screen.dart';
import 'providers/service_status.dart';
import 'grpc/generated/voice_agent.pbgrpc.dart';
import 'grpc/voice_agent_client.dart';
import 'utils/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final serviceStatusProvider = ServiceStatusProvider();

  // get config variables
  final config = await AppConfig.loadFromAsset();

  // Check the service status initially
  final initialServiceStatus = await checkServiceStatus(config);
  serviceStatusProvider.setServiceStatus(initialServiceStatus.status);
  serviceStatusProvider.setWakeWord(initialServiceStatus.wakeWord);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider.value(value: serviceStatusProvider),
      ],
      child: App(
        config: config,
        onRetry: () async {
          final serviceStatus = await checkServiceStatus(
              config); // Retry connecting to the server

          if (serviceStatus.status) {
            serviceStatusProvider
                .setServiceStatus(true); // Update the service status

            serviceStatusProvider
                .setWakeWord(serviceStatus.wakeWord); // Update the wake word
          }
        },
      ),
    ),
  );
}

Future<ServiceStatus> checkServiceStatus(AppConfig config) async {
  final client = VoiceAgentClient(config.grpcHost, config.grpcPort);
  final serviceStatus = await client.checkServiceStatus();
  client.shutdown();
  return serviceStatus;
}

class App extends StatelessWidget {
  final AppConfig config;
  final VoidCallback onRetry;

  const App({Key? key, required this.config, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AGL Voice Assistant',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: Consumer<ServiceStatusProvider>(
        builder: (context, provider, child) {
          return provider.isServiceOnline
              ? HomePage(config: config, wakeWord: provider.wakeWord)
              : ErrorScreen(
                  onRetry: onRetry, // Pass the callback to the ErrorScreen
                ); // Conditionally render HomePage or ErrorScreen
        },
      ),
    );
  }
}
