import 'package:dart_openai/src/core/base/responses/responses.dart';
import 'package:dart_openai/src/core/models/responses/responses.dart';
import 'package:meta/meta.dart';

@immutable
@protected
class OpenAIResponses extends OpenAIResponsesBase {
  @override
  Future<OpenAIResponseModel> create({
    bool? background,
    conversation,
    List? inlcude,
    input,
    String? instructions,
    int? maxOutputTokens,
    int? oolCalls,
    Map<String, dynamic>? metadata,
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
    List? tools,
    int? topLogprobs,
    num? topP,
    String? truncation,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<OpenAIResponseModel> cancel({
    required String responseId,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<void> delete({
    required String responseId,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<OpenAIResponseModel> get({
    required String responseId,
    List? include,
    bool? include_obfuscation,
    int? startingAfter,
  }) {
    throw UnimplementedError();
  }
}
