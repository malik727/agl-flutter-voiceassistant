import 'package:flutter/material.dart';

enum NLUEngine { snips, rasa }

class NLUEngineChoice extends StatefulWidget {
  final Function(NLUEngine) onEngineChanged;

  const NLUEngineChoice({Key? key, required this.onEngineChanged})
      : super(key: key);

  @override
  State<NLUEngineChoice> createState() => _NLUEngineChoiceState();
}

class _NLUEngineChoiceState extends State<NLUEngineChoice> {
  NLUEngine nluView = NLUEngine.snips;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<NLUEngine>(
      segments: const <ButtonSegment<NLUEngine>>[
        ButtonSegment<NLUEngine>(
            value: NLUEngine.snips,
            label: Text('Snips'),
            icon: Icon(Icons.settings_suggest)),
        ButtonSegment<NLUEngine>(
            value: NLUEngine.rasa,
            label: Text('RASA'),
            icon: Icon(Icons.settings_suggest)),
      ],
      selected: <NLUEngine>{nluView},
      onSelectionChanged: (Set<NLUEngine> newSelection) {
        final newEngine = newSelection.first;
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          nluView = newEngine;
        });
        // Call the callback function to notify the mode change
        widget.onEngineChanged(newEngine);
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
