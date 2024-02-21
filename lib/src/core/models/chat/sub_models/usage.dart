export 'choices/sub_models/message.dart';

/// {@template openai_chat_completion_usage_model}
/// This class represents the chat completion usage model of the OpenAI API, which is used and get returned while using the [OpenAIChat] methods.
/// {@endtemplate}
final class OpenAIChatCompletionUsageModel {
  /// The number of tokens used for the prompt(s).
  final int promptTokens;

  /// The number of tokens used for the chat completion(s).
  final int completionTokens;

  /// The total number of tokens used for the chat completion(s).
  /// This is the sum of [promptTokens] and [completionTokens].
  final int totalTokens;

  @override
  int get hashCode {
    return promptTokens.hashCode ^
        completionTokens.hashCode ^
        totalTokens.hashCode;
  }

  /// {@macro openai_chat_completion_usage_model}
  const OpenAIChatCompletionUsageModel({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  /// This is used  to convert a [Map<String, dynamic>] object to a [OpenAIChatCompletionUsageModel] object.
  factory OpenAIChatCompletionUsageModel.fromMap(Map<String, dynamic> json) {
    return OpenAIChatCompletionUsageModel(
      promptTokens: json['prompt_tokens'],
      completionTokens: json['completion_tokens'],
      totalTokens: json['total_tokens'],
    );
  }

  /// This is used to convert a [OpenAIChatCompletionUsageModel] object to a [Map<String, dynamic>] object.
  Map<String, dynamic> toMap() {
    return {
      "prompt_tokens": promptTokens,
      "completion_tokens": completionTokens,
      "total_tokens": totalTokens,
    };
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
