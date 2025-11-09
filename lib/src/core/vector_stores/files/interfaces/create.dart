import 'package:dart_openai/src/core/models/vector_stores/chunking_strategy.dart';
import 'package:dart_openai/src/core/models/vector_stores/vectore_store_file.dart';

abstract class CreateInterface {
  Future<OpenAIVectorStoreFileModel> create({
    required String vectorStoreId,
    required String fileId,
    Map<String, dynamic>? attributes,
    OpenAIVectorStoreChunkingStrategy? chunckingStrategy,
  });
}
