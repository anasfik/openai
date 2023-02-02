class OpenAICompletionModelUsage {
  int promptTokens;
  int completionTokens;
  int totalTokens;

  OpenAICompletionModelUsage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory OpenAICompletionModelUsage.fromJson(Map<String, dynamic> json) {
    return OpenAICompletionModelUsage(
      promptTokens: json['prompt_tokens'],
      completionTokens: json['completion_tokens'],
      totalTokens: json['total_tokens'],
    );
  }

  @override
  bool operator ==(covariant OpenAICompletionModelUsage other) {
    if (identical(this, other)) return true;

    return other.promptTokens == promptTokens &&
        other.completionTokens == completionTokens &&
        other.totalTokens == totalTokens;
  }

  @override
  int get hashCode =>
      promptTokens.hashCode ^ completionTokens.hashCode ^ totalTokens.hashCode;

  @override
  String toString() =>
      'OpenAICompletionModelUsage(promptTokens: $promptTokens, completionTokens: $completionTokens, totalTokens: $totalTokens)';
}
