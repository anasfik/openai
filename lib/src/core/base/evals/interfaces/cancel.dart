import 'package:dart_openai/src/core/models/evals/eval_run.dart';

abstract class CancelInterface {
  Future<OpenAIEvalRun> cancel({
    required String evalId,
    required String runId,
  });
}
