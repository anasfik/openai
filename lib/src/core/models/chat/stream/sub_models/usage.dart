export "choices/choices.dart";

/// {@template openai_stream_chat_completion_usage}
/// The [OpenAIStreamChatCompletionUsageModel] class represents the usage model of the OpenAI API, which is used and get returned while using the chat methods that leverages [Stream] functionality.
/// {@endtemplate}
final class OpenAIStreamChatCompletionUsageModel {
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

  /// {@macro openai_stream_chat_completion_usage}
  const OpenAIStreamChatCompletionUsageModel({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  /// {@macro openai_stream_chat_completion_usage}
  /// This is used  to convert a [Map<String, dynamic>] object to a [OpenAIStreamChatCompletionUsageModel] object.
  factory OpenAIStreamChatCompletionUsageModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return OpenAIStreamChatCompletionUsageModel(
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

    return other is OpenAIStreamChatCompletionUsageModel &&
        other.promptTokens == promptTokens &&
        other.completionTokens == completionTokens &&
        other.totalTokens == totalTokens;
  }
}
