import 'package:dart_openai/src/core/models/file/file.dart';

class OpenAIFileListModel {
  final List<OpenAIFileModel> data;
  final String firstId;
  final String lastId;
  final bool hasMore;

  OpenAIFileListModel({
    required this.data,
    required this.firstId,
    required this.lastId,
    required this.hasMore,
  });

  factory OpenAIFileListModel.fromMap(Map<String, dynamic> map) {
    final List filesList = map["data"];

    final data = filesList.map((e) => OpenAIFileModel.fromMap(e)).toList();

    return OpenAIFileListModel(
      data: data,
      firstId: map['first_id'] as String,
      lastId: map['last_id'] as String,
      hasMore: map['has_more'] as bool,
    );
  }
}
