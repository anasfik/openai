class OpenAIFineTuneEventModel {
  final int createdAt;
  final String? level;
  final String? message;

  OpenAIFineTuneEventModel({
    required this.createdAt,
    required this.level,
    required this.message,
  });

  factory OpenAIFineTuneEventModel.fromJson(Map<String, dynamic> json) {
    return OpenAIFineTuneEventModel(
      createdAt: json['created_at'],
      level: json['level'],
      message: json['message'],
    );
  }

  @override
  String toString() =>
      'OpenAIFineTuneEventModel(createdAt: $createdAt, level: $level, message: $message)';

  @override
  bool operator ==(covariant OpenAIFineTuneEventModel other) {
    if (identical(this, other)) return true;

    return other.createdAt == createdAt &&
        other.level == level &&
        other.message == message;
  }

  @override
  int get hashCode => createdAt.hashCode ^ level.hashCode ^ message.hashCode;
}
