import 'package:dart_openai/src/core/models/vector_stores/chunking_strategy.dart';
import 'package:dart_openai/src/core/models/vector_stores/expires_after.dart';
import 'package:dart_openai/src/core/models/vector_stores/vector_store.dart';

abstract class CreateInterface {
  Future<OpenAIVectorStoreModel> create({
    OpenAIVectorStoreChunkingStrategy? chunkingStrategy,
    OpenAIVectorStoreExpiresAfter? expiresAfter,
    List<String>? fileIds,
    Map<String, dynamic>? metadata,
    String? name,
  });
}
