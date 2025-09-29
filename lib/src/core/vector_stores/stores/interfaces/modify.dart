import 'package:dart_openai/src/core/models/vector_stores/expires_after.dart';
import 'package:dart_openai/src/core/models/vector_stores/vector_store.dart';

abstract class ModifyInterface {
  Future<OpenAIVectorStoreModel> modify({
    required String vectorStoreId,
    OpenAIVectorStoreExpiresAfter? expiresAfter,
    Map<String, dynamic>? metadata,
    String? name,
  });
}
