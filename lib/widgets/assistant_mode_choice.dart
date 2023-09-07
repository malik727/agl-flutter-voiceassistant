import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';

enum AssistantMode { wakeWord, manual }

class AssistantModeChoice extends StatefulWidget {
  final Function(AssistantMode) onModeChanged;

  const AssistantModeChoice({Key? key, required this.onModeChanged})
      : super(key: key);

  @override
  _AssistantModeChoiceState createState() => _AssistantModeChoiceState();
}

class _AssistantModeChoiceState extends State<AssistantModeChoice> {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>(); // Watch the app state

    return SegmentedButton<AssistantMode>(
      segments: const <ButtonSegment<AssistantMode>>[
        ButtonSegment<AssistantMode>(
            value: AssistantMode.wakeWord,
            label: Text('Wake Word'),
            icon: Icon(Icons.graphic_eq)),
        ButtonSegment<AssistantMode>(
            value: AssistantMode.manual,
            label: Text('Manual'),
            icon: Icon(Icons.graphic_eq)),
      ],
      selected: <AssistantMode>{
        appState.isWakeWordMode ? AssistantMode.wakeWord : AssistantMode.manual
      }, // Use app state
      onSelectionChanged: (Set<AssistantMode> newSelection) {
        final newMode = newSelection.first;
        setState(() {
          // Update the app state when the mode changes
          appState.isWakeWordMode = newMode == AssistantMode.wakeWord;
        });
        // Call the callback function to notify the mode change
        widget.onModeChanged(newMode);
      },
      style: ButtonStyle(
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
              width: 0, // Remove border width
              color: Colors.transparent, // Make border transparent
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.green; // Color when pressed
              }
              // Add more conditions for other states as needed
              return Colors.white; // Default color
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.white; // Color when pressed
            }
            // Add more conditions for other states as needed
            return Colors.green;
          })),
    );
  }
}
