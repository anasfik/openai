import 'sub_models/delta.dart';
export "sub_models/delta.dart";
class OpenAIStreamChatCompletionChoiceModel {
  final int index;
  final OpenAIStreamChatCompletionChoiceDeltaModel delta;
  final String? finishReason;

  @override
  int get hashCode {
    return index.hashCode ^ delta.hashCode ^ finishReason.hashCode;
  }

  OpenAIStreamChatCompletionChoiceModel({
    required this.index,
    required this.delta,
    required this.finishReason,
  });

  factory OpenAIStreamChatCompletionChoiceModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return OpenAIStreamChatCompletionChoiceModel(
      index: json['index'],
      delta: OpenAIStreamChatCompletionChoiceDeltaModel.fromJson(json['delta']),
      finishReason: json['finish_reason'],
    );
  }

  @override
  String toString() {
    return 'OpenAIStreamChatCompletionChoiceModel(index: $index, delta: $delta, finishReason: $finishReason)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OpenAIStreamChatCompletionChoiceModel &&
        other.index == index &&
        other.delta == delta &&
        other.finishReason == finishReason;
  }
}
