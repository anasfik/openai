import 'sub_models/message.dart';

class OpenAIChatCompletionChoiceModel {
  final int index;
  final OpenAIChatCompletionChoiceMessageModel message;
  final String? finishReason;

  @override
  int get hashCode {
    return index.hashCode ^ message.hashCode ^ finishReason.hashCode;
  }

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
