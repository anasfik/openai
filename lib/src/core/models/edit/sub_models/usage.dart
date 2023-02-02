class OpenAIEditModelUsage {
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;

  OpenAIEditModelUsage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory OpenAIEditModelUsage.fromJson(Map<String, dynamic> json) {
    return OpenAIEditModelUsage(
      promptTokens: json['prompt_tokens'],
      completionTokens: json['completion_tokens'],
      totalTokens: json['total_tokens'],
    );
  }
}
