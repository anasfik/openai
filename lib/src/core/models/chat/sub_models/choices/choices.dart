import 'sub_models/message.dart';

/// {@template openai_chat_completion_choice}
/// This class represents a choice of the [OpenAIChatCompletionModel] model of the OpenAI API, which is used and get returned while using the [OpenAIChat] methods.
/// {@endtemplate}
class OpenAIChatCompletionChoiceModel {
  /// The [index] of the choice.
  final int index;

  /// The [message] of the choice.
  final OpenAIChatCompletionChoiceMessageModel message;

  /// The [finishReason] of the choice.
  final String? finishReason;

  @override
  int get hashCode {
    return index.hashCode ^ message.hashCode ^ finishReason.hashCode;
  }

  /// {@macro openai_chat_completion_choice}
  OpenAIChatCompletionChoiceModel({
    required this.index,
    required this.message,
    required this.finishReason,
  });

  /// This is used  to convert a [Map<String, dynamic>] object to a [OpenAIChatCompletionChoiceModel] object.
  factory OpenAIChatCompletionChoiceModel.fromMap(Map<String, dynamic> json) {
    return OpenAIChatCompletionChoiceModel(
      index: json['index'],
      message: OpenAIChatCompletionChoiceMessageModel.fromMap(json['message']),
      finishReason: json['finish_reason'],
    );
  }

  /// This method used to convert the [OpenAIChatCompletionChoiceModel] to a [Map<String, dynamic>] object.
  Map<String, dynamic> toMap() {
    return {
      "index": index,
      "message": message.toMap(),
      "finish_reason": finishReason,
    };
  }

  @override
  String toString() {
    return 'OpenAIChatCompletionChoiceModel(index: $index, message: $message, finishReason: $finishReason)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OpenAIChatCompletionChoiceModel &&
        other.index == index &&
        other.message == message &&
        other.finishReason == finishReason;
  }
}
