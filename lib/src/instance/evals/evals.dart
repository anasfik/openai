import 'package:dart_openai/src/core/base/evals/evals.dart';
import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/models/conversation/conversation.dart';
import 'package:dart_openai/src/core/models/evals/eval.dart';
import 'package:dart_openai/src/core/models/evals/eval_run.dart';
import 'package:dart_openai/src/core/models/evals/eval_run_data_source.dart';
import 'package:dart_openai/src/core/models/evals/eval_run_output_item.dart';
import 'package:dart_openai/src/core/models/evals/eval_run_output_items_list.dart';
import 'package:dart_openai/src/core/models/evals/eval_runs_list.dart';
import 'package:dart_openai/src/core/models/evals/evals_list.dart';
import 'package:dart_openai/src/core/models/evals/req_data_source_config.dart';
import 'package:dart_openai/src/core/utils/logger.dart';

class OpenAIEvals implements OpenAIEvalsBase {
  @override
  String get endpoint => OpenAIStrings.endpoints.evals;

  /// {@macro openai_embedding}
  OpenAIEvals() {
    OpenAILogger.logEndpoint(endpoint);
  }

  @override
  Future<OpenAIEvalRun> cancel(
      {required String evalId, required String runId}) {
    // TODO: implement cancel
    throw UnimplementedError();
  }

  @override
  Future<OpenAIEval> create(
      {required RequestDatatSourceConfig dataSourceConfig,
      required List testingCriteria,
      Map<String, dynamic>? metadata,
      String? name}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<OpenAIEvalRun> createRun(
      {required String evalId,
      required EvalRunDataSource dataSource,
      Map<String, dynamic>? metadata,
      String? name}) {
    // TODO: implement createRun
    throw UnimplementedError();
  }

  @override
  Future<void> delete({required String evalId}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> deleteRun({required String evalId, required String runId}) {
    // TODO: implement deleteRun
    throw UnimplementedError();
  }

  @override
  Future<OpenAIEval> get({required String evalId}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<OpenAIEvalRunOutputItem> getEvalRunOutputItem(
      {required String evalId,
      required String outputItemIdn,
      required String runId}) {
    // TODO: implement getEvalRunOutputItem
    throw UnimplementedError();
  }

  @override
  Future<OpenAIEvalRunOutputItemsList> getEvalRunOutputItems(
      {required String evalId,
      required String runId,
      String? after,
      int? limit,
      String? order,
      String? status}) {
    // TODO: implement getEvalRunOutputItems
    throw UnimplementedError();
  }

  @override
  Future<OpenAIEvalsList> getEvals(
      {String? after, int? limit, String? order, String? orderBy}) {
    // TODO: implement getEvals
    throw UnimplementedError();
  }

  @override
  Future<OpenAIEvalRun> getRun(
      {required String evalId, required String runId}) {
    // TODO: implement getRun
    throw UnimplementedError();
  }

  @override
  Future<OpenAIEvalRunsList> getRuns(
      {required String evalId, String? after, int? limit, String? order}) {
    // TODO: implement getRuns
    throw UnimplementedError();
  }

  @override
  Future<OpenAIConversation> update(
      {required String conversationId,
      required Map<String, dynamic> metadata}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
