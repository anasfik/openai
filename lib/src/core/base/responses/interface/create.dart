import 'package:dart_openai/src/core/models/responses/responses.dart';

abstract class CreateInterface {
  Future<OpenAIResponseModel> create({
    bool? background,
    conversation,
    List? inlcude,
    input,
    String? instructions,
    int? maxOutputTokens,
    int? oolCalls,
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
