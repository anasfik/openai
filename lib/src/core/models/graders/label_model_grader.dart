import 'package:dart_openai/src/core/models/graders/grader.dart';

class LabelModelGrader extends OpenAiGeneralGrader {
  final String input;
  final List labels;
  final String model;
  final String name;
  final List passingLabels;
  final String type;

  LabelModelGrader({
    required this.input,
    required this.labels,
    required this.model,
    required this.name,
    required this.passingLabels,
    required this.type,
  });
}
