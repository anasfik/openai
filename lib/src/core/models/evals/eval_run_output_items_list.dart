import 'package:dart_openai/src/core/models/evals/eval_run_output_item.dart';

class OpenAIEvalRunOutputItemsList {
  final List<OpenAIEvalRunOutputItem> data;
  final String firstId;
  final String lastId;
  final bool hasMore;

  OpenAIEvalRunOutputItemsList({
    required this.data,
    required this.firstId,
    required this.lastId,
    required this.hasMore,
  });

  factory OpenAIEvalRunOutputItemsList.fromMap(Map<String, dynamic> map) {
    return OpenAIEvalRunOutputItemsList(
      data: List<OpenAIEvalRunOutputItem>.from(
        (map['data'] ?? [])
            .map((x) => OpenAIEvalRunOutputItem.fromMap(x))
            .toList(),
      ),
      firstId: map['first_id'] ?? '',
      lastId: map['last_id'] ?? '',
      hasMore: map['has_more'] ?? false,
    );
  }
}
