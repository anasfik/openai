import 'package:dart_openai/src/core/models/evals/eval.dart';
import 'package:dart_openai/src/core/models/evals/eval_run.dart';
import 'package:dart_openai/src/core/models/evals/eval_run_output_item.dart';
import 'package:dart_openai/src/core/models/evals/eval_run_output_items_list.dart';
import 'package:dart_openai/src/core/models/evals/eval_runs_list.dart';
import 'package:dart_openai/src/core/models/evals/evals_list.dart';

abstract class GetInterface {
  Future<OpenAIEval> get({
    required String evalId,
  });

  Future<OpenAIEvalsList> getEvals({
    String? after,
    int? limit,
    String? order,
    String? orderBy,
  });

  Future<OpenAIEvalRunsList> getRuns({
    required String evalId,
    String? after,
    int? limit,
    String? order,
  });

  Future<OpenAIEvalRun> getRun({
    required String evalId,
    required String runId,
  });

  Future<OpenAIEvalRunOutputItem> getEvalRunOutputItem({
    required String evalId,
    required String outputItemIdn,
    required String runId,
  });

  Future<OpenAIEvalRunOutputItemsList> getEvalRunOutputItems({
    required String evalId,
    required String runId,
    String? after,
    int? limit,
    String? order,
    String? status,
  });
}
