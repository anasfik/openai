import 'package:meta/meta.dart';

/// {@template openai_embeddings_usage_model}
/// This class is used to represent the usage of an OpenAI embeddings.
/// {@endtemplate}
@immutable
final class OpenAIEmbeddingsUsageModel {
  /// The number of tokens in the prompt.
  final int? promptTokens;

  /// The total number of tokens in the prompt and completion.
  final int? totalTokens;

  /// Weither the usage have a prompt tokens information.
  bool get havePromptTokens => promptTokens != null;

  /// Weither the usage have a total tokens information.
  bool get haveTotalTokens => totalTokens != null;

  @override
  int get hashCode => promptTokens.hashCode ^ totalTokens.hashCode;

  /// {@macro openai_embeddings_usage_model}
  const OpenAIEmbeddingsUsageModel({
    required this.promptTokens,
    required this.totalTokens,
  });

  /// {@template openai_embeddings_usage_model}
  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIEmbeddingsUsageModel] object.
  /// {@endtemplate}
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
}
