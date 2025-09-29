import 'package:dart_openai/src/instance/vector_stores/batch/batch.dart';
import 'package:dart_openai/src/instance/vector_stores/files/files.dart';
import 'package:dart_openai/src/instance/vector_stores/stores/stores.dart';

class OpenAIVectorStores {
  // repetetion of stores is not a mistake here, just nomenclature following the API docs
  final vectorStores = OpenAIVectorStoresStores();

  final vectorStoresFiles = OpenAIVectorStoreFiles();

  final vectorStoreFileBatch = OpenAIVectorStoreBatch();
}
