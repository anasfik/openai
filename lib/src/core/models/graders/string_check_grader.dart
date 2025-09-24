import 'package:dart_openai/src/core/models/graders/grader.dart';

class StringCheckGrader extends OpenAiGeneralGrader {
  final String input;
  final String name;
  final String operation;
  final String reference;
  final String type;

  StringCheckGrader({
    required this.input,
    required this.name,
    required this.operation,
    required this.reference,
    required this.type,
  });
}
