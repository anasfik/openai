import 'package:meta/meta.dart';

@immutable
class OpenAIFineTuneEventStreamModel {
  /// The level of the event.
  final String level;

  /// The message of the event.
  final String message;

  /// The time the event was created.
  final DateTime createdAt;

  @override
  int get hashCode => level.hashCode ^ message.hashCode ^ createdAt.hashCode;

  /// Creates a new instance of [OpenAIFineTuneEventStreamModel].
  const OpenAIFineTuneEventStreamModel({
    required this.level,
    required this.message,
    required this.createdAt,
  });

  /// Creates a new instance of [OpenAIFineTuneEventStreamModel] from a [Map].
  factory OpenAIFineTuneEventStreamModel.fromMap(Map<String, dynamic> json) {
    return OpenAIFineTuneEventStreamModel(
      level: json['level'] as String,
      message: json['message'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at'] * 1000),
    );
  }

  @override
  String toString() =>
      'OpenAIFineTuneEventStreamModel(level: $level, message: $message, createdAt: $createdAt)';

  @override
  bool operator ==(covariant OpenAIFineTuneEventStreamModel other) {
    if (identical(this, other)) return true;

    return other.level == level &&
        other.message == message &&
        other.createdAt == createdAt;
  }
}
