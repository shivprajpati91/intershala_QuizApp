import 'package:flutter/material.dart';
import '../models/quetions.dart';
import '../sevices/quiz_service.dart';

class QuizProvider extends ChangeNotifier {
  List<Question> _questions = [];
  int _currentIndex = 0;
  int _score = 0;

  List<Question> get questions => _questions;
  int get currentIndex => _currentIndex;
  int get score => _score;
  bool get isLastQuestion => _currentIndex == _questions.length - 1;

  // Load the questions from the service
  Future<void> loadQuestions() async {
    try {
      _questions = await QuizService.fetchQuestions();
      notifyListeners();
    } catch (e) {
      print("Error loading questions: $e");
    }
  }

  // Answer the question
  void answerQuestion(int selectedIndex) {
    if (_questions[_currentIndex].correctAnswerIndex == selectedIndex) {
      _score += 10; // Increment score for correct answer
    }

    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  // Restart the quiz
  void restartQuiz() {
    _currentIndex = 0;
    _score = 0;
    notifyListeners();
  }
}
