/// {@template openai_chat_completion_choice_message_model}
/// This represents the message of the [OpenAIChatCompletionChoiceModel] model of the OpenAI API, which is used and get returned while using the [OpenAIChat] methods.
/// {@endtemplate}

class OpenAIChatCompletionChoiceMessageModel {
  /// The [role] of the message.
  final String role;

  /// The [content] of the message.
  final String content;

  @override
  int get hashCode {
    return role.hashCode ^ content.hashCode;
  }

  /// {@macro openai_chat_completion_choice_message_model}
  OpenAIChatCompletionChoiceMessageModel({
    required this.role,
    required this.content,
  });

  /// This is used  to convert a [Map<String, dynamic>] object to a [OpenAIChatCompletionChoiceMessageModel] object.
  factory OpenAIChatCompletionChoiceMessageModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return OpenAIChatCompletionChoiceMessageModel(
      role: json['role'],
      content: json['content'],
    );
  }

  /// This method used to convert the [OpenAIChatCompletionChoiceMessageModel] to a [Map<String, dynamic>] object.
  Map<String, dynamic> toMap() {
    return {
      "role": role,
      "content": content,
    };
  }

  @override
  String toString() {
    return 'OpenAIChatCompletionChoiceMessageModel(role: $role, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OpenAIChatCompletionChoiceMessageModel &&
        other.role == role &&
        other.content == content;
  }
}
