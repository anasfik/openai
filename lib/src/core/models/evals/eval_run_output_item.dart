class OpenAIEvalRunOutputItem {
  final int createdAt;
  final Map<String, dynamic> dataSourceItem;
  final String dataSourceItemId;
  final String evalId;
  final String id;
  final List results;
  final String runId;
  final Map<String, dynamic> sample;
  final String status;

  OpenAIEvalRunOutputItem({
    required this.createdAt,
    required this.dataSourceItem,
    required this.dataSourceItemId,
    required this.evalId,
    required this.id,
    required this.results,
    required this.runId,
    required this.sample,
    required this.status,
  });

  factory OpenAIEvalRunOutputItem.fromMap(Map<String, dynamic> map) {
    return OpenAIEvalRunOutputItem(
      createdAt: map['created_at']?.toInt() ?? 0,
      dataSourceItem: Map<String, dynamic>.from(map['data_source_item'] ?? {}),
      dataSourceItemId: map['data_source_item_id'] ?? '',
      evalId: map['eval_id'] ?? '',
      id: map['id'] ?? '',
      results: List.from(map['results'] ?? []),
      runId: map['run_id'] ?? '',
      sample: Map<String, dynamic>.from(map['sample'] ?? {}),
      status: map['status'] ?? '',
    );
  }
}
