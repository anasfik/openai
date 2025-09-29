import 'package:dart_openai/src/core/models/vector_stores/file_counts.dart';

class OpenAIVectorStoreBatchModel {
  final int createdAt;
  final OpenAIVectorStoreFileCounts? fileCounts;
  final String status;
  final String vectorStoreId;

  OpenAIVectorStoreBatchModel({
    required this.createdAt,
    required this.fileCounts,
    required this.status,
    required this.vectorStoreId,
  });
}
