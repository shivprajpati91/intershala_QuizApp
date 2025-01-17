import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/quiz_provider.dart';
import 'package:quizapp/screens/home_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/result_screen.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => QuizProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomeScreen(),
    );
  }
}
