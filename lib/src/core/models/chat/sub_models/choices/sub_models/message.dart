// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../../enum.dart';
import '../../../etc/message_adapter.dart';
import 'sub_models/content.dart';
import 'sub_models/tool_call.dart';
export 'sub_models/content.dart';
export 'sub_models/tool_call.dart';

/// {@template openai_chat_completion_choice_message_model}
/// This represents the message of the [OpenAIChatCompletionChoiceModel] model of the OpenAI API, which is used and get returned while using the [OpenAIChat] methods.
/// {@endtemplate}
final class OpenAIChatCompletionChoiceMessageModel {
  /// The [role] of the message.
  final OpenAIChatMessageRole role;

  /// The [content] of the message.
  final List<OpenAIChatCompletionChoiceMessageContentItemModel>? content;

  /// The function that the model is requesting to call.
  final List<OpenAIResponseToolCall>? toolCalls;

  /// The message participent name.
  final String? name;

  /// Weither the message have tool calls.
  bool get haveToolCalls => toolCalls != null;

  /// Weither the message have content.
  bool get haveContent => content != null && content!.isNotEmpty;

  @override
  int get hashCode {
    return role.hashCode ^ content.hashCode ^ toolCalls.hashCode;
  }

  /// {@macro openai_chat_completion_choice_message_model}
  const OpenAIChatCompletionChoiceMessageModel({
    required this.role,
    required this.content,
    this.toolCalls,
    this.name,
  });

  /// This is used  to convert a [Map<String, dynamic>] object to a [OpenAIChatCompletionChoiceMessageModel] object.
  factory OpenAIChatCompletionChoiceMessageModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return OpenAIChatCompletionChoiceMessageModel(
      name: json['name'],
      role: OpenAIChatMessageRole.values
          .firstWhere((role) => role.name == json['role']),
      content: json['content'] != null
          ? OpenAIMessageDynamicContentFromFieldAdapter.dynamicContentFromField(
              json['content'],
            )
          : null,
      toolCalls: json['tool_calls'] != null
          ? (json['tool_calls'] as List)
              .map((toolCall) => OpenAIResponseToolCall.fromMap(toolCall))
              .toList()
          : null,
    );
  }

// This method used to convert the [OpenAIChatCompletionChoiceMessageModel] to a [Map<String, dynamic>] object.
  Map<String, dynamic> toMap() {
    return {
      "role": role.name,
      "content": content?.map((contentItem) => contentItem.toMap()).toList(),
      if (toolCalls != null && role == OpenAIChatMessageRole.assistant)
        "tool_calls": toolCalls!.map((toolCall) => toolCall.toMap()).toList(),
      if (name != null) "name": name,
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

    return other is OpenAIChatCompletionChoiceMessageModel &&
        other.role == role &&
        other.content == content &&
        other.toolCalls == toolCalls;
  }

  /// Converts a response function message to a request function message, so that it can be used in the next request.
  ///
  /// You should pass the response function message's [toolCallId] to this method, since it is required when requesting it.
  RequestFunctionMessage asRequestFunctionMessage({
    required String toolCallId,
  }) {
    return RequestFunctionMessage(
      content: this.content,
      role: this.role,
      toolCallId: toolCallId,
    );
  }
}

/// {@template openai_chat_completion_function_choice_message_model}
/// This represents the message of the [RequestFunctionMessage] model of the OpenAI API, which is used  while using the [OpenAIChat] methods, precisely to send a response function message as a request function message for next requests.
/// {@endtemplate}
base class RequestFunctionMessage
    extends OpenAIChatCompletionChoiceMessageModel {
  /// The [toolCallId] of the message.
  final String toolCallId;

  /// {@macro openai_chat_completion_function_choice_message_model}
  RequestFunctionMessage({
    required super.role,
    required super.content,
    required this.toolCallId,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      "role": role.name,
      "content": content?.map((toolCall) => toolCall.toMap()).toList(),
      "tool_call_id": toolCallId,
    };
  }

  //! Does this needs fromMap method?
}
