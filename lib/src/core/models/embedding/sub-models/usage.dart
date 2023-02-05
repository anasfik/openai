class OpenAIEmbeddingsUsageModel {
  /// The number of tokens in the prompt.
  int? promptTokens;

  /// The total number of tokens in the prompt and completion.
  int? totalTokens;

  /// This class is used to represent the usage of an OpenAI embeddings.
  OpenAIEmbeddingsUsageModel({
    required this.promptTokens,
    required this.totalTokens,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIEmbeddingsUsageModel] object.
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
