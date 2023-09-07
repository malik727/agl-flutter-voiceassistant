import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../widgets/nlu_engine_choice.dart';
import '../widgets/assistant_mode_choice.dart';
import '../widgets/record_command_button.dart';
import '../widgets/listen_wake_word_section.dart';
import '../widgets/chat_section.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  List<ChatMessage> chatMessages = [];

  void changeAssistantMode(BuildContext context, AssistantMode newMode) {
    final appState = context.read<AppState>();
    clearChatMessages();
    if (newMode == AssistantMode.wakeWord) {
      appState.isWakeWordMode = true;
      addChatMessage(
          'Switched to Wake Word mode. I\'ll listen for the wake word before responding.');
    } else if (newMode == AssistantMode.manual) {
      appState.isWakeWordMode = false;
      addChatMessage(
          'Switched to Manual mode. You can send commands directly by pressing record button.');
    }
    print(appState.isWakeWordMode);
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

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width:
                MediaQuery.of(context).size.width * 0.7, // 70% of screen width
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/agl_logo.png', // Replace with your logo image path
                  width: 120, // Adjust the width as needed
                  height: 120, // Adjust the height as needed
                ),
                Text(
                  "AGL Voice Assistant",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Card(
                        elevation: 4, // Add elevation for shadow
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
                                        changeAssistantMode(context, newMode);
                                        print(newMode);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 20), // Add spacing between buttons

                    Flexible(
                      flex: 1,
                      child: Card(
                        elevation: 4, // Add elevation for shadow
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
                                        changeIntentEngine(context, newEngine);
                                        print(newEngine);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                ChatSection(
                  scrollController: _scrollController,
                  chatMessages: chatMessages,
                  addChatMessage: addChatMessage,
                ),
                SizedBox(height: 30),
                if (!appState.isWakeWordMode)
                  RecordCommandButton()
                else
                  ListeningForWakeWordSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
