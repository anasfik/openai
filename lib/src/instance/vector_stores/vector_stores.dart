import 'package:dart_openai/src/core/config/client_config.dart';
import 'package:dart_openai/src/instance/vector_stores/batch/batch.dart';
import 'package:dart_openai/src/instance/vector_stores/files/files.dart';
import 'package:dart_openai/src/instance/vector_stores/stores/stores.dart';

class OpenAIVectorStores {
  OpenAIVectorStores([OpenAIClientConfig? config])
      : vectorStores = OpenAIVectorStoresStores(config),
        vectorStoresFiles = OpenAIVectorStoreFiles(config),
        vectorStoreFileBatch = OpenAIVectorStoreBatch(config);

  // repetetion of stores is not a mistake here, just nomenclature following the API docs
  final OpenAIVectorStoresStores vectorStores;

  final OpenAIVectorStoreFiles vectorStoresFiles;

  final OpenAIVectorStoreBatch vectorStoreFileBatch;
}
