import 'package:meta/meta.dart';

@immutable
class OpenAIEditModelUsage {
  /// The number of tokens in the prompt.
  final int promptTokens;

  /// The number of tokens in the completion.
  final int completionTokens;

  /// The total number of tokens in the prompt and completion.
  final int totalTokens;

  @override
  int get hashCode =>
      promptTokens.hashCode ^ completionTokens.hashCode ^ totalTokens.hashCode;

  /// This class is used to represent the usage of an OpenAI completion.
  const OpenAIEditModelUsage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIEditModelUsage] object.
  factory OpenAIEditModelUsage.fromMap(Map<String, dynamic> json) {
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
  String toString() =>
      'OpenAIEditModelUsage(promptTokens: $promptTokens, completionTokens: $completionTokens, totalTokens: $totalTokens)';
}
