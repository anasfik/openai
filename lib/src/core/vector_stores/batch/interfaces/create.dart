import 'package:dart_openai/src/core/models/vector_stores/chunking_strategy.dart';
import 'package:dart_openai/src/core/models/vector_stores/vectore_store_batch.dart';

abstract class CreateInterface {
  Future<OpenAIVectorStoreBatchModel> create({
    required String vectorStoreId,
    required List<String> fileIds,
    Map<String, dynamic>? attributes,
    OpenAIVectorStoreChunkingStrategy? chunkingStrategy,
  });
}
