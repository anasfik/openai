import 'package:dart_openai/src/core/models/vector_stores/expires_after.dart';
import 'package:dart_openai/src/core/models/vector_stores/file_counts.dart';

class OpenAIVectorStoreModel {
  final int createdAt;
  final OpenAIVectorStoreExpiresAfter? expiresAfter;
  final int? expiresAt;
  final OpenAIVectorStoreFileCounts? fileCounts;
  final String id;
  final int lastActiveAt;
  final Map<String, dynamic>? metadata;
  final String name;
  final String status;
  final int usageBytes;

  OpenAIVectorStoreModel({
    required this.createdAt,
    required this.expiresAfter,
    required this.expiresAt,
    required this.fileCounts,
    required this.metadata,
    required this.id,
    required this.lastActiveAt,
    required this.name,
    required this.status,
    required this.usageBytes,
  });

  factory OpenAIVectorStoreModel.fromMap(Map<String, dynamic> map) {
    return OpenAIVectorStoreModel(
      createdAt: map['created_at'],
      expiresAfter: map['expires_after'] != null
          ? OpenAIVectorStoreExpiresAfter.fromMap(map['expires_after'])
          : null,
      expiresAt: map['expires_at'],
      fileCounts: map['file_counts'] != null
          ? OpenAIVectorStoreFileCounts.fromMap(map['file_counts'])
          : null,
      id: map['id'],
      lastActiveAt: map['last_active_at'],
      metadata: map['metadata'],
      name: map['name'],
      status: map['status'],
      usageBytes: map['usage_bytes'],
    );
  }
}
