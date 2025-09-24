class DatatSourceConfig {
  final String type;
  final Map<String, dynamic> schema;

  DatatSourceConfig({
    required this.type,
    required this.schema,
  });

  static DatatSourceConfig custom({required Map<String, dynamic> schema}) {
    return CustomDataSourceConfig(
      type: "custom",
      schema: schema,
    );
  }

  static DatatSourceConfig logs({required Map<String, dynamic> schema}) {
    return LogsDataSourceConfig(
      type: "logs",
      schema: schema,
    );
  }

  static DatatSourceConfig fromMap(Map<String, dynamic> map) {
    final type = map['type'];
    final schema = Map<String, dynamic>.from(map['schema'] ?? {});
    switch (type) {
      case 'custom':
        return CustomDataSourceConfig(schema: schema);
      case 'logs':
        final metadata = Map<String, dynamic>.from(map['metadata'] ?? {});

        return LogsDataSourceConfig(schema: schema, metadata: metadata);
      default:
        throw UnimplementedError(
          'DataSourceConfig type $type is not implemented',
        );
    }
  }
}

class CustomDataSourceConfig extends DatatSourceConfig {
  CustomDataSourceConfig({
    required super.schema,
    super.type = "custom",
  });

  Map<String, dynamic> toMap() {
    return {
      "type": type,
      "schema": schema,
    };
  }
}

class LogsDataSourceConfig extends DatatSourceConfig {
  final Map<String, dynamic> metadata;

  LogsDataSourceConfig({
    required super.schema,
    super.type = "logs",
    this.metadata = const {},
  });

  Map<String, dynamic> toMap() {
    return {
      "type": type,
      "schema": schema,
      "metadata": metadata,
    };
  }
}
