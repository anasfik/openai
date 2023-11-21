/// {@template openai_endpoints}
/// The class holding all endpoints for the API that are used.
/// {@endtemplate}
class OpenAIApisEndpoints {
  /// none.
  final completion = "/completions";

  /// none.
  final audio = "/audio";

  /// none.
  final chat = "/chat/completions";

  /// none.
  final edits = "/edits";

  /// none.
  final embeddings = "/embeddings";

  /// none.
  final files = "/files";

  /// none.
  final fineTunes = "/fine-tunes";

  /// none.
  final images = "/images";

  /// none.
  final models = "/models";

  /// none.
  final moderation = "/moderations";

  /// {@macro openai_endpoints}
  static const OpenAIApisEndpoints _instance = OpenAIApisEndpoints._();

  /// {@macro openai_endpoints}
  static OpenAIApisEndpoints get instance => _instance;

  /// {@macro openai_endpoints}
  const OpenAIApisEndpoints._();
}
