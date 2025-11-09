import 'package:dart_openai/dart_openai.dart';
import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/models/vector_stores/search_vector_store_list.dart';
import 'package:dart_openai/src/core/networking/client.dart';
import 'package:dart_openai/src/core/vector_stores/stores/stores.dart';

class OpenAIVectorStoresStores implements OpenAIVectorStoresStoresBase {
  @override
  String get endpoint => OpenAIStrings.endpoints.vectorStores;

  @override
  Future<OpenAIVectorStoreModel> create({
    OpenAIVectorStoreChunkingStrategy? chunkingStrategy,
    OpenAIVectorStoreExpiresAfter? expiresAfter,
    List<String>? fileIds,
    Map<String, dynamic>? metadata,
    String? name,
    String? description,
  }) async {
    return await OpenAINetworkingClient.post<OpenAIVectorStoreModel>(
      to: BaseApiUrlBuilder.build(endpoint),
      body: {
        if (chunkingStrategy != null)
          'chunking_strategy': chunkingStrategy.toMap(),
        if (expiresAfter != null) 'expires_after': expiresAfter.toMap(),
        if (fileIds != null) 'file_ids': fileIds,
        if (metadata != null) 'metadata': metadata,
        if (name != null) 'name': name,
        if (description != null) 'description': description,
      },
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIVectorStoreModel.fromMap(response);
      },
    );
  }

  @override
  Future<OpenAIVectorStoreListModel> list({
    String? after,
    String? before,
    int? limit,
    String? order,
  }) async {
    return await OpenAINetworkingClient.get<OpenAIVectorStoreListModel>(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: endpoint,
        query: {
          if (after != null) 'after': after,
          if (before != null) 'before': before,
          if (limit != null) 'limit': limit.toString(),
          if (order != null) 'order': order,
        },
      ),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIVectorStoreListModel.fromMap(response);
      },
    );
  }

  @override
  Future<OpenAIVectorStoreModel> get({
    required String vectorStoreId,
  }) async {
    return await OpenAINetworkingClient.get<OpenAIVectorStoreModel>(
      from: BaseApiUrlBuilder.build(
        '$endpoint/$vectorStoreId',
      ),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIVectorStoreModel.fromMap(response);
      },
    );
  }

  @override
  Future<OpenAIVectorStoreModel> modify({
    required String vectorStoreId,
    OpenAIVectorStoreExpiresAfter? expiresAfter,
    Map<String, dynamic>? metadata,
    String? name,
  }) async {
    return await OpenAINetworkingClient.post<OpenAIVectorStoreModel>(
      to: BaseApiUrlBuilder.build(
        '$endpoint/$vectorStoreId',
      ),
      body: {
        if (expiresAfter != null) 'expires_after': expiresAfter.toMap(),
        if (metadata != null) 'metadata': metadata,
        if (name != null) 'name': name,
      },
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIVectorStoreModel.fromMap(response);
      },
    );
  }

  @override
  Future<void> delete({
    required String vectorStoreId,
  }) async {
    return await OpenAINetworkingClient.delete<void>(
      from: BaseApiUrlBuilder.build(
        '$endpoint/$vectorStoreId',
      ),
      onSuccess: (Map<String, dynamic> response) {
        return;
      },
    );
  }

  @override
  Future<SearchVectorStoreList> search({
    required String vectorStoreId,
    required query,
    OpenAIVectorStoresSearchFilter? filters,
    int? maxNumResults,
    OpenAIVectorStoresRankingOptions? rankingOptions,
    bool? rewriteQuery,
  }) async {
    return await OpenAINetworkingClient.post<SearchVectorStoreList>(
      to: BaseApiUrlBuilder.build(
        '$endpoint/$vectorStoreId/search',
      ),
      body: {
        'query': query,
        if (filters != null) 'filters': filters.toMap(),
        if (maxNumResults != null) 'max_num_results': maxNumResults,
        if (rankingOptions != null) 'ranking_options': rankingOptions.toMap(),
        if (rewriteQuery != null) 'rewrite_query': rewriteQuery,
      },
      onSuccess: (Map<String, dynamic> response) {
        return SearchVectorStoreList.fromMap(response);
      },
    );
  }
}
