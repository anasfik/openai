import '../../../dart_openai.dart';

base class AzureOpenAIChat {
  Future<OpenAIChatCompletionModel> create({
    required List<OpenAIChatCompletionChoiceMessageModel> messages,
    List<OpenAIFunctionModel>? functions,
    FunctionCall? functionCall,
    double? temperature,
    int? n,
    stop,
    int? maxTokens,
    double? presencePenalty,
    double? frequencyPenalty,
    Map<String, dynamic>? logitBias,
    String? user,
  }) {
    return OpenAI.instance.chat.create(
      model: null,
      messages: messages,
      frequencyPenalty: frequencyPenalty,
      functions: functions,
      functionCall: functionCall,
      logitBias: logitBias,
      maxTokens: maxTokens,
      n: n,
      presencePenalty: presencePenalty,
      stop: stop,
      temperature: temperature,
      user: user,
    );
  }

  Stream<OpenAIStreamChatCompletionModel> createStream({
    required List<OpenAIChatCompletionChoiceMessageModel> messages,
    List<OpenAIFunctionModel>? functions,
    FunctionCall? functionCall,
    double? temperature,
    double? topP,
    int? n,
    stop,
    int? maxTokens,
    double? presencePenalty,
    double? frequencyPenalty,
    Map<String, dynamic>? logitBias,
    String? user,
  }) {
    return OpenAI.instance.chat.createStream(
      model: null,
      messages: messages,
      frequencyPenalty: frequencyPenalty,
      functions: functions,
      functionCall: functionCall,
      logitBias: logitBias,
      maxTokens: maxTokens,
      n: n,
      presencePenalty: presencePenalty,
      stop: stop,
      temperature: temperature,
      topP: topP,
      user: user,
    );
  }
}
