import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/models/vector_stores/chunking_strategy.dart';
import 'package:dart_openai/src/core/models/vector_stores/vectore_store_batch.dart';
import 'package:dart_openai/src/core/models/vector_stores/vectore_store_batch_list.dart';
import 'package:dart_openai/src/core/networking/client.dart';
import 'package:dart_openai/src/core/vector_stores/batch/batch.dart';
import 'package:dart_openai/src/instance/openai.dart';

class OpenAIVectorStoreBatch implements OpenAIVectorStoreBatchBase {
  @override
  String get endpoint => OpenAIStrings.endpoints.vectorStores;

  @override
  Future<OpenAIVectorStoreBatchModel> cancel({
    required String batchId,
    required String vectorStoreId,
  }) async {
    return await OpenAINetworkingClient.post<OpenAIVectorStoreBatchModel>(
      to: BaseApiUrlBuilder.build(
        endpoint,
        "$vectorStoreId/file_batches/$batchId/cancel",
      ),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIVectorStoreBatchModel.fromMap(response);
      },
    );
  }

  @override
  Future<OpenAIVectorStoreBatchModel> create({
    required String vectorStoreId,
    List<String>? fileIds,
    Map<String, dynamic>? attributes,
    OpenAIVectorStoreChunkingStrategy? chunkingStrategy,
  }) async {
    return await OpenAINetworkingClient.post<OpenAIVectorStoreBatchModel>(
      to: BaseApiUrlBuilder.build(
        endpoint,
        "$vectorStoreId/file_batches",
      ),
      body: {
        if (fileIds != null) "file_ids": fileIds,
        if (attributes != null) "attributes": attributes,
        if (chunkingStrategy != null)
          "chunking_strategy": chunkingStrategy.toMap(),
      },
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIVectorStoreBatchModel.fromMap(response);
      },
    );
  }

  @override
  Future<OpenAIVectorStoreBatchModel> get({
    required String batchId,
    required String vectorStoreId,
  }) async {
    return await OpenAINetworkingClient.get<OpenAIVectorStoreBatchModel>(
      from: BaseApiUrlBuilder.build(
        endpoint,
        "$vectorStoreId/file_batches/$batchId",
      ),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIVectorStoreBatchModel.fromMap(response);
      },
    );
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
    return await OpenAINetworkingClient.get<OpenAIVectorStoreBatchListModel>(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: endpoint + "/$vectorStoreId/file_batches/$batchId/files",
        query: {
          if (after != null) "after": after,
          if (before != null) "before": before,
          if (filter != null) "filter": filter,
          if (limit != null) "limit": limit.toString(),
          if (order != null) "order": order,
        },
      ),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIVectorStoreBatchListModel.fromMap(response);
      },
    );
  }
}
