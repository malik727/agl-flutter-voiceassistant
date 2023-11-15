// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../models/app_state.dart';

// enum AssistantMode { wakeWord, manual }

// class AssistantModeChoice extends StatefulWidget {
//   final Function(AssistantMode) onModeChanged;

//   const AssistantModeChoice({Key? key, required this.onModeChanged})
//       : super(key: key);

//   @override
//   AssistantModeChoiceState createState() => AssistantModeChoiceState();
// }

// class AssistantModeChoiceState extends State<AssistantModeChoice> {
//   @override
//   Widget build(BuildContext context) {
//     final appState = context.watch<AppState>(); // Watch the app state

//     return SegmentedButton<AssistantMode>(
//       segments: const <ButtonSegment<AssistantMode>>[
//         ButtonSegment<AssistantMode>(
//             value: AssistantMode.wakeWord,
//             label: Text('Wake Word'),
//             icon: Icon(Icons.graphic_eq)),
//         ButtonSegment<AssistantMode>(
//             value: AssistantMode.manual,
//             label: Text('Manual'),
//             icon: Icon(Icons.graphic_eq)),
//       ],
//       selected: <AssistantMode>{
//         appState.isWakeWordMode ? AssistantMode.wakeWord : AssistantMode.manual
//       }, // Use app state
//       onSelectionChanged: (Set<AssistantMode> newSelection) {
//         final newMode = newSelection.first;
//         setState(() {
//           // Update the app state when the mode changes
//           appState.isWakeWordMode = newMode == AssistantMode.wakeWord;
//         });
//         // Call the callback function to notify the mode change
//         widget.onModeChanged(newMode);
//       },
//       style: ButtonStyle(
//           side: MaterialStateProperty.all<BorderSide>(
//             BorderSide(
//               width: 0, // Remove border width
//               color: Colors.transparent, // Make border transparent
//             ),
//           ),
//           backgroundColor: MaterialStateProperty.resolveWith<Color>(
//             (states) {
//               if (states.contains(MaterialState.selected)) {
//                 return Colors.green; // Color when pressed
//               }
//               // Add more conditions for other states as needed
//               return Colors.white; // Default color
//             },
//           ),
//           foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
//             if (states.contains(MaterialState.selected)) {
//               return Colors.white; // Color when pressed
//             }
//             // Add more conditions for other states as needed
//             return Colors.green;
//           })),
//     );
//   }
// }

import 'package:flutter/material.dart';

enum AssistantMode { wakeWord, manual }

class AssistantModeChoice extends StatefulWidget {
  final Function(AssistantMode) onModeChanged;
  final String theme;

  const AssistantModeChoice(
      {Key? key, required this.onModeChanged, required this.theme})
      : super(key: key);

  @override
  AssistantModeChoiceState createState() => AssistantModeChoiceState();
}

class AssistantModeChoiceState extends State<AssistantModeChoice> {
  late AssistantMode _selectedMode;
  late String _theme;

  @override
  void initState() {
    super.initState();
    _selectedMode = AssistantMode.manual; // Initialize the selection
    _theme = widget.theme;
    print(widget.theme);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () => _onModeChanged(AssistantMode.wakeWord),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 17.5, vertical: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              ),
              color: _selectedMode == AssistantMode.wakeWord
                  ? Colors.green
                  : _theme == "dark" || _theme == "textured-dark"
                      ? Colors.black
                      : Colors.white,
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _selectedMode == AssistantMode.wakeWord
                      ? Icons.check
                      : Icons.graphic_eq,
                  color: _selectedMode == AssistantMode.wakeWord
                      ? Colors.white
                      : Colors.green,
                ),
                SizedBox(width: 8),
                Text(
                  'Wake Word',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: _selectedMode == AssistantMode.wakeWord
                        ? Colors.white
                        : Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => _onModeChanged(AssistantMode.manual),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 17.5, vertical: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
              color: _selectedMode == AssistantMode.manual
                  ? Colors.green
                  : _theme == "dark" || _theme == "textured-dark"
                      ? Colors.black
                      : Colors.white,
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _selectedMode == AssistantMode.manual
                      ? Icons.check
                      : Icons.graphic_eq,
                  color: _selectedMode == AssistantMode.manual
                      ? Colors.white
                      : Colors.green,
                ),
                SizedBox(width: 8),
                Text(
                  'Manual',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: _selectedMode == AssistantMode.manual
                        ? Colors.white
                        : Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onModeChanged(AssistantMode newMode) {
    setState(() {
      _selectedMode = newMode;
    });

    // Call the callback function to notify the mode change
    widget.onModeChanged(newMode);
  }
}
