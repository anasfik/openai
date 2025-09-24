import 'package:dart_openai/src/core/models/evals/eval_run_data_source.dart';

class OpenAIEvalRun {
  final int createdAt;
  final EvalRunDataSource dataSource;
  final Map<String, dynamic> error;
  final String evalId;
  final String id;
  final Map<String, dynamic> metadata;
  final String model;
  final String name;
  final List perModelUsage;
  final List perTestingCriteriaResults;
  final String reportUrl;
  final Map<String, dynamic> resultCounts;
  final String status;

  OpenAIEvalRun({
    required this.createdAt,
    required this.dataSource,
    required this.error,
    required this.evalId,
    required this.id,
    required this.metadata,
    required this.model,
    required this.name,
    required this.perModelUsage,
    required this.perTestingCriteriaResults,
    required this.reportUrl,
    required this.resultCounts,
    required this.status,
  });

  factory OpenAIEvalRun.fromMap(Map<String, dynamic> map) {
    return OpenAIEvalRun(
      createdAt: map['created_at']?.toInt() ?? 0,
      dataSource: EvalRunDataSource.fromMap(map['data_source']),
      error: Map<String, dynamic>.from(map['error'] ?? {}),
      evalId: map['eval_id'] ?? '',
      id: map['id'] ?? '',
      metadata: Map<String, dynamic>.from(map['metadata'] ?? {}),
      model: map['model'] ?? '',
      name: map['name'] ?? '',
      perModelUsage: List.from(map['per_model_usage'] ?? []),
      perTestingCriteriaResults:
          List.from(map['per_testing_criteria_results'] ?? []),
      reportUrl: map['report_url'] ?? '',
      resultCounts: Map<String, dynamic>.from(map['result_counts'] ?? {}),
      status: map['status'] ?? '',
    );
  }
}
