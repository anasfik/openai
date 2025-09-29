import 'package:dart_openai/src/core/models/vector_stores/chunking_strategy.dart';

class OpenAIVectorStoreFileModel {
  final Map<String, dynamic>? attributes;
  final OpenAIVectorStoreChunkingStrategy? chunkingStrategy;
  final int? createdAt;
  final String id;
  final lastError;
  final String status;
  final int usageBytes;
  final String vectorStoreId;

  OpenAIVectorStoreFileModel({
    required this.id,
    required this.vectorStoreId,
    required this.attributes,
    required this.chunkingStrategy,
    required this.createdAt,
    required this.lastError,
    required this.usageBytes,
    required this.status,
  });
}
