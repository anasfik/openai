import 'package:collection/collection.dart';

import 'sub_models/choices/choices.dart';

export 'sub_models/choices/choices.dart';
export 'sub_models/usage.dart';

/// {@template openai_stream_chat_completion}
/// The [OpenAIStreamChatCompletionModel] class represents the chat completion response model of the OpenAI API, which is used and get returned while using the chat methods that leverages [Stream] functionality.
/// {@endtemplate}
final class OpenAIStreamChatCompletionModel {
  /// The [id] of the chat completion.
  final String id;

  /// The date and time when the chat completion is [created].
  final DateTime created;

  /// The [choices] of the chat completion.
  final List<OpenAIStreamChatCompletionChoiceModel> choices;

  /// Weither the chat completion have at least one choice in [choices].
  bool get haveChoices => choices.isNotEmpty;

  @override
  int get hashCode {
    return id.hashCode ^ created.hashCode ^ choices.hashCode;
  }

  /// {@macro openai_stream_chat_completion}
  const OpenAIStreamChatCompletionModel({
    required this.id,
    required this.created,
    required this.choices,
  });

  /// {@macro openai_stream_chat_completion}
  /// This is used  to convert a [Map<String, dynamic>] object to a [OpenAIStreamChatCompletionModel] object.
  factory OpenAIStreamChatCompletionModel.fromMap(Map<String, dynamic> json) {
    return OpenAIStreamChatCompletionModel(
      id: json['id'],
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000),
      choices: (json['choices'] as List)
          .map((e) => OpenAIStreamChatCompletionChoiceModel.fromMap(e))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'OpenAIStreamChatCompletionModel(id: $id, created: $created, choices: $choices)';
  }

  @override
  bool operator ==(Object other) {
    const ListEquality listEquals = ListEquality();
    if (identical(this, other)) return true;

    return other is OpenAIStreamChatCompletionModel &&
        other.id == id &&
        other.created == created &&
        listEquals.equals(other.choices, choices);
  }
}
