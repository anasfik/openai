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
