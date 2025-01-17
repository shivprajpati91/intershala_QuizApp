import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/quetions.dart';

class QuizService {
  static const String apiUrl = "https://api.jsonserve.com/Uw5CrX";

  static Future<List<Question>> fetchQuestions() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      // Print the response to check the actual data
      print("API Response: ${response.body}");

      if (response.statusCode == 200) {
        // Check if the response is empty
        if (response.body.isEmpty) {
          throw Exception("API response is empty.");
        }

        // Decode the response body
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        // Check if 'questions' key exists and is a List
        if (jsonData.containsKey('questions') && jsonData['questions'] is List) {
          List<dynamic> questionList = jsonData['questions'];

          // Check if the list is not empty
          if (questionList.isEmpty) {
            throw Exception("No questions available.");
          }

          // Return the list of questions
          return questionList.map((q) => Question.fromJson(q)).toList();
        } else {
          throw Exception("Invalid API response: 'questions' key missing or not a list.");
        }
      } else {
        throw Exception("Failed to load quiz data. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Error fetching data: $e");
    }
  }
}
