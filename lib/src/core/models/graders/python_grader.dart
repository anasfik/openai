import 'package:dart_openai/src/core/models/graders/grader.dart';

class PythonGrader extends OpenAiGeneralGrader {
  final String imageTag;
  final String name;
  final String source;
  final String type;

  PythonGrader({
    required this.imageTag,
    required this.name,
    required this.source,
    required this.type,
  });
}
