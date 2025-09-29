import 'package:dart_openai/src/core/models/vector_stores/vectore_store_file.dart';

abstract class UpdateInterface {
  Future<OpenAIVectorStoreFileModel> update({
    required String fileId,
    required String vectorStoreId,
    required Map<String, dynamic> attributes,
  });
}
