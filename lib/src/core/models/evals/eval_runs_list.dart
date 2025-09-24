import 'package:dart_openai/src/core/models/evals/eval.dart';

class OpenAIEvalRunsList {
  final List<OpenAIEval> data;
  final String firstId;
  final String lastId;
  final bool hasMore;

  OpenAIEvalRunsList({
    required this.data,
    required this.firstId,
    required this.lastId,
    required this.hasMore,
  });

  factory OpenAIEvalRunsList.fromMap(Map<String, dynamic> map) {
    return OpenAIEvalRunsList(
      data: List<OpenAIEval>.from(
        map['data']?.map(
          (x) => OpenAIEval.fromMap(x),
        ),
      ),
      firstId: map['first_id'] ?? '',
      lastId: map['last_id'] ?? '',
      hasMore: map['has_more'] ?? false,
    );
  }
}
