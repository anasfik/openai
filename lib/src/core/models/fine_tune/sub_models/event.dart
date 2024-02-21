import 'package:meta/meta.dart';

/// {@template openai_fine_tune_event_model}
/// This class is used to represent an OpenAI fine-tune event.
/// {@endtemplate}
@immutable
final class OpenAIFineTuneEventModel {
  /// The date the event was [created].
  final DateTime createdAt;

  /// The [level] of the event.
  final String? level;

  /// The [message] of the event.
  final String? message;

  /// Weither the event have a level.
  bool get haveLevel => level != null;

  /// Weither the event have a message.
  bool get haveMessage => message != null;

  @override
  int get hashCode => createdAt.hashCode ^ level.hashCode ^ message.hashCode;

  /// {@macro openai_fine_tune_event_model}
  const OpenAIFineTuneEventModel({
    required this.createdAt,
    required this.level,
    required this.message,
  });

  /// {@macro openai_fine_tune_event_model}
  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIFineTuneEventModel] object.
  factory OpenAIFineTuneEventModel.fromMap(Map<String, dynamic> json) {
    return OpenAIFineTuneEventModel(
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at'] * 1000),
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
}
