import 'package:dart_openai/dart_openai.dart';


/// {@template openai_stream_chat_completion_choice_delta_model}
/// This contains the [role] and [content] of the choice of the chat response.
/// {@endtemplate}
final class OpenAIStreamChatCompletionChoiceDeltaModel {
  /// The [role] of the message.
  final OpenAIChatMessageRole? role;

  /// The [content] of the message.
  final List<OpenAIChatCompletionChoiceMessageContentItemModel>? content;

//
  final List<OpenAIResponseToolCall>? toolCalls;

  // /// The function that the model is requesting to call.
  // final StreamFunctionCallResponse? functionCall;

  bool get hasToolCalls => toolCalls != null;

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
          ? dynamicContentFromField(json['content'])
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

  static List<OpenAIChatCompletionChoiceMessageContentItemModel>
      dynamicContentFromField(
    dynamic fieldData,
  ) {
    if (fieldData is String) {
      return [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(fieldData),
      ];
    } else if (fieldData is List) {
      return (fieldData).map(
        (item) {
          if (item is! Map) {
            throw Exception('Invalid content item');
          } else {
            final asMap = item as Map<String, dynamic>;

            return OpenAIChatCompletionChoiceMessageContentItemModel.fromMap(
              asMap,
            );
          }
        },
      ).toList();
    } else {
      throw Exception('Invalid content');
    }
  }
}
