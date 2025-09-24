import 'package:dart_openai/src/core/models/graders/grader.dart';

class TextSimilarityGrader extends OpenAiGeneralGrader {
  final String evaluationMetric;
  final String input;
  final String name;
  final String reference;
  final String type;

  TextSimilarityGrader({
    required this.evaluationMetric,
    required this.input,
    required this.name,
    required this.reference,
    required this.type,
  });
}
