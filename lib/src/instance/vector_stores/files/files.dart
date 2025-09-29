import 'package:dart_openai/src/core/models/vector_stores/chunking_strategy.dart';
import 'package:dart_openai/src/core/models/vector_stores/vector_store.dart';
import 'package:dart_openai/src/core/models/vector_stores/vector_store_file_list.dart';
import 'package:dart_openai/src/core/models/vector_stores/vectore_store_file.dart';
import 'package:dart_openai/src/core/vector_stores/files/files.dart';

class OpenAIVectorStoreFiles extends OpenAIVectorStoreFilesBase {
  @override
  Future<OpenAIVectorStoreModel> create({
    required String vectorStoreId,
    required String fileId,
    Map<String, dynamic>? attributes,
    OpenAIVectorStoreChunkingStrategy? chunckingStrategy,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<void> delete({
    required String fileId,
    required String vectorStoreId,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<OpenAIVectorStoreFileModel> get({
    required String fileId,
    required String vectorStoreId,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<OpenAIVectorStoreFileListModel> getAll({
    required String vectoreStoreId,
    String? after,
    String? before,
    int? limit,
    String? order,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<OpenAIVectorStoreFileModel> update({
    required String fileId,
    required String vectorStoreId,
    required Map<String, dynamic> attributes,
  }) async {
    throw UnimplementedError();
  }
}
