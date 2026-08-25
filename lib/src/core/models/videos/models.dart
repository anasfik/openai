/// Models for the /videos API.
library;

class OpenAIVideoModel {
  final String id;
  final String object;
  final int createdAt;
  final String model;
  final String prompt;
  final String status;
  final int progress;
  final String? seconds;
  final String? size;
  final dynamic error;

  OpenAIVideoModel({
    required this.id,
    required this.model,
    required this.prompt,
    required this.status,
    this.createdAt = 0,
    this.progress = 0,
    this.object = 'video',
    this.seconds,
    this.size,
    this.error,
  });

  factory OpenAIVideoModel.fromMap(Map<String, dynamic> map) {
    return OpenAIVideoModel(
      id: map['id'] as String? ?? '',
      object: map['object'] as String? ?? 'video',
      createdAt:
          map['created_at'] is num ? (map['created_at'] as num).toInt() : 0,
      model: map['model'] as String? ?? '',
      prompt: map['prompt'] as String? ?? '',
      status: map['status'] as String? ?? '',
      progress: map['progress'] is num ? (map['progress'] as num).toInt() : 0,
      seconds: map['seconds']?.toString(),
      size: map['size'] as String?,
      error: map['error'],
    );
  }
}

class OpenAIVideoList {
  final List<OpenAIVideoModel> data;
  final bool hasMore;

  OpenAIVideoList({required this.data, required this.hasMore});

  factory OpenAIVideoList.fromMap(Map<String, dynamic> map) {
    return OpenAIVideoList(
      data: (map['data'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(OpenAIVideoModel.fromMap)
          .toList(),
      hasMore: map['has_more'] as bool? ?? false,
    );
  }
}
