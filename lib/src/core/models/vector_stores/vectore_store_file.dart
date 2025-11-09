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

  factory OpenAIVectorStoreFileModel.fromMap(Map<String, dynamic> map) {
    return OpenAIVectorStoreFileModel(
      id: map['id'],
      vectorStoreId: map['vector_store_id'],
      attributes: map['attributes'],
      chunkingStrategy: map['chunking_strategy'] != null
          ? OpenAIVectorStoreChunkingStrategy.fromMap(
              Map<String, dynamic>.from(map['chunking_strategy']),
            )
          : null,
      createdAt: map['created_at'],
      lastError: map['last_error'],
      usageBytes: map['usage_bytes'],
      status: map['status'],
    );
  }
}
