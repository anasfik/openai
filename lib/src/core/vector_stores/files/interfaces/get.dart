import 'package:dart_openai/src/core/models/vector_stores/vector_store_file_list.dart';
import 'package:dart_openai/src/core/models/vector_stores/vectore_store_file.dart';

abstract class GetInterface {
  Future<OpenAIVectorStoreFileModel> get({
    required String fileId,
    required String vectorStoreId,
  });

  Future<OpenAIVectorStoreFileListModel> getAll({
    required String vectoreStoreId,
    String? after,
    String? before,
    int? limit,
    String? order,
  });
}
