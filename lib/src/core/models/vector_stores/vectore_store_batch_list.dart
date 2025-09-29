import 'package:dart_openai/src/core/models/vector_stores/vectore_store_batch.dart';

class OpenAIVectorStoreBatchListModel {
  final List<OpenAIVectorStoreBatchModel> data;
  final String firstId;
  final String lastId;
  final bool hasMore;

  OpenAIVectorStoreBatchListModel({
    required this.data,
    required this.hasMore,
    required this.firstId,
    required this.lastId,
  });
}
