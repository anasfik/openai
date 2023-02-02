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

  @override
  bool operator ==(covariant OpenAIEditModelUsage other) {
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
      'OpenAIEditModelUsage(promptTokens: $promptTokens, completionTokens: $completionTokens, totalTokens: $totalTokens)';
}
