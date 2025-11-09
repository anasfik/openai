import 'package:dart_openai/src/core/models/vector_stores/file_counts.dart';

enum OpenAIVectorStoreBatchStatus {
  inProgress("in_progress"),
  completed("completed"),
  cancelled("cancelled"),
  failed("failed");

  final String value;
  const OpenAIVectorStoreBatchStatus(this.value);

  static fromValue(String value) {
    switch (value) {
      case "in_progress":
        return OpenAIVectorStoreBatchStatus.inProgress;
      case "completed":
        return OpenAIVectorStoreBatchStatus.completed;
      case "cancelled":
        return OpenAIVectorStoreBatchStatus.cancelled;
      case "failed":
        return OpenAIVectorStoreBatchStatus.failed;
      default:
        throw Exception("Unknown OpenAIVectorStoreBatchStatus value: $value");
    }
  }
}

class OpenAIVectorStoreBatchModel {
  final int createdAt;
  final OpenAIVectorStoreFileCounts? fileCounts;
  final String id;
  final OpenAIVectorStoreBatchStatus status;
  final String? vectorStoreId;

  OpenAIVectorStoreBatchModel({
    required this.createdAt,
    required this.fileCounts,
    required this.id,
    required this.status,
    required this.vectorStoreId,
  });

  factory OpenAIVectorStoreBatchModel.fromMap(Map<String, dynamic> map) {
    return OpenAIVectorStoreBatchModel(
      createdAt: map['created_at'],
      fileCounts: map['file_counts'] != null
          ? OpenAIVectorStoreFileCounts.fromMap(map['file_counts'])
          : null,
      id: map['id'],
      status: OpenAIVectorStoreBatchStatus.fromValue(map['status']),
      vectorStoreId: map['vector_store_id'],
    );
  }
}
