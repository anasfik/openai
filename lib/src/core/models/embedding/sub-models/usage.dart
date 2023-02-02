class OpenAIEmbeddingsUsageModel {
  int promptTokens;
  int totalTokens;
  OpenAIEmbeddingsUsageModel({
    required this.promptTokens,
    required this.totalTokens,
  });

  factory OpenAIEmbeddingsUsageModel.fromMap(Map<String, dynamic> map) {
    return OpenAIEmbeddingsUsageModel(
      promptTokens: map['prompt_tokens'] as int,
      totalTokens: map['total_tokens'] as int,
    );
  }

  @override
  String toString() =>
      'OpenAIEmbeddingsUsageModel(promptTokens: $promptTokens, totalTokens: $totalTokens)';

  @override
  bool operator ==(covariant OpenAIEmbeddingsUsageModel other) {
    if (identical(this, other)) return true;

    return other.promptTokens == promptTokens &&
        other.totalTokens == totalTokens;
  }

  @override
  int get hashCode => promptTokens.hashCode ^ totalTokens.hashCode;
}
