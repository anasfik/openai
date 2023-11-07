import '../../../../../functions/functions.dart';

/// {@template openai_stream_chat_completion_choice_delta_model}
/// This contains the [role] and [content] of the choice of the chat response.
/// {@endtemplate}
final class OpenAIStreamChatCompletionChoiceDeltaModel {
  /// The [role] of the message.
  final String? role;

  /// The [content] of the message.
  final String content;

  /// The function that the model is requesting to call.
  final StreamFunctionCallResponse? functionCall;

  /// The name of the function that was called.
  final String? functionName;

  bool get hasFunctionCall => functionCall != null;

  @override
  int get hashCode {
    return role.hashCode ^
        content.hashCode ^
        functionCall.hashCode ^
        functionName.hashCode;
  }

  /// {@macro openai_chat_completion_choice_message_model}
  const OpenAIStreamChatCompletionChoiceDeltaModel({
    required this.role,
    required this.content,
    this.functionCall,
    this.functionName,
  });

  /// This is used  to convert a [Map<String, dynamic>] object to a [OpenAIChatCompletionChoiceMessageModel] object.
  factory OpenAIStreamChatCompletionChoiceDeltaModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return OpenAIStreamChatCompletionChoiceDeltaModel(
      role: json['role'],
      content: json['content'] ?? '',
      functionCall: json['function_call'] != null
          ? StreamFunctionCallResponse.fromMap(json['function_call'])
          : null,
    );
  }

  /// This method used to convert the [OpenAIChatCompletionChoiceMessageModel] to a [Map<String, dynamic>] object.
  Map<String, dynamic> toMap() {
    return {
      "role": role,
      "content": content,
      if (functionCall != null) "function_call": functionCall!.toMap(),
      if (functionName != null) "name": functionName,
    };
  }

  @override
  String toString() {
    String str = 'OpenAIChatCompletionChoiceMessageModel('
        'role: $role, '
        'content: $content, ';
    if (functionCall != null) {
      str += 'functionCall: $functionCall, ';
    }
    if (functionName != null) {
      str += 'functionName: $functionName, ';
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
        other.functionCall == functionCall &&
        other.functionName == functionName;
  }
}
