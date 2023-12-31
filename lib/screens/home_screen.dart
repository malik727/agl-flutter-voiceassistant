import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_voiceassistant/widgets/try_commands.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../models/app_state.dart';
import '../widgets/nlu_engine_choice.dart';
import '../widgets/assistant_mode_choice.dart';
import '../widgets/record_command_button.dart';
import '../widgets/listen_wake_word_section.dart';
import '../widgets/chat_section.dart';
import '../grpc/generated/voice_agent.pbgrpc.dart';
import '../grpc/voice_agent_client.dart';
import '../utils/app_config.dart';

class HomePage extends StatefulWidget {
  final AppConfig config;
  final String wakeWord;

  HomePage({Key? key, required this.config, required this.wakeWord});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late AppConfig _config; // Store the config as an instance variable
  late String _wakeWord; // Store the wake word as an instance variable
  final ScrollController _scrollController = ScrollController();
  List<ChatMessage> chatMessages = [];
  StreamSubscription<WakeWordStatus>? _wakeWordStatusSubscription;
  late VoiceAgentClient voiceAgentClient;

  @override
  void initState() {
    super.initState();
    _config = widget.config; // Initialize _config in the initState
    _wakeWord = widget.wakeWord; // Initialize _wakeWord in the initState
    addChatMessage(
        "Assistant in Manual mode. You can send commands directly by pressing the record button.");
  }

  void changeAssistantMode(BuildContext context, AssistantMode newMode) {
    final appState = context.read<AppState>();
    clearChatMessages();
    appState.streamId = "";
    appState.isWakeWordDetected = false;
    appState.isCommandProcessing = false;

    if (newMode == AssistantMode.wakeWord) {
      addChatMessage(
          'Switched to Wake Word mode. I\'ll listen for the wake word "$_wakeWord" before responding.');

      // Close old ongoing wake word detection loop if any
      if (appState.isWakeWordMode) {
        appState.isWakeWordMode = false;
        toggleWakeWordDetection(context, false);
      }
      // Start a new wake word detection loop
      if (!appState.isWakeWordMode) {
        appState.isWakeWordMode = true;
        toggleWakeWordDetection(context, true);
      }
    } else if (newMode == AssistantMode.manual) {
      addChatMessage(
          'Switched to Manual mode. You can send commands directly by pressing record button.');

      // Close old ongoing wake word detection loop if any
      if (appState.isWakeWordMode) {
        appState.isWakeWordMode = false;
        toggleWakeWordDetection(context, false);
      }
    }
    setState(() {}); // Trigger a rebuild
  }

  void changeIntentEngine(BuildContext context, NLUEngine newEngine) {
    final appState = context.read<AppState>();

    if (newEngine == NLUEngine.snips) {
      appState.intentEngine = "snips";
      addChatMessage(
          'Switched to 🚀 Snips engine. Lets be precise and accurate.');
    } else if (newEngine == NLUEngine.rasa) {
      appState.intentEngine = "rasa";
      addChatMessage(
          'Switched to 🤖 RASA engine. Conversations just got smarter!');
    }
    print(appState.intentEngine);
    setState(() {}); // Trigger a rebuild
  }

