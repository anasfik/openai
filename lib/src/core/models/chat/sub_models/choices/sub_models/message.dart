import '../../../../functions/functions.dart';
import '../../../../image/enum.dart';

/// {@template openai_chat_completion_choice_message_model}
/// This represents the message of the [OpenAIChatCompletionChoiceModel] model of the OpenAI API, which is used and get returned while using the [OpenAIChat] methods.
/// {@endtemplate}
final class OpenAIChatCompletionChoiceMessageModel {
  /// The [role] of the message.
  final OpenAIChatMessageRole role;

  /// The [content] of the message.
  final String content;

  /// The function that the model is requesting to call.
  final FunctionCallResponse? functionCall;

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
  const OpenAIChatCompletionChoiceMessageModel({
    required this.role,
    required this.content,
    this.functionCall,
    this.functionName,
  });

  /// This is used  to convert a [Map<String, dynamic>] object to a [OpenAIChatCompletionChoiceMessageModel] object.
  factory OpenAIChatCompletionChoiceMessageModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return OpenAIChatCompletionChoiceMessageModel(
      role: OpenAIChatMessageRole.values
          .firstWhere((role) => role.name == json['role']),
      content: json['content'] ?? '',
      functionCall: json['function_call'] != null
          ? FunctionCallResponse.fromMap(json['function_call'])
          : null,
    );
  }

  /// This method used to convert the [OpenAIChatCompletionChoiceMessageModel] to a [Map<String, dynamic>] object.
  Map<String, dynamic> toMap() {
    return {
      "role": role.name,
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

    return other is OpenAIChatCompletionChoiceMessageModel &&
        other.role == role &&
        other.content == content &&
        other.functionCall == functionCall &&
        other.functionName == functionName;
  }
}
