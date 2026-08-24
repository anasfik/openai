import 'package:dart_openai/src/core/models/batch/batch.dart';

class OpenAiBatchListModel {
  final List<OpenAiBatchModel> data;
  final String firstId;
  final String lastId;
  final bool hasMore;

  OpenAiBatchListModel({
    required this.data,
    required this.firstId,
    required this.lastId,
    required this.hasMore,
  });
}

extension BatchListParsing on OpenAiBatchListModel {
  static OpenAiBatchListModel fromMap(Map<String, dynamic> map) {
    return OpenAiBatchListModel(
      data: (map['data'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(BatchModelParsing.fromMap)
          .toList(),
      firstId: map['first_id'] as String? ?? '',
      lastId: map['last_id'] as String? ?? '',
      hasMore: map['has_more'] as bool? ?? false,
    );
  }
}
