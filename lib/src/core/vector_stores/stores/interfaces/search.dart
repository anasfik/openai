import 'package:dart_openai/src/core/models/vector_stores/search_filter.dart';
import 'package:dart_openai/src/instance/responses/ranking_options.dart';

abstract class SearchInterface {
  // no guides on how the response should be parsed.
  Future<Map<String, dynamic>> search({
    required query,
    OpenAIVectorStoresSearchFilter? filters,
    int? maxNumResults,
    OpenAIVectorStoresRankingOptions? rankingOptions,
    bool? rewriteQuery,
  });
}
