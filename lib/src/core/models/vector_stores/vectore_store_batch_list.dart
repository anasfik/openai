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

  factory OpenAIVectorStoreBatchListModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return OpenAIVectorStoreBatchListModel(
      data: List<OpenAIVectorStoreBatchModel>.from(
        (map['data'] as List).map<OpenAIVectorStoreBatchModel>(
          (x) => OpenAIVectorStoreBatchModel.fromMap(x),
        ),
      ),
      firstId: map['first_id'],
      lastId: map['last_id'],
      hasMore: map['has_more'],
    );
  }
}
