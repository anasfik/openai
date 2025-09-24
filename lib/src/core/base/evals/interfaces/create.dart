import 'package:dart_openai/src/core/models/evals/eval.dart';
import 'package:dart_openai/src/core/models/evals/eval_run.dart';
import 'package:dart_openai/src/core/models/evals/eval_run_data_source.dart';
import 'package:dart_openai/src/core/models/evals/req_data_source_config.dart';

abstract class CreateInterface {
  Future<OpenAIEval> create({
    required RequestDatatSourceConfig dataSourceConfig,
    required List testingCriteria,
    Map<String, dynamic>? metadata,
    String? name,
  });

  Future<OpenAIEvalRun> createRun({
    required String evalId,
    required EvalRunDataSource dataSource,
    Map<String, dynamic>? metadata,
    String? name,
  });
}
