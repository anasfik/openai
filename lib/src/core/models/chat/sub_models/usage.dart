export 'choices/sub_models/message.dart';

class OpenAIChatCompletionUsageModel {
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;

  @override
  int get hashCode {
    return promptTokens.hashCode ^
        completionTokens.hashCode ^
        totalTokens.hashCode;
  }

  OpenAIChatCompletionUsageModel({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory OpenAIChatCompletionUsageModel.fromJson(Map<String, dynamic> json) {
    return OpenAIChatCompletionUsageModel(
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

    return other is OpenAIChatCompletionUsageModel &&
        other.promptTokens == promptTokens &&
        other.completionTokens == completionTokens &&
        other.totalTokens == totalTokens;
  }
}
