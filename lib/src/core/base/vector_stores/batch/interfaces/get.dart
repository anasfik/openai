import 'package:dart_openai/src/core/models/vector_stores/vectore_store_batch.dart';
import 'package:dart_openai/src/core/models/vector_stores/vectore_store_batch_list.dart';

abstract class GetInterface {
  Future<OpenAIVectorStoreBatchModel> get({
    required String batchId,
    required String vectorStoreId,
  });

  Future<OpenAIVectorStoreBatchListModel> list({
    required String batchId,
    required String vectorStoreId,
    String? after,
    String? before,
    String? filter,
    int? limit,
    String? order,
  });
}
