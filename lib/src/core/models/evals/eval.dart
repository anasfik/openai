import 'package:dart_openai/src/core/models/evals/eval_data_source.dart';

class OpenAIEval {
  final int createdAt;
  final DatatSourceConfig dataSourceConfig;
  final String id;
  final Map<String, dynamic> metadata;
  final String name;

  // to parse more spricifcly for dev UX.
  final List testingCriteria;

  OpenAIEval({
    required this.createdAt,
    required this.dataSourceConfig,
    required this.id,
    required this.metadata,
    required this.name,
    required this.testingCriteria,
  });

  factory OpenAIEval.fromMap(Map<String, dynamic> map) {
    return OpenAIEval(
      createdAt: map['created_at'] ?? 0,
      dataSourceConfig:
          DatatSourceConfig.fromMap(map['data_source_config'] ?? {}),
      id: map['id'] ?? '',
      metadata: Map<String, dynamic>.from(map['metadata'] ?? {}),
      name: map['name'] ?? '',
      testingCriteria: List.from(map['testing_criteria'] ?? []),
    );
  }
}
