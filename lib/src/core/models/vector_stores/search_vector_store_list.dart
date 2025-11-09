class SearchVectorStoreList {
  final searchQuery;
  // non specified type in API, maybe it accepts many data types ?
  final List<Map<String, dynamic>> data;
  final bool hasMore;
  // ?
  final nextPage;

  SearchVectorStoreList({
    required this.searchQuery,
    required this.data,
    required this.hasMore,
    required this.nextPage,
  });

  factory SearchVectorStoreList.fromMap(Map<String, dynamic> json) =>
      SearchVectorStoreList(
        searchQuery: json["search_query"],
        data: List<Map<String, dynamic>>.from(
          json["data"].map(
            (x) => Map<String, dynamic>.from(x),
          ),
        ),
        hasMore: json["has_more"],
        nextPage: json["next_page"],
      );
}
