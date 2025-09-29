import 'package:dart_openai/src/core/models/vector_stores/chunking_strategy.dart';
import 'package:dart_openai/src/core/models/vector_stores/vectore_store_batch.dart';
import 'package:dart_openai/src/core/models/vector_stores/vectore_store_batch_list.dart';
import 'package:dart_openai/src/core/vector_stores/batch/batch.dart';

class OpenAIVectorStoreBatch implements OpenAIVectorStoreBatchBase {
  @override
  Future<OpenAIVectorStoreBatchModel> cancel({
    required String batchId,
    required String vectorStoreId,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<OpenAIVectorStoreBatchModel> create({
    required String vectorStoreId,
    required List<String> fileIds,
    Map<String, dynamic>? attributes,
    OpenAIVectorStoreChunkingStrategy? chunkingStrategy,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<OpenAIVectorStoreBatchModel> get({
    required String batchId,
    required String vectorStoreId,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<OpenAIVectorStoreBatchListModel> getAll({
    required String batchId,
    required String vectorStoreId,
    String? after,
    String? before,
    String? filter,
    int? limit,
    String? order,
  }) async {
    throw UnimplementedError();
  }
}