  void addChatMessage(String text, {bool isUserMessage = false}) {
    final newMessage = ChatMessage(text: text, isUserMessage: isUserMessage);
    setState(() {
      chatMessages.add(newMessage);
    });
    // Use a post-frame callback to scroll after the frame has been rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  // Function to clear all chat messages
  void clearChatMessages() {
    setState(() {
      chatMessages.clear();
    });
  }

  void changeCommandRecordingState(
      BuildContext context, bool isRecording) async {
    final appState = context.read<AppState>();
    if (isRecording) {
      appState.streamId = await startRecording();
    } else {
      appState.commandProcessingText = "Converting speech to text...";
      appState.isCommandProcessing = true;
      setState(
          () {}); // Trigger a rebuild to ensure the loading indicator is shown, tis a bad practice though but deosn't heavily affect the performance
      final response =
          await stopRecording(appState.streamId, appState.intentEngine);
      // Process and store the result
      if (response.status == RecognizeStatusType.REC_SUCCESS) {
        appState.commandProcessingText = "Executing command...";
        await executeCommand(
            response); // Call executeVoiceCommand with the response
      }
      appState.isCommandProcessing = false;
    }
  }

  // gRPC related methods are as follows
  // Function to start and stop the wake word detection loop
  void toggleWakeWordDetection(BuildContext context, bool startDetection) {
    final appState = context.read<AppState>();
    if (startDetection) {
      appState.isWakeWordDetected = false;
      _startWakeWordDetection(context);
    } else {
      _stopWakeWordDetection();
    }
  }

  // Function to start listening for wake word status responses
  void _startWakeWordDetection(BuildContext context) {
    final appState = context.read<AppState>();
    voiceAgentClient = VoiceAgentClient(_config.grpcHost, _config.grpcPort);
    _wakeWordStatusSubscription = voiceAgentClient.detectWakeWord().listen(
      (response) {
        if (response.status) {
          // Wake word detected, you can handle this case here
          // Set _isDetectingWakeWord to false to stop the loop
          _stopWakeWordDetection();
          appState.isWakeWordDetected = true;
          addChatMessage(
              'Wake word detected! Now you can send your command by pressing the record button.');
          setState(() {}); // Trigger a rebuild
        }
      },
      onError: (error) {
        // Handle any errors that occur during wake word detection
        print('Error during wake word detection: $error');
        // Set _isDetectingWakeWord to false to stop the loop
        _stopWakeWordDetection();
      },
      cancelOnError: true,
    );
  }

  // Function to stop listening for wake word status responses
  void _stopWakeWordDetection() {
    _wakeWordStatusSubscription?.cancel();
    voiceAgentClient.shutdown();
  }

  Future<String> startRecording() async {
    String streamId = "";
    voiceAgentClient = VoiceAgentClient(_config.grpcHost, _config.grpcPort);
    try {
      // Create a RecognizeControl message to start recording
      final controlMessage = RecognizeVoiceControl()
        ..action = RecordAction.START
        ..recordMode = RecordMode
            .MANUAL; // You can change this to your desired record mode

      // Create a Stream with the control message
      final controlStream = Stream.fromIterable([controlMessage]);

      // Call the gRPC method to start recording
      final response =
          await voiceAgentClient.recognizeVoiceCommand(controlStream);

      streamId = response.streamId;
    } catch (e) {
      print('Error starting recording: $e');
      addChatMessage('Recording failed. Please try again.');
    }
    return streamId;
  }

  Future<RecognizeResult> stopRecording(
      String streamId, String nluModel) async {
    try {
      NLUModel model = NLUModel.RASA;
      if (nluModel == "snips") {
        model = NLUModel.SNIPS;
      }
      // Create a RecognizeControl message to stop recording
      final controlMessage = RecognizeVoiceControl()
        ..action = RecordAction.STOP
        ..nluModel = model
        ..streamId =
            streamId // Use the same stream ID as when starting recording
        ..recordMode = RecordMode.MANUAL;

      // Create a Stream with the control message
      final controlStream = Stream.fromIterable([controlMessage]);

      // Call the gRPC method to stop recording
      final response =
          await voiceAgentClient.recognizeVoiceCommand(controlStream);

      // Process and store the result
      if (response.status == RecognizeStatusType.REC_SUCCESS) {
        final command = response.command;
        // final intent = response.intent;
        // final intentSlots = response.intentSlots;
        addChatMessage(command, isUserMessage: true);
      } else if (response.status == RecognizeStatusType.INTENT_NOT_RECOGNIZED) {
        final command = response.command;
        addChatMessage(command, isUserMessage: true);
        addChatMessage(
            "Unable to undertsand the intent behind your request. Please try again.");
      } else {
        addChatMessage(
            'Failed to process your voice command. Please try again.');
      }
      await voiceAgentClient.shutdown();
      return response;
    } catch (e) {
      print('Error stopping recording: $e');
      addChatMessage('Failed to process your voice command. Please try again.');
      await voiceAgentClient.shutdown();
      return RecognizeResult()..status = RecognizeStatusType.REC_ERROR;
    }
    // await voiceAgentClient.shutdown();
  }

  Future<RecognizeResult> recognizeTextCommand(
      String command, String nluModel) async {
    voiceAgentClient = VoiceAgentClient(_config.grpcHost, _config.grpcPort);
    try {
      NLUModel model = NLUModel.RASA;
      if (nluModel == "snips") {
        model = NLUModel.SNIPS;
      }
      // Create a RecognizeControl message to stop recording
      final controlMessage = RecognizeTextControl()
        ..textCommand = command
        ..nluModel = model;

      // Call the gRPC method to stop recording
      final response =
          await voiceAgentClient.recognizeTextCommand(controlMessage);

      // Process and store the result
      if (response.status == RecognizeStatusType.REC_SUCCESS) {
        // Do nothing
      } else if (response.status == RecognizeStatusType.INTENT_NOT_RECOGNIZED) {
        final command = response.command;
        addChatMessage(command, isUserMessage: true);
        addChatMessage(
            "Unable to undertsand the intent behind your request. Please try again.");
      } else {
        addChatMessage(
            'Failed to process your text command. Please try again.');
      }
      await voiceAgentClient.shutdown();
      return response;
    } catch (e) {
      print('Error encountered during text command recognition: $e');
      addChatMessage('Failed to process your text command. Please try again.');
      await voiceAgentClient.shutdown();
      return RecognizeResult()..status = RecognizeStatusType.REC_ERROR;
    }
  }

  Future<void> executeCommand(RecognizeResult response) async {
    voiceAgentClient = VoiceAgentClient(_config.grpcHost, _config.grpcPort);
    try {
      // Create an ExecuteInput message using the response from stopRecording
      final executeInput = ExecuteInput()
        ..intent = response.intent
        ..intentSlots.addAll(response.intentSlots);

      // Call the gRPC method to execute the voice command
      final execResponse = await voiceAgentClient.executeCommand(executeInput);

      // Handle the response as needed
      if (execResponse.status == ExecuteStatusType.EXEC_SUCCESS) {
        final commandResponse = execResponse.response;
        addChatMessage(commandResponse);
      } else if (execResponse.status == ExecuteStatusType.KUKSA_CONN_ERROR) {
        final commandResponse = execResponse.response;
        addChatMessage(commandResponse);
      } else {
        // Handle the case when execution fails
        addChatMessage(
            'Failed to execute your voice command. Please try again.');
      }
    } catch (e) {
      print('Error executing voice command: $e');
      // Handle any errors that occur during the gRPC call
      addChatMessage('Failed to execute your voice command. Please try again.');
    }
    await voiceAgentClient.shutdown();
  }

  Future<void> handleCommandTap(String command) async {
    final appState = context.read<AppState>();
    addChatMessage(command, isUserMessage: true);
    appState.isCommandProcessing = true;
    appState.commandProcessingText = "Recognizing intent...";

    setState(
        () {}); // Trigger a rebuild to ensure the loading indicator is shown, tis a bad practice though but deosn't heavily affect the performance

    final response = await recognizeTextCommand(command, appState.intentEngine);
    // Process and store the result
    if (response.status == RecognizeStatusType.REC_SUCCESS) {
      appState.commandProcessingText = "Executing command...";
      setState(
          () {}); // Trigger a rebuild to ensure the loading indicator is shown, tis a bad practice though but deosn't heavily affect the performance
      await executeCommand(
          response); // Call executeVoiceCommand with the response
    }

    appState.isCommandProcessing = false;
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width:
                MediaQuery.of(context).size.width * 0.85, // 85% of screen width
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: 25,
                      bottom: 25), // Adjust the top and bottom margin as needed
                  child: Image.asset(
                    _config.theme == "dark" || _config.theme == "textured-dark"
                        ? 'assets/agl_logo_darkmode.png'
                        : 'assets/agl_logo_lightmode.png',
                    width: 300,
                    fit: BoxFit
                        .contain, // Ensure the image fits within the specified dimensions
                  ),
                ),
                Text(
                  "Voice Assistant",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Card(
                            color: _config.theme == "textured-dark" ||
                                    _config.theme == "textured-light"
                                ? Colors.transparent
                                : null,
                            elevation: 4, // Add elevation for shadow
                            shadowColor: _config.theme == "textured-dark" ||
                                    _config.theme == "textured-light"
                                ? Colors.transparent
                                : null,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Assistant Mode',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 16), // Add spacing if needed
                                  Center(
                                    child: Consumer<AppState>(
                                      builder: (context, appState, _) {
                                        return AssistantModeChoice(
                                          onModeChanged: (newMode) {
                                            changeAssistantMode(
                                                context, newMode);
                                            print(newMode);
                                          },
                                          theme: _config.theme,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 20), // Add spacing between buttons

                    Flexible(
                      flex: 1,
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Card(
                            color: _config.theme == "textured-dark" ||
                                    _config.theme == "textured-light"
                                ? Colors.transparent
                                : null,
                            elevation: 4, // Add elevation for shadow
                            shadowColor: _config.theme == "textured-dark" ||
                                    _config.theme == "textured-light"
                                ? Colors.transparent
                                : null,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Intent Engine',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 16), // Add spacing if needed
                                  Center(
                                    child: Consumer<AppState>(
                                      builder: (context, appState, _) {
                                        return NLUEngineChoice(
                                          onEngineChanged: (newEngine) {
                                            changeIntentEngine(
                                                context, newEngine);
                                            print(newEngine);
                                          },
                                          theme: _config.theme,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                ChatSection(
                  scrollController: _scrollController,
                  chatMessages: chatMessages,
                  addChatMessage: addChatMessage,
                  theme: _config.theme,
                ),
                SizedBox(height: 10),
                if (!appState.isWakeWordMode || appState.isWakeWordDetected)
                  TryCommandsSection(
                      onCommandTap: handleCommandTap, theme: _config.theme),
                SizedBox(height: 30),
                if (!appState.isWakeWordMode || appState.isWakeWordDetected)
                  if (!appState.isCommandProcessing)
                    Center(
                      child:
                          Consumer<AppState>(builder: (context, appState, _) {
                        return RecordCommandButton(
                          onRecordingStateChanged: (isRecording) {
                            changeCommandRecordingState(context, isRecording);
                          },
                        );
                      }),
                    )
                  else
                    Column(children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                      SizedBox(height: 12),
                      Center(
                        child: Text(
                          appState.commandProcessingText,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ])
                else
                  Center(
                    child: Consumer<AppState>(
                      builder: (context, appState, _) {
                        return ListeningForWakeWordSection();
                      },
                    ),
                  ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
