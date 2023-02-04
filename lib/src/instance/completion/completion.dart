import 'package:openai/src/core/builder/base_api_url.dart';
import 'package:openai/src/core/networking/client.dart';
import 'package:openai/src/core/utils/logger.dart';
import 'package:openai/src/core/models/completion/completion.dart';

import '../../core/base/completion.dart';

class OpenAICompletion implements OpenAICompletionBase {
  @override
  String get endpoint => "/completions";

  /// This function creates a completion.
  /// Given a prompt, the model will return one or more predicted completions, and can also return the probabilities of alternative tokens at each position.
  /// Example:
  /// ```dart
  /// OpenAICompletionModel completion = await OpenAI.instance.completion.create(
  ///  model: "text-davinci-003",
  ///  prompt: "Dart is ",
  /// );
  /// ```
  @override
  Future<OpenAICompletionModel> create({
    required String model,
    dynamic prompt,
    String? suffix,
    int? maxTokens,
    double? temperature,
    double? topP,
    int? n,
    int? logprobs,
    int? echo,
    dynamic stop,
    double? presencePenalty,
    double? frequencyPenalty,
    int? bestOf,
    Map<String, dynamic>? logitBias,
    String? user,
  }) async {
    assert(
      prompt is String || prompt is List<String> || prompt == null,
      "prompt field must be a String or List<String>",
    );

    assert(
      stop is String || stop is List<String> || stop == null,
      "stop field must be a String or List<String>",
    );

    return await OpenAINetworkingClient.post<OpenAICompletionModel>(
      to: BaseApiUrlBuilder.build(endpoint),
      body: {
        "model": model,
        if (prompt != null) "prompt": prompt,
        if (suffix != null) "suffix": suffix,
        if (maxTokens != null) "max_tokens": maxTokens,
        if (temperature != null) "temperature": temperature,
        if (topP != null) "top_p": topP,
        if (n != null) "n": n,
        if (logprobs != null) "logprobs": logprobs,
        if (echo != null) "echo": echo,
        if (stop != null) "stop": stop,
        if (presencePenalty != null) "presence_penalty": presencePenalty,
        if (frequencyPenalty != null) "frequency_penalty": frequencyPenalty,
        if (bestOf != null) "best_of": bestOf,
        if (logitBias != null) "logit_bias": logitBias,
        if (user != null) "user": user,
      },
      onSuccess: (Map<String, dynamic> response) {
        return OpenAICompletionModel.fromJson(response);
      },
    );
  }

  /// This function creates a completion stream, which is a stream of completion models.
  /// Example:
  /// ```dart
  /// Stream<OpenAIStreamCompletionModel> completionStream = OpenAI.instance.completion.createStream(
  ///  model: "text-davinci-003",
  ///  prompt: "Dart is ",
  /// );
  /// ```
  @override
  Stream<OpenAIStreamCompletionModel> createStream({
    required String model,
    prompt,
    String? suffix,
    int? maxTokens,
    double? temperature,
    double? topP,
    int? n,
    int? logprobs,
    int? echo,
    String? stop,
    double? presencePenalty,
    double? frequencyPenalty,
    int? bestOf,
    Map<String, dynamic>? logitBias,
    String? user,
  }) {
    return OpenAINetworkingClient.postStream<OpenAIStreamCompletionModel>(
      to: BaseApiUrlBuilder.build(endpoint),
      body: {
        "model": model,
        'stream': true,
        if (prompt != null) "prompt": prompt,
        if (suffix != null) "suffix": suffix,
        if (maxTokens != null) "max_tokens": maxTokens,
        if (temperature != null) "temperature": temperature,
        if (topP != null) "top_p": topP,
        if (n != null) "n": n,
        if (logprobs != null) "logprobs": logprobs,
        if (echo != null) "echo": echo,
        if (stop != null) "stop": stop,
        if (presencePenalty != null) "presence_penalty": presencePenalty,
        if (frequencyPenalty != null) "frequency_penalty": frequencyPenalty,
        if (bestOf != null) "best_of": bestOf,
        if (logitBias != null) "logit_bias": logitBias,
        if (user != null) "user": user,
      },
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIStreamCompletionModel.fromJson(response);
      },
    );
  }

  /// This function creates a completion stream and returns a stream of strings result directly.
  /// Example:
  /// ```dart
  /// Stream<String> completionStream = OpenAI.instance.completion.createStreamText(
  ///  model: "text-davinci-003",
  ///  prompt: "Dart is ",
  /// );
  /// ```
  @override
  Stream<String> createStreamText({
    required String model,
    prompt,
    String? suffix,
    int? maxTokens,
    double? temperature,
    double? topP,
    int? n,
    int? logprobs,
    int? echo,
    String? stop,
    double? presencePenalty,
    double? frequencyPenalty,
    int? bestOf,
    Map<String, dynamic>? logitBias,
    String? user,
  }) {
    Stream<OpenAIStreamCompletionModel> stream = createStream(
      model: model,
      prompt: prompt,
      suffix: suffix,
      maxTokens: maxTokens,
      temperature: temperature,
      topP: topP,
      n: n,
      logprobs: logprobs,
      echo: echo,
      stop: stop,
      presencePenalty: presencePenalty,
      frequencyPenalty: frequencyPenalty,
      bestOf: bestOf,
      logitBias: logitBias,
      user: user,
    );

    return stream.map((event) => event.choices.first.text);
  }

  OpenAICompletion() {
    OpenAILogger.logEndpoint(endpoint);
  }
}
