import 'package:dart_openai/src/core/models/vector_stores/search_filter.dart';
import 'package:dart_openai/src/core/models/vector_stores/ranking_options.dart';
import 'package:dart_openai/src/core/models/vector_stores/search_vector_store_list.dart';

abstract class SearchInterface {
  Future<SearchVectorStoreList> search({
    required String vectorStoreId,
    required query,
    OpenAIVectorStoresSearchFilter? filters,
    int? maxNumResults,
    OpenAIVectorStoresRankingOptions? rankingOptions,
    bool? rewriteQuery,
  });
}
