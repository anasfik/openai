import '../../models/completion/completion.dart';

import 'package:http/http.dart' as http;

abstract class CreateInterface {
  Future<OpenAICompletionModel> create({
    required String model,
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
    http.Client? client,
  });

  Stream<OpenAIStreamCompletionModel> createStream({
    required String model,
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
    http.Client? client,
  });

  Stream<String> createStreamText({
    required String model,
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
    http.Client? client,
  });
}
