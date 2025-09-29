import 'package:dart_openai/src/core/models/vector_stores/vector_store.dart';

class OpenAIVectorStoreListModel {
  final List<OpenAIVectorStoreModel> data;
  final String firstId;
  final String lastId;
  final bool hasMore;

  OpenAIVectorStoreListModel({
    required this.data,
    required this.firstId,
    required this.lastId,
    required this.hasMore,
  });

  factory OpenAIVectorStoreListModel.fromMap(Map<String, dynamic> map) {
    return OpenAIVectorStoreListModel(
      data: List<OpenAIVectorStoreModel>.from(
        (map['data'] as List).map<OpenAIVectorStoreModel>(
          (x) => OpenAIVectorStoreModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      firstId: map['first_id'] as String,
      lastId: map['last_id'] as String,
      hasMore: map['has_more'] as bool,
    );
  }
}
