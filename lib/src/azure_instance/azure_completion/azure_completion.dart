import 'package:dart_openai/dart_openai.dart';
import 'package:dart_openai/src/core/models/completion/completion.dart';

import 'package:dart_openai/src/core/models/completion/stream/completion.dart';

import 'package:http/src/client.dart';

import '../../instance/completion/completion.dart';

class AzureOpenAICompletion {
  Future<OpenAICompletionModel> create({
    prompt,
    String? suffix,
    int? maxTokens,
    double? temperature,
    double? topP,
    int? n,
    int? logprobs,
    bool? echo,
    String? stop,
    double? presencePenalty,
    double? frequencyPenalty,
    int? bestOf,
    Map<String, dynamic>? logitBias,
    String? user,
  }) {
    return OpenAI.instance.completion.create(
      model: null,
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
  }

  Stream<OpenAIStreamCompletionModel> createStream({
    prompt,
    String? suffix,
    int? maxTokens,
    double? temperature,
    double? topP,
    int? n,
    int? logprobs,
    bool? echo,
    String? stop,
    double? presencePenalty,
    double? frequencyPenalty,
    int? bestOf,
    Map<String, dynamic>? logitBias,
    String? user,
  }) {
    return OpenAI.instance.completion.createStream(
      model: null,
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
  }

  Stream<String> createStreamText({
    prompt,
    String? suffix,
    int? maxTokens,
    double? temperature,
    double? topP,
    int? n,
    int? logprobs,
    bool? echo,
    String? stop,
    double? presencePenalty,
    double? frequencyPenalty,
    int? bestOf,
    Map<String, dynamic>? logitBias,
    String? user,
  }) {
    return OpenAI.instance.completion.createStreamText(
      model: null,
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
  }
}
