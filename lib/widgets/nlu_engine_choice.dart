// import 'package:flutter/material.dart';

// enum NLUEngine { snips, rasa }

// class NLUEngineChoice extends StatefulWidget {
//   final Function(NLUEngine) onEngineChanged;

//   const NLUEngineChoice({Key? key, required this.onEngineChanged})
//       : super(key: key);

//   @override
//   State<NLUEngineChoice> createState() => _NLUEngineChoiceState();
// }

// class _NLUEngineChoiceState extends State<NLUEngineChoice> {
//   NLUEngine nluView = NLUEngine.snips;

//   @override
//   Widget build(BuildContext context) {
//     return SegmentedButton<NLUEngine>(
//       segments: const <ButtonSegment<NLUEngine>>[
//         ButtonSegment<NLUEngine>(
//             value: NLUEngine.snips,
//             label: Text('Snips'),
//             icon: Icon(Icons.settings_suggest)),
//         ButtonSegment<NLUEngine>(
//             value: NLUEngine.rasa,
//             label: Text('RASA'),
//             icon: Icon(Icons.settings_suggest)),
//       ],
//       selected: <NLUEngine>{nluView},
//       onSelectionChanged: (Set<NLUEngine> newSelection) {
//         final newEngine = newSelection.first;
//         setState(() {
//           // By default there is only a single segment that can be
//           // selected at one time, so its value is always the first
//           // item in the selected set.
//           nluView = newEngine;
//         });
//         // Call the callback function to notify the mode change
//         widget.onEngineChanged(newEngine);
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

enum NLUEngine { snips, rasa }

class NLUEngineChoice extends StatefulWidget {
  final Function(NLUEngine) onEngineChanged;

  const NLUEngineChoice({Key? key, required this.onEngineChanged})
      : super(key: key);

  @override
  State<NLUEngineChoice> createState() => _NLUEngineChoiceState();
}

class _NLUEngineChoiceState extends State<NLUEngineChoice> {
  late NLUEngine _selectedEngine;

  @override
  void initState() {
    super.initState();
    _selectedEngine = NLUEngine.snips; // Initialize the selection
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () => _onEngineChanged(NLUEngine.snips),
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
              color: _selectedEngine == NLUEngine.snips
                  ? Colors.green
                  : Colors.white,
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _selectedEngine == NLUEngine.snips
                      ? Icons.check
                      : Icons.settings_suggest,
                  color: _selectedEngine == NLUEngine.snips
                      ? Colors.white
                      : Colors.green,
                ),
                SizedBox(width: 8),
                Text(
                  'Snips',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _selectedEngine == NLUEngine.snips
                        ? Colors.white
                        : Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => _onEngineChanged(NLUEngine.rasa),
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
              color: _selectedEngine == NLUEngine.rasa
                  ? Colors.green
                  : Colors.white,
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _selectedEngine == NLUEngine.rasa
                      ? Icons.check
                      : Icons.settings_suggest,
                  color: _selectedEngine == NLUEngine.rasa
                      ? Colors.white
                      : Colors.green,
                ),
                SizedBox(width: 8),
                Text(
                  'RASA',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _selectedEngine == NLUEngine.rasa
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

  void _onEngineChanged(NLUEngine newEngine) {
    setState(() {
      _selectedEngine = newEngine;
    });

    // Call the callback function to notify the engine change
    widget.onEngineChanged(newEngine);
  }
}
