import 'package:dart_openai/src/core/models/vector_stores/vector_store.dart';
import 'package:dart_openai/src/core/models/vector_stores/vectore_store_list.dart';

abstract class GetInterface {
  Future<OpenAIVectorStoreModel> get({
    required String vectorStoreId,
  });

  Future<OpenAIVectorStoreListModel> getAll({
    String? after,
    String? before,
    int? limit,
    String? order,
  });
}
