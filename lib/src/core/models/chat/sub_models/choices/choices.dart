import 'sub_models/message.dart';

class OpenAIChatCompletionChoiceModel {
  final int index;
  final OpenAIChatCompletionChoiceMessageModel message;
  final String finishReason;

  OpenAIChatCompletionChoiceModel({
    required this.index,
    required this.message,
    required this.finishReason,
  });

  factory OpenAIChatCompletionChoiceModel.fromJson(Map<String, dynamic> json) {
    return OpenAIChatCompletionChoiceModel(
      index: json['index'],
      message: OpenAIChatCompletionChoiceMessageModel.fromJson(json['message']),
      finishReason: json['finish_reason'],
    );
  }
}
