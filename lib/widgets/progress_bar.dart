import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progress;

  ProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsiveness
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.8, // Adjust the width to be responsive (80% of screen width)
      height: 12,
      padding: EdgeInsets.symmetric(horizontal: width * 0.02), // Responsive padding
      decoration: BoxDecoration(
        color: Colors.grey[300], // Background color of the progress bar
        borderRadius: BorderRadius.circular(20), // Rounded corners for a smooth look
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ], // Shadow for a 3D effect
      ),
      child: progress == 0
          ? Center(child: CircularProgressIndicator()) // Show spinner while loading
          : FractionallySizedBox(
        widthFactor: progress, // Determines the width of the progress bar
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500), // Smooth transition
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(0.8),
                Colors.purple.withOpacity(0.8)
              ], // Gradient color for progress
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(20), // Rounded corners for the progress bar
          ),
        ),
      ),
    );
  }
}
