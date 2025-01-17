import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../quiz_provider.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    // Get the screen size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Load questions if they are not loaded yet
    if (quizProvider.questions.isEmpty) {
      quizProvider.loadQuestions();
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quiz",
          style: TextStyle(color: Colors.white),
        ),
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
          padding: EdgeInsets.all(width * 0.04), // Adjust padding based on screen width
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Display question number and total questions
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: Text(
                  "Question ${quizProvider.currentIndex + 1} of ${quizProvider.questions.length}",
                  key: ValueKey<int>(quizProvider.currentIndex),
                  style: TextStyle(fontSize: width * 0.05, color: Colors.white),
                ),
              ),
              SizedBox(height: height * 0.02), // Use screen height for spacing
              // Display current question with transition
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: Text(
                  quizProvider.questions[quizProvider.currentIndex].question,
                  key: ValueKey<int>(quizProvider.currentIndex),
                  style: TextStyle(
                    fontSize: width * 0.06, // Adjust font size based on screen width
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02), // Use screen height for spacing
              // Show options with animations
              Expanded(
                child: ListView.builder(
                  itemCount: quizProvider.questions[quizProvider.currentIndex].options.length,
                  itemBuilder: (context, index) {
                    String option = quizProvider.questions[quizProvider.currentIndex].options[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.015), // Responsive padding
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          padding: EdgeInsets.symmetric(vertical: height * 0.02), // Responsive padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 10,
                          shadowColor: Colors.black.withOpacity(0.6),
                        ),
                        onPressed: () {
                          quizProvider.answerQuestion(index); // Answer question directly
                          if (quizProvider.isLastQuestion) {
                            // Navigate to ResultScreen using the quizProvider's score
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => ResultScreen()),
                            );
                          }
                        },
                        child: Text(
                          option,
                          style: TextStyle(fontSize: width * 0.045, color: Colors.white), // Responsive font size
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
