import '../../../dart_openai.dart';
import '../../instance/chat/chat.dart';

base class AzureOpenAIChat extends OpenAIChat {
  Future<OpenAIChatCompletionModel> createCompletion({
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
    return super.create(
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

  Stream<OpenAIStreamChatCompletionModel> createStreamCompletion({
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
    return super.createStream(
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
