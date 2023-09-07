import 'package:flutter/material.dart';

class ListeningForWakeWordSection extends StatefulWidget {
  @override
  _ListeningForWakeWordSectionState createState() =>
      _ListeningForWakeWordSectionState();
}

class _ListeningForWakeWordSectionState
    extends State<ListeningForWakeWordSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    // Create an animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500), // Adjust the duration as needed
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
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
            return ScaleTransition(
              scale: _scaleAnimation,
              child: Icon(
                Icons.album, // Replace with your listening icon
                size: 60,
                color: _colorAnimation.value,
              ),
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
