import 'package:dart_openai/src/core/models/graders/grader.dart';

class MultiGrader extends OpenAiGeneralGrader {
  final String calculateOutput;
  final List<OpenAiGeneralGrader> graders;
  final String name;
  final String type;

  MultiGrader({
    required this.calculateOutput,
    required this.graders,
    required this.name,
    required this.type,
  });
}
