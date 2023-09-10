import 'package:flutter/material.dart';

class ListeningForWakeWordSection extends StatefulWidget {
  @override
  ListeningForWakeWordSectionState createState() =>
      ListeningForWakeWordSectionState();
}

class ListeningForWakeWordSectionState
    extends State<ListeningForWakeWordSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    // Create an animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500), // Adjust the duration as needed
    );

    // Create a color change animation
    _colorAnimation = ColorTween(
      begin: Colors.orangeAccent, // Use your desired initial color
      end: Colors.redAccent, // Use your desired final color
    ).animate(_controller);

    // Start both animations
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Icon(
              Icons.album, // Replace with your listening icon
              size: 60,
              color: _colorAnimation.value,
            );
          },
        ),
        SizedBox(height: 8),
        Text(
          'Listening for wake word...',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
