/// {@template openai_stream_chat_completion_choice_delta_model}
/// This contains the [role] and [content] of the choice of the chat response.
/// {@endtemplate}
final class OpenAIStreamChatCompletionChoiceDeltaModel {
  /// The [role] of the choice.
  final String? role;

  /// The [content] of the choice.
  final String? content;

  @override
  int get hashCode {
    return role.hashCode ^ content.hashCode;
  }

  /// {@macro openai_stream_chat_completion_choice_delta_model}
  const OpenAIStreamChatCompletionChoiceDeltaModel({
    required this.role,
    required this.content,
  });

  /// {@macro openai_stream_chat_completion_choice_delta_model}
  factory OpenAIStreamChatCompletionChoiceDeltaModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return OpenAIStreamChatCompletionChoiceDeltaModel(
      role: json['role'],
      content: json['content'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "role": role,
      "content": content,
    };
  }

  @override
  String toString() {
    return 'OpenAIStreamChatCompletionChoiceMessageModel(role: $role, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OpenAIStreamChatCompletionChoiceDeltaModel &&
        other.role == role &&
        other.content == content;
  }
}
