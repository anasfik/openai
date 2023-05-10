class OpenAIApisEndpoints {
  final completion = "/completions";
  final audio = "/audio";
  final chat = "/chat/completions";
  final edits = "/edits";
  final embeddings = "/embeddings";
  final files = "/files";
  final fineTunes = "/fine-tunes";
  final images = "/images";
  final models = "/models";
  final moderation = "/moderations";

  static const OpenAIApisEndpoints _instance = OpenAIApisEndpoints._();
  static OpenAIApisEndpoints get instance => _instance;
  const OpenAIApisEndpoints._();
}
