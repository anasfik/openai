import 'package:dart_openai/src/core/models/graders/grader.dart';
import 'package:dart_openai/src/core/models/graders/label_model_grader.dart';
import 'package:dart_openai/src/core/models/graders/multi_grader.dart';
import 'package:dart_openai/src/core/models/graders/python_grader.dart';
import 'package:dart_openai/src/core/models/graders/score_model_grader.dart';
import 'package:dart_openai/src/core/models/graders/string_check_grader.dart';
import 'package:dart_openai/src/core/models/graders/text_similarity_grader.dart';

class OpenAIGraders {
  static StringCheckGrader stringCheckGrader({
    required String input,
    required String name,
    required String operation,
    required String reference,
    required String type,
  }) {
    return StringCheckGrader(
      input: input,
      name: name,
      operation: operation,
      reference: reference,
      type: type,
    );
  }

  static TextSimilarityGrader textSimilarityGrader({
    required String input,
    required String reference,
    required String evaluationMetric,
    required String name,
    required String type,
  }) {
    return TextSimilarityGrader(
      input: input,
      reference: reference,
      evaluationMetric: evaluationMetric,
      name: name,
      type: type,
    );
  }

  static ScoreModelGrader scoreModelGrader({
    required List input,
    required String model,
    required String name,
    required List range,
    required Map<String, dynamic> samplingParams,
    required String type,
  }) {
    return ScoreModelGrader(
      input: input,
      model: model,
      range: range,
      samplingParams: samplingParams,
      name: name,
      type: type,
    );
  }

  static LabelModelGrader labelModelGrader({
    required String input,
    required String model,
    required List labels,
    required List passingLabels,
    required String name,
    required String type,
  }) {
    return LabelModelGrader(
      input: input,
      model: model,
      labels: labels,
      passingLabels: passingLabels,
      name: name,
      type: type,
    );
  }

  static PythonGrader pythonGrader({
    required String imageTag,
    required String name,
    required String source,
    required String type,
  }) {
    return PythonGrader(
      imageTag: imageTag,
      name: name,
      source: source,
      type: type,
    );
  }

  static MultiGrader multiGrader({
    required List<OpenAiGeneralGrader> graders,
    required String name,
    required String type,
    required String calculateOutput,
  }) {
    return MultiGrader(
      graders: graders,
      name: name,
      type: type,
      calculateOutput: calculateOutput,
    );
  }
}
