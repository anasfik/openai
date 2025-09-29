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
}
