import 'package:dart_openai/dart_openai.dart';

import '../../../../etc/message_adapter.dart';

/// {@template openai_stream_chat_completion_choice_delta_model}
/// This contains the [role] and [content] of the choice of the chat response.
/// {@endtemplate}
final class OpenAIStreamChatCompletionChoiceDeltaModel {
  /// The [role] of the message.
  final OpenAIChatMessageRole? role;

  /// The [content] of the message.
  final List<OpenAIChatCompletionChoiceMessageContentItemModel?>? content;

  /// The [toolCalls] of the message.
  final List<OpenAIResponseToolCall>? toolCalls;

  /// Weither the message have a role or not.
  bool get haveToolCalls => toolCalls != null;

  /// Weither the message have a role or not.
  bool get haveRole => role != null;

  /// Weither the message have a content or not.
  bool get haveContent => content != null;

  @override
  int get hashCode {
    return role.hashCode ^ content.hashCode ^ toolCalls.hashCode;
  }

  /// {@macro openai_chat_completion_choice_message_model}
  const OpenAIStreamChatCompletionChoiceDeltaModel({
    required this.role,
    required this.content,
    this.toolCalls,
  });

  /// This is used  to convert a [Map<String, dynamic>] object to a [OpenAIChatCompletionChoiceMessageModel] object.
  factory OpenAIStreamChatCompletionChoiceDeltaModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return OpenAIStreamChatCompletionChoiceDeltaModel(
      role: json['role'] != null
          ? OpenAIChatMessageRole.values
              .firstWhere((role) => role.name == json['role'])
          : null,
      content: json['content'] != null
          ? OpenAIMessageDynamicContentFromFieldAdapter.dynamicContentFromField(
              json['content'],
            )
          : null,
      toolCalls: json['tool_calls'] != null
          ? (json['tool_calls'] as List)
              .map((toolCall) => OpenAIStreamResponseToolCall.fromMap(toolCall))
              .toList()
          : null,
    );
  }

  /// This method used to convert the [OpenAIChatCompletionChoiceMessageModel] to a [Map<String, dynamic>] object.
  Map<String, dynamic> toMap() {
    return {
      "role": role?.name,
      "content": content,
      "tool_calls": toolCalls?.map((toolCall) => toolCall.toMap()).toList(),
    };
  }

  @override
  String toString() {
    String str = 'OpenAIChatCompletionChoiceMessageModel('
        'role: $role, '
        'content: $content, ';
    if (toolCalls != null) {
      str += 'toolCalls: $toolCalls, ';
    }

    str += ')';

    return str;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OpenAIStreamChatCompletionChoiceDeltaModel &&
        other.role == role &&
        other.content == content &&
        other.toolCalls == toolCalls;
  }
}
