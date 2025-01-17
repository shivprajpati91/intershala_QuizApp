import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../quiz_provider.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    // Get screen size for responsiveness
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Completed", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        elevation: 6,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(width * 0.04), // Responsive padding based on screen width
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  duration: Duration(seconds: 1),
                  child: Text(
                    "Your Score: ${quizProvider.score}",
                    key: ValueKey<int>(quizProvider.score),
                    style: TextStyle(
                      fontSize: width * 0.08, // Adjust font size based on screen width
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.05), // Responsive spacing based on screen height
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    padding: EdgeInsets.symmetric(vertical: height * 0.03, horizontal: width * 0.1), // Responsive button padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 10,
                    shadowColor: Colors.black.withOpacity(0.6),
                  ),
                  onPressed: () {
                    quizProvider.restartQuiz();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  child: Text(
                    "Restart Quiz",
                    style: TextStyle(fontSize: width * 0.05, color: Colors.white), // Responsive font size for button
                  ),
                ),
                SizedBox(height: height * 0.02), // Responsive spacing
                Text(
                  "Thank you for participating!",
                  style: TextStyle(fontSize: width * 0.05, color: Colors.white.withOpacity(0.7)), // Responsive font size for text
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
