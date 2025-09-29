import 'package:dart_openai/src/core/models/vector_stores/chunking_strategy.dart';
import 'package:dart_openai/src/core/models/vector_stores/vector_store.dart';

abstract class CreateInterface {
  Future<OpenAIVectorStoreModel> create({
    required String vectorStoreId,
    required String fileId,
    Map<String, dynamic>? attributes,
    OpenAIVectorStoreChunkingStrategy? chunckingStrategy,
  });
}
