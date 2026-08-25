import 'package:dart_openai/src/core/base/evals/evals.dart';
import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/models/evals/eval.dart';
import 'package:dart_openai/src/core/models/evals/eval_run.dart';
import 'package:dart_openai/src/core/models/evals/eval_run_data_source.dart';
import 'package:dart_openai/src/core/models/evals/eval_run_output_item.dart';
import 'package:dart_openai/src/core/models/evals/eval_run_output_items_list.dart';
import 'package:dart_openai/src/core/models/evals/eval_runs_list.dart';
import 'package:dart_openai/src/core/models/evals/evals_list.dart';
import 'package:dart_openai/src/core/models/evals/req_data_source_config.dart';
import 'package:dart_openai/src/core/networking/client.dart';
import 'package:dart_openai/src/core/utils/logger.dart';
import 'package:dart_openai/src/core/config/client_config.dart';

class OpenAIEvals implements OpenAIEvalsBase {
  @override
  String get endpoint => OpenAIStrings.endpoints.evals;

  /// Per-client configuration; when null, global statics are used.
  final OpenAIClientConfig? _config;

  /// {@macro openai_embedding}
  OpenAIEvals([this._config]) {
    OpenAILogger.logEndpoint(endpoint);
  }

  @override
  Future<OpenAIEval> create({
    required RequestDatatSourceConfig dataSourceConfig,
    required List testingCriteria,
    Map<String, dynamic>? metadata,
    String? name,
  }) async {
    return await OpenAINetworkingClient.post<OpenAIEval>(
        onSuccess: (Map<String, dynamic> response) {
          return OpenAIEval.fromMap(response);
        },
        to: BaseApiUrlBuilder.buildFor(_config, endpoint),
        body: {
          'data_source_config': dataSourceConfig.toMap(),
          'testing_criteria': testingCriteria,
          if (metadata != null) 'metadata': metadata,
          if (name != null) 'name': name,
        },
        config: _config);
  }

  @override
  Future<OpenAIEval> get({
    required String evalId,
  }) async {
    return await OpenAINetworkingClient.get<OpenAIEval>(
        onSuccess: (Map<String, dynamic> response) {
          return OpenAIEval.fromMap(response);
        },
        from: BaseApiUrlBuilder.buildFor(_config, endpoint, evalId),
        config: _config);
  }

  @override
  Future<OpenAIEval> update({
    required String evalId,
    Map<String, dynamic>? metadata,
    String? name,
  }) async {
    return await OpenAINetworkingClient.post<OpenAIEval>(
        onSuccess: (Map<String, dynamic> response) {
          return OpenAIEval.fromMap(response);
        },
        to: BaseApiUrlBuilder.buildFor(_config, endpoint, evalId),
        body: {
          if (metadata != null) 'metadata': metadata,
          if (name != null) 'name': name,
        },
        config: _config);
  }

  @override
  Future<void> delete({
    required String evalId,
  }) async {
    await OpenAINetworkingClient.delete(
      from: BaseApiUrlBuilder.buildFor(_config, endpoint, evalId),
      onSuccess: (_) {},
      config: _config,
    );
  }

  @override
  Future<OpenAIEvalsList> list({
    String? after,
    int? limit,
    String? order,
    String? orderBy,
  }) async {
    return await OpenAINetworkingClient.get<OpenAIEvalsList>(
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIEvalsList.fromMap(response);
      },
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: endpoint,
        query: {
          if (after != null) 'after': after,
          if (limit != null) 'limit': limit.toString(),
          if (order != null) 'order': order,
          if (orderBy != null) 'order_by': orderBy,
        },
        config: _config,
      ),
    );
  }

  @override
  Future<OpenAIEvalRunsList> getRuns({
    required String evalId,
    String? after,
    int? limit,
    String? order,
  }) async {
    return await OpenAINetworkingClient.get<OpenAIEvalRunsList>(
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIEvalRunsList.fromMap(response);
      },
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: '$endpoint/$evalId/runs',
        query: {
          if (after != null) 'after': after,
          if (limit != null) 'limit': limit.toString(),
          if (order != null) 'order': order,
        },
        config: _config,
      ),
    );
  }

  @override
  Future<OpenAIEvalRun> getRun({
    required String evalId,
    required String runId,
  }) async {
    return await OpenAINetworkingClient.get<OpenAIEvalRun>(
        onSuccess: (Map<String, dynamic> response) {
          return OpenAIEvalRun.fromMap(response);
        },
        from: BaseApiUrlBuilder.buildFor(
            _config, endpoint, '$evalId/runs/$runId'),
        config: _config);
  }

  @override
  Future<OpenAIEvalRun> createRun({
    required String evalId,
    required EvalRunDataSource dataSource,
    Map<String, dynamic>? metadata,
    String? name,
  }) async {
    return await OpenAINetworkingClient.post<OpenAIEvalRun>(
        onSuccess: (Map<String, dynamic> response) {
          return OpenAIEvalRun.fromMap(response);
        },
        to: BaseApiUrlBuilder.buildFor(_config, endpoint, '$evalId/runs'),
        body: {
          'data_source': dataSource.toMap(),
          if (metadata != null) 'metadata': metadata,
          if (name != null) 'name': name,
        },
        config: _config);
  }

  @override
  Future<OpenAIEvalRun> cancel({
    required String evalId,
    required String runId,
  }) async {
    return await OpenAINetworkingClient.post<OpenAIEvalRun>(
        onSuccess: (Map<String, dynamic> response) {
          return OpenAIEvalRun.fromMap(response);
        },
        to: BaseApiUrlBuilder.buildFor(
            _config, endpoint, '$evalId/runs/$runId'),
        config: _config);
  }

  @override
  Future<void> deleteRun({
    required String evalId,
    required String runId,
  }) async {
    await OpenAINetworkingClient.delete(
      from:
          BaseApiUrlBuilder.buildFor(_config, endpoint, '$evalId/runs/$runId'),
      onSuccess: (_) {},
      config: _config,
    );
  }

  @override
  Future<OpenAIEvalRunOutputItem> getEvalRunOutputItem({
    required String evalId,
    required String outputItemIdn,
    required String runId,
  }) async {
    return await OpenAINetworkingClient.get<OpenAIEvalRunOutputItem>(
        onSuccess: (Map<String, dynamic> response) {
          return OpenAIEvalRunOutputItem.fromMap(response);
        },
        from: BaseApiUrlBuilder.buildFor(_config, endpoint,
            '$evalId/runs/$runId/output_items/$outputItemIdn'),
        config: _config);
  }

  @override
  Future<OpenAIEvalRunOutputItemsList> getEvalRunOutputItems({
    required String evalId,
    required String runId,
    String? after,
    int? limit,
    String? order,
    String? status,
  }) async {
    return await OpenAINetworkingClient.get<OpenAIEvalRunOutputItemsList>(
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIEvalRunOutputItemsList.fromMap(response);
      },
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: '$endpoint/$evalId/runs/$runId/output_items',
        query: {
          if (after != null) 'after': after,
          if (limit != null) 'limit': limit.toString(),
          if (order != null) 'order': order,
          if (status != null) 'status': status,
        },
        config: _config,
      ),
    );
  }
}
