import 'package:dart_openai/src/core/models/containers/container.dart';
import 'package:dart_openai/src/core/models/containers/container_file.dart';

class OpenAIContainerContainerFileListModel {
  final List<OpenAIContainerContainerFile> data;
  final String firstId;
  final String lastId;
  final bool hasMore;

  OpenAIContainerContainerFileListModel({
    required this.data,
    required this.firstId,
    required this.lastId,
    required this.hasMore,
  });

  factory OpenAIContainerContainerFileListModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return OpenAIContainerContainerFileListModel(
      data: List<OpenAIContainerContainerFile>.from(
        (map['data'] as List).map<OpenAIContainerContainerFile>(
          (x) =>
              OpenAIContainerContainerFile.fromMap(x as Map<String, dynamic>),
        ),
      ),
      firstId: map['first_id'] as String,
      lastId: map['last_id'] as String,
      hasMore: map['has_more'] as bool,
    );
  }
}
