class OpenAIChatCompletionUsageModel {
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;

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
}
