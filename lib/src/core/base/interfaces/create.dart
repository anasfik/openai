import '../../models/completion/completion.dart';

abstract class CreateInterface {
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
  });
}
