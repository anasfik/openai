import 'package:dart_openai/src/core/base/batch/batch.dart';
import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/config/client_config.dart';
import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/models/batch/batch.dart';
import 'package:dart_openai/src/core/models/batch/batch_list.dart';
import 'package:dart_openai/src/core/models/batch/output_expires_after.dart';
import 'package:dart_openai/src/core/networking/client.dart';

class OpenAIBatch implements OpenAIBatchBase {
  final OpenAIClientConfig? _config;

  OpenAIBatch([this._config]);

  String get endpoint => OpenAIStrings.endpoints.batch;

  @override
  Future<OpenAiBatchModel> create({
    required String completionWindow,
    required String endpoint,
    required String inputFileId,
    Map<String, dynamic>? metadata,
    OpenAIBatchoutputExpiresAfter? outputExpiresAfter,
  }) async {
    return await OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, OpenAIStrings.endpoints.batch),
      body: {
        'completion_window': completionWindow,
        'endpoint': endpoint,
        'input_file_id': inputFileId,
        if (metadata != null) 'metadata': metadata,
        if (outputExpiresAfter != null)
          'output_expires_after': {
            'anchor': outputExpiresAfter.anchor,
            'seconds': outputExpiresAfter.seconds,
          },
      },
      onSuccess: BatchModelParsing.fromMap,
      config: _config,
    );
  }

  @override
  Future<OpenAiBatchModel> get({
    required String batchId,
  }) async {
    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildFor(
          _config, OpenAIStrings.endpoints.batch, batchId),
      onSuccess: BatchModelParsing.fromMap,
      config: _config,
    );
  }

  /// Lists all batches. [after] is the cursor of the last returned batch.
  @override
  Future<OpenAiBatchListModel> getAll({
    required String? after,
    required int? limit,
  }) async {
    final query = <String, String>{
      if (after != null) 'after': after,
      if (limit != null) 'limit': limit.toString(),
    };
    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: OpenAIStrings.endpoints.batch,
        query: query,
        config: _config,
      ),
      onSuccess: BatchListParsing.fromMap,
      config: _config,
    );
  }

  @override
  Future<OpenAiBatchModel> cancel({
    required String batchId,
  }) async {
    return await OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config,
          '${OpenAIStrings.endpoints.batch}/$batchId/cancel'),
      onSuccess: BatchModelParsing.fromMap,
      config: _config,
    );
  }
}
