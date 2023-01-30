import 'package:openai/src/core/builder/base_api_url.dart';
import 'package:openai/src/core/networking/client.dart';
import 'package:openai/src/instance/model/completion.dart';

import '../../core/base/completion.dart';

class OpenAICompletion implements OpenAICompletionBase {
  @override
  String get endpoint => "/completions";

  @override
  Future<OpenAICompletionModel> create({
    required String model,
    dynamic prompt,
    String? suffix,
    int? maxTokens,
    double? temperature,
    double? topP,
    int? n,
    bool? stream,
    int? logprobs,
    int? echo,
    String? stop,
    double? presencePenalty,
    double? frequencyPenalty,
    int? bestOf,
    Map<String, dynamic>? logitBias,
    String? user,
  }) async {
    assert(
      prompt is String || prompt is List<String>,
      "Prompt must be a String or List<String>",
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
        if (stream != null) "stream": stream,
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
}
