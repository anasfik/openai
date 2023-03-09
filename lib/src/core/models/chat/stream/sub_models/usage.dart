export "choices/choices.dart";

class OpenAIStreamChatCompletionUsageModel {
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;

  @override
  int get hashCode {
    return promptTokens.hashCode ^
        completionTokens.hashCode ^
        totalTokens.hashCode;
  }

  OpenAIStreamChatCompletionUsageModel({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory OpenAIStreamChatCompletionUsageModel.fromMap(
      Map<String, dynamic> json) {
    return OpenAIStreamChatCompletionUsageModel(
      promptTokens: json['prompt_tokens'],
      completionTokens: json['completion_tokens'],
      totalTokens: json['total_tokens'],
    );
  }

  @override
  String toString() {
    return 'OpenAIChatCompletionUsageModel(promptTokens: $promptTokens, completionTokens: $completionTokens, totalTokens: $totalTokens)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OpenAIStreamChatCompletionUsageModel &&
        other.promptTokens == promptTokens &&
        other.completionTokens == completionTokens &&
        other.totalTokens == totalTokens;
  }
}
