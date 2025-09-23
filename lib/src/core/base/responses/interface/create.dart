import 'package:dart_openai/src/core/models/responses/responses.dart';

abstract class CreateInterface {
  Future<OpenAiResponse> create({
    required input,
    bool? background,
    conversation,
    List? inlcude,
    String? instructions,
    int? maxOutputTokens,
    int? maxToolCalls,
    Map<String, dynamic> metadata,
    String? model,
    bool? parallelToolCalls,
    String? previousResponseId,
    prompt,
    String? promptCacheKey,
    reasoning,
    String? safetyIdentifier,
    String? serviceTier,
    bool? store,
    num? temperature,
    text,
    toolChoice,
    List tools,
    int? topLogprobs,
    num? topP,
    String? truncation,
  });
}
