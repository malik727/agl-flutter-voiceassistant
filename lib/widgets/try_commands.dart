import 'package:flutter/material.dart';

class TryCommandsSection extends StatelessWidget {
  final Future<void> Function(String) onCommandTap; // Define a callback

  TryCommandsSection({required this.onCommandTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Card(
          // padding: EdgeInsets.all(16),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(12),
          // ),
          elevation: 4, // Add a subtle shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                child: Text(
                  "Try Commands",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Text(
                  "(Tap on any of the following commands to try them out)",
                  style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 6),
              Container(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: Wrap(
                  spacing: 10,
                  children: [
                    buildCommandButton("Set the volume to fifty percent"),
                    buildCommandButton("Set the fan speed to max"),
                    buildCommandButton(
                        "Increase the temperature by three degrees"),
                    buildCommandButton(
                        "Decrease the fan speed by five percent"),
                    buildCommandButton("Can you reduce the volume"),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildCommandButton(String commandText) {
    return GestureDetector(
      onTap: () {
        onCommandTap(commandText);
      },
      child: Container(
        margin: EdgeInsets.all(6),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green, width: 2),
        ),
        child: Text(
          commandText,
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
