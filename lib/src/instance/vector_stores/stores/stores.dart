import 'package:dart_openai/src/core/models/vector_stores/chunking_strategy.dart';
import 'package:dart_openai/src/core/models/vector_stores/expires_after.dart';
import 'package:dart_openai/src/core/models/vector_stores/search_filter.dart';
import 'package:dart_openai/src/core/models/vector_stores/vector_store.dart';
import 'package:dart_openai/src/core/models/vector_stores/vectore_store_list.dart';
import 'package:dart_openai/src/core/vector_stores/stores/stores.dart';
import 'package:dart_openai/src/instance/responses/ranking_options.dart';

class OpenAIVectorStoresStores implements OpenAIVectorStoresStoresBase {
  @override
  Future<OpenAIVectorStoreModel> create({
    OpenAIVectorStoreChunkingStrategy? chunkingStrategy,
    OpenAIVectorStoreExpiresAfter? expiresAfter,
    List<String>? fileIds,
    Map<String, dynamic>? metadata,
    String? name,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<OpenAIVectorStoreModel> get({
    required String vectorStoreId,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<OpenAIVectorStoreListModel> getAll({
    String? after,
    String? before,
    int? limit,
    String? order,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<OpenAIVectorStoreModel> modify({
    required String vectorStoreId,
    OpenAIVectorStoreExpiresAfter? expiresAfter,
    Map<String, dynamic>? metadata,
    String? name,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> search({
    required query,
    OpenAIVectorStoresSearchFilter? filters,
    int? maxNumResults,
    OpenAIVectorStoresRankingOptions? rankingOptions,
    bool? rewriteQuery,
  }) async {
    throw UnimplementedError();
  }
}
