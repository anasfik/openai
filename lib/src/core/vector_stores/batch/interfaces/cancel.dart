import 'package:dart_openai/src/core/models/vector_stores/vectore_store_batch.dart';

abstract class CancelInterface {
  Future<OpenAIVectorStoreBatchModel> cancel({
    required String batchId,
    required String vectorStoreId,
  });
}
