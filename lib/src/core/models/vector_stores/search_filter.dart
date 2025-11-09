class OpenAIVectorStoresSearchFilter {
  final String type;

  OpenAIVectorStoresSearchFilter({
    required this.type,
  });
  factory OpenAIVectorStoresSearchFilter.comparison({
    required String type,
    required String key,
    required value,
  }) {
    return ComparisonOpenAIVectorStoresSearchFilter(
      type: type,
      key: key,
      value: value,
    );
  }
  factory OpenAIVectorStoresSearchFilter.compound({
    required String type,
    required List<OpenAIVectorStoresSearchFilter> filters,
  }) {
    return CompoundOpenAIVectorStoresSearchFilter(
      type: type,
      filters: filters,
    );
  }

  Map<String, dynamic> toMap() {
    throw UnimplementedError(
        'toMap() must be implemented in subclasses of OpenAIVectorStoresSearchFilter');
  }
}

class ComparisonOpenAIVectorStoresSearchFilter
    extends OpenAIVectorStoresSearchFilter {
  final String key;
  final value;

  ComparisonOpenAIVectorStoresSearchFilter({
    required super.type,
    required this.key,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'key': key,
      'value': value,
    };
  }
}

class CompoundOpenAIVectorStoresSearchFilter
    extends OpenAIVectorStoresSearchFilter {
  final List<OpenAIVectorStoresSearchFilter> filters;

  CompoundOpenAIVectorStoresSearchFilter({
    required super.type,
    required this.filters,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'filters': filters.map((filter) {
        if (filter is ComparisonOpenAIVectorStoresSearchFilter) {
          return filter.toMap();
        } else if (filter is CompoundOpenAIVectorStoresSearchFilter) {
          return filter.toMap();
        } else {
          throw Exception('Unknown filter type');
        }
      }).toList(),
    };
  }
}
