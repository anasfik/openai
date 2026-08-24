/// {@template openai_endpoints}
/// The class holding all endpoints for the API that are used.
/// {@endtemplate}
class OpenAIApisEndpoints {
  final containers = "/containers";

  ///
  final vectorStores = "/vector_stores";

  ///
  final evals = "/evals";

  ///
  final conversations = "/conversations";

  ///
  final responses = "/responses";

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

  /// Batch processing.
  final batch = "/batches";

  /// Uploads (multipart upload sessions).
  final uploads = "/uploads";

  /// Fine-tuning (new API).
  final fineTuning = "/fine_tuning";

  /// Videos.
  final videos = "/videos";

  /// Realtime sessions and client secrets (REST part).
  final realtime = "/realtime";

  /// Skills.
  final skills = "/skills";

  /// Content provenance checks.
  final contentProvenanceChecks = "/content_provenance_checks";

  /// Organization-level administration endpoints root.
  final organization = "/organization";

  /// {@macro openai_endpoints}
  static const OpenAIApisEndpoints _instance = OpenAIApisEndpoints._();

  /// {@macro openai_endpoints}
  static OpenAIApisEndpoints get instance => _instance;

  /// {@macro openai_endpoints}
  const OpenAIApisEndpoints._();
}
