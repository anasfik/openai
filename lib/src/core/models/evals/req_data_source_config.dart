class RequestDatatSourceConfig {
  final String type;

  RequestDatatSourceConfig({
    required this.type,
  });

  static RequestDatatSourceConfig custom({
    required Map<String, dynamic> itemSchema,
    bool? includeSampleSchema,
  }) {
    return RequestCustomDataSourceConfig(
      type: "custom",
      itemSchema: itemSchema,
      includeSampleSchema: includeSampleSchema,
    );
  }

  static RequestDatatSourceConfig logs({
    required Map<String, dynamic> metadata,
  }) {
    return RequestLogsDataSourceConfig(
      type: "logs",
      metadata: metadata,
    );
  }
}

class RequestCustomDataSourceConfig extends RequestDatatSourceConfig {
  final Map<String, dynamic> itemSchema;
  final bool? includeSampleSchema;

  RequestCustomDataSourceConfig({
    required this.itemSchema,
    required this.includeSampleSchema,
    super.type = "custom",
  });

  Map<String, dynamic> toMap() {
    return {
      "type": type,
      "item_schema": itemSchema,
      if (includeSampleSchema != null)
        "include_sample_schema": includeSampleSchema,
    };
  }
}

class RequestLogsDataSourceConfig extends RequestDatatSourceConfig {
  final Map<String, dynamic> metadata;

  RequestLogsDataSourceConfig({
    required this.metadata,
    super.type = "logs",
  });

  Map<String, dynamic> toMap() {
    return {
      "type": type,
      "metadata": metadata,
    };
  }
}
