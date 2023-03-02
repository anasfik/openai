import 'package:dart_openai/src/core/base/openai_client/base.dart';
import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/networking/client.dart';

import '../../core/base/chat/chat.dart';

class OpenAIChat implements OpenAIChatBase {
  @override
  String get endpoint => "/chat/completions";

  @override
  Future create({
    required String model,
    required List messages,
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
        "messages": messages,
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
        return response;
      },
    );
  }
}
