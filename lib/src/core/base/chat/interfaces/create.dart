import '../../../models/chat/sub_models/choices/sub_models/message.dart';

abstract class CreateInterface {
  Future create({
    required String model,
    required List<OpenAIChatCompletionChoiceMessageModel> messages,
    double? temperature,
    double? topP,
    int? n,
    dynamic stop,
    int? maxTokens,
    double? presencePenalty,
    double? frequencyPenalty,
    Map<String, dynamic>? logitBias,
    String? user,
  });
}
