import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/networking/client.dart';

import '../../core/base/chat/chat.dart';
import '../../core/models/chat/chat.dart';
import '../../core/models/chat/sub_models/choices/sub_models/message.dart';

class OpenAIChat implements OpenAIChatBase {
  @override
  String get endpoint => "/chat/completions";

  /// Creates a completion for the chat message
  ///
  /// [model] is the model to use for completion.
  ///
  /// [messages] is the list of messages to complete from, note you need to set each message as a [OpenAIChatCompletionChoiceMessageModel] object.
  ///
  /// [temperature] is the value controlling randomness in boltzmann
  ///
  /// [topP] is the cumulative probability for top-k filtering
  ///
  /// [n] is the number of results to return
  ///
  /// [stop] is the sequence to stop on. Overrides [maxTokens].
  ///
  /// [maxTokens] is the maximum number of tokens to generate.
  ///
  /// [presencePenalty] is the penalty for tokens already in the sequence.
  ///
  /// [frequencyPenalty] is the penalty for existing words in the sequence.
  ///
  /// [logitBias] is the token to bias the logit towards.
  ///
  /// [user] is the user ID to use for the completion.
  ///
  /// Returns a [OpenAIChatCompletionModel] object.
  ///
  /// Example:
  /// ```dart
  /// final chatCompletion = await OpenAI.instance.chat.create(
  /// model: "gpt-3.5-turbo",
  /// messages: [
  ///   OpenAIChatCompletionChoiceMessageModel(content: "hello, what is Flutter and Dart ?", role: "user")
  /// ]);
  /// ```
  @override
  Future<OpenAIChatCompletionModel> create({
    required String model,
    required List<OpenAIChatCompletionChoiceMessageModel> messages,
    double? temperature,
    double? topP,
    int? n,
    stop,
    int? maxTokens,
    double? presencePenalty,
    double? frequencyPenalty,
    Map<String, dynamic>? logitBias,
    String? user,
  }) async {
    return await OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.build(endpoint),
      body: {
        "model": model,
        "messages": messages.map((message) => message.toMap()).toList(),
        if (temperature != null) "temperature": temperature,
        if (topP != null) "top_p": topP,
        if (n != null) "n": n,
        if (stop != null) "stop": stop,
        if (maxTokens != null) "max_tokens": maxTokens,
        if (presencePenalty != null) "presence_penalty": presencePenalty,
        if (frequencyPenalty != null) "frequency_penalty": frequencyPenalty,
        if (logitBias != null) "logit_bias": logitBias,
        if (user != null) "user": user,
      },
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIChatCompletionModel.fromJson(response);
      },
    );
  }
}
