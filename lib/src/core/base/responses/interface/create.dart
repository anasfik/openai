import 'package:dart_openai/src/core/models/responses/responses.dart';

abstract class CreateInterface {
  Future<OpenAiResponse> create({
    required dynamic input,
    bool? background,
    dynamic conversation,
    List? include,
    String? instructions,
    int? maxOutputTokens,
    int? maxToolCalls,
    Map<String, dynamic> metadata,
    String? model,
    bool? parallelToolCalls,
    String? previousResponseId,
    dynamic prompt,
    String? promptCacheKey,
    dynamic reasoning,
    String? safetyIdentifier,
    String? serviceTier,
    bool? store,
    num? temperature,
    dynamic text,
    dynamic toolChoice,
    List tools,
    int? topLogprobs,
    num? topP,
    String? truncation,
  });
}
