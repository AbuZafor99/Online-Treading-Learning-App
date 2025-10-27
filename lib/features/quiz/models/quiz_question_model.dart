import 'package:flutter_ladydenily/features/quiz/models/quiz_option_model.dart';

class QuizQuestion {
  final String title;
  final List<QuizOption> options;
  final int correctAnswerIndex;

  QuizQuestion({
    required this.title,
    required this.options,
    required this.correctAnswerIndex,
  });
}
