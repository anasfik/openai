import 'package:dart_openai/src/core/models/evals/eval.dart';

abstract class UpdateInterface {
  /// Update an existing eval.
  Future<OpenAIEval> update({
    required String evalId,
    Map<String, dynamic>? metadata,
    String? name,
  });
}
