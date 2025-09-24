import 'package:dart_openai/src/core/models/graders/grader.dart';

class ScoreModelGrader extends OpenAiGeneralGrader {
  final List input;
  final String model;
  final String name;
  final List range;
  final Map<String, dynamic> samplingParams;
  final String type;

  ScoreModelGrader({
    required this.input,
    required this.model,
    required this.name,
    required this.range,
    required this.samplingParams,
    required this.type,
  });
}
