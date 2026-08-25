import 'package:dart_openai/src/core/base/vector_stores/batch/batch.dart';
import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/config/client_config.dart';
import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/models/vector_stores/chunking_strategy.dart';
import 'package:dart_openai/src/core/models/vector_stores/vectore_store_batch.dart';
import 'package:dart_openai/src/core/models/vector_stores/vectore_store_batch_list.dart';
import 'package:dart_openai/src/core/networking/client.dart';

class OpenAIVectorStoreBatch implements OpenAIVectorStoreBatchBase {
  /// Per-client configuration; when null, global statics are used.
  final OpenAIClientConfig? _config;

  OpenAIVectorStoreBatch([this._config]);

  @override
  String get endpoint => OpenAIStrings.endpoints.vectorStores;

  @override
  Future<OpenAIVectorStoreBatchModel> cancel({
    required String batchId,
    required String vectorStoreId,
  }) async {
    return OpenAINetworkingClient.post<OpenAIVectorStoreBatchModel>(
        to: BaseApiUrlBuilder.buildFor(
            _config, endpoint, '$vectorStoreId/file_batches/$batchId/cancel'),
        onSuccess: (Map<String, dynamic> response) {
          return OpenAIVectorStoreBatchModel.fromMap(response);
        },
        config: _config);
  }

  @override
  Future<OpenAIVectorStoreBatchModel> create({
    required String vectorStoreId,
    List<String>? fileIds,
    Map<String, dynamic>? attributes,
    OpenAIVectorStoreChunkingStrategy? chunkingStrategy,
  }) async {
    return OpenAINetworkingClient.post<OpenAIVectorStoreBatchModel>(
        to: BaseApiUrlBuilder.buildFor(
            _config, endpoint, '$vectorStoreId/file_batches'),
        body: {
          if (fileIds != null) 'file_ids': fileIds,
          if (attributes != null) 'attributes': attributes,
          if (chunkingStrategy != null)
            'chunking_strategy': chunkingStrategy.toMap(),
        },
        onSuccess: (Map<String, dynamic> response) {
          return OpenAIVectorStoreBatchModel.fromMap(response);
        },
        config: _config);
  }

  @override
  Future<OpenAIVectorStoreBatchModel> get({
    required String batchId,
    required String vectorStoreId,
  }) async {
    return OpenAINetworkingClient.get<OpenAIVectorStoreBatchModel>(
        from: BaseApiUrlBuilder.buildFor(
            _config, endpoint, '$vectorStoreId/file_batches/$batchId'),
        onSuccess: (Map<String, dynamic> response) {
          return OpenAIVectorStoreBatchModel.fromMap(response);
        },
        config: _config);
  }

  @override
  Future<OpenAIVectorStoreBatchListModel> list({
    required String batchId,
    required String vectorStoreId,
    String? after,
    String? before,
    String? filter,
    int? limit,
    String? order,
  }) async {
    return OpenAINetworkingClient.get<OpenAIVectorStoreBatchListModel>(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: '$endpoint/$vectorStoreId/file_batches/$batchId/files',
        query: {
          if (after != null) 'after': after,
          if (before != null) 'before': before,
          if (filter != null) 'filter': filter,
          if (limit != null) 'limit': limit.toString(),
          if (order != null) 'order': order,
        },
        config: _config,
      ),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIVectorStoreBatchListModel.fromMap(response);
      },
    );
  }
}
