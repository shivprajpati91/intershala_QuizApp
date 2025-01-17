class Question {
  final String question; // The question text
  final List<String> options; // List of options
  final int correctAnswerIndex; // Index of the correct answer

  Question({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });

  // Factory constructor to create a Question object from JSON
  factory Question.fromJson(Map<String, dynamic> json) {
    // Ensure options is a list of strings and handle null or missing values gracefully
    List<String> optionsList = (json['options'] as List<dynamic>?)
        ?.map((e) => e.toString())
        .toList() ??
        []; // Default to empty list if 'options' is missing or null

    return Question(
      question: json['description'] ?? 'No description available', // Handle null
      options: optionsList,
      correctAnswerIndex: json['correct_answer'] ?? 0, // Default to 0 if not available
    );
  }
}
