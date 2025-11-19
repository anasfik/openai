import 'package:dart_openai/src/core/models/containers/container.dart';

class OpenAIContainerList {
  final List<OpenAIContainer> data;
  final String firstId;
  final String lastId;
  final bool hasMore;

  OpenAIContainerList({
    required this.data,
    required this.firstId,
    required this.lastId,
    required this.hasMore,
  });

  factory OpenAIContainerList.fromMap(Map<String, dynamic> map) {
    return OpenAIContainerList(
      data: List<OpenAIContainer>.from(
        (map['data'] as List).map<OpenAIContainer>(
          (x) => OpenAIContainer.fromMap(x as Map<String, dynamic>),
        ),
      ),
      firstId: map['first_id'] as String,
      lastId: map['last_id'] as String,
      hasMore: map['has_more'] as bool,
    );
  }
}
