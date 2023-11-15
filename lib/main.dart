import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      title: 'Voice Assistant',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: config.theme == "dark" || config.theme == "textured-dark"
            ? ColorScheme.dark(
                primary: Colors.green,
                onPrimary: Colors.black, // Text color on the primary background
                secondary: Colors.greenAccent,
                onSecondary:
                    Colors.black, // Text color on the secondary background
              )
            : ColorScheme.light(
                primary: Colors.green,
                onPrimary: Colors.white, // Text color on the primary background
                secondary: Colors.greenAccent,
                onSecondary:
                    Colors.white, // Text color on the secondary background
              ),
      ),
      home: Stack(
        children: [
          Container(
            color: config.theme == "dark" || config.theme == "textured-dark"
                ? Colors.black
                : Colors
                    .white, // Set the background color based on dark or light mode
            width: double.infinity,
            height: double.infinity,
          ),
          if (config.theme == 'textured-dark' ||
              config.theme == 'textured-light')
            SvgPicture.asset(
              'assets/background_texture.svg',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.contain,
            ),
          Consumer<ServiceStatusProvider>(
            builder: (context, provider, child) {
              return provider.isServiceOnline
                  ? HomePage(config: config, wakeWord: provider.wakeWord)
                  : ErrorScreen(
                      onRetry: onRetry,
                    );
            },
          ),
        ],
      ),
    );
  }
}
