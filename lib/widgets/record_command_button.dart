import 'package:flutter/material.dart';

class RecordCommandButton extends StatefulWidget {
  final ValueChanged<bool> onRecordingStateChanged;

  RecordCommandButton({required this.onRecordingStateChanged});

  @override
  RecordCommandButtonState createState() => RecordCommandButtonState();
}

class RecordCommandButtonState extends State<RecordCommandButton> {
  bool isRecording = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
          width: 60, // Adjust the button size as needed
          height: 60, // Adjust the button size as needed
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isRecording
                ? Colors.red
                : Colors.green, // Green when recording, red when not recording
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              // Toggle recording state
              setState(() {
                isRecording = !isRecording;
              });
              // Call the callback function with the recording state
              widget.onRecordingStateChanged(isRecording);
            },
            child: Center(
              child: Icon(
                Icons.mic, // Microphone icon
                size: 36, // Icon size
                color: Colors.white, // Icon color
              ),
            ),
          ),
        ),
        SizedBox(height: 8), // Add spacing between the button and text
        Text(
          isRecording ? 'Recording...' : 'Record Command',
          style: TextStyle(
            fontSize: 18, // Text size
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
