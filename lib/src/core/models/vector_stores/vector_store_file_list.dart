import 'package:dart_openai/src/core/models/vector_stores/vectore_store_file.dart';

class OpenAIVectorStoreFileListModel {
  final List<OpenAIVectorStoreFileModel> data;
  final String firstId;
  final String lastId;
  final bool hasMore;

  OpenAIVectorStoreFileListModel({
    required this.data,
    required this.firstId,
    required this.lastId,
    required this.hasMore,
  });

  factory OpenAIVectorStoreFileListModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return OpenAIVectorStoreFileListModel(
      data: List<OpenAIVectorStoreFileModel>.from(
        (map['data'] as List).map<OpenAIVectorStoreFileModel>(
          (x) => OpenAIVectorStoreFileModel.fromMap(x),
        ),
      ),
      firstId: map['first_id'],
      lastId: map['last_id'],
      hasMore: map['has_more'],
    );
  }
}
