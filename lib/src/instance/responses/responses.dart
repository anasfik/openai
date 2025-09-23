import 'package:dart_openai/src/core/base/responses/responses.dart';
import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/models/responses/responses.dart';
import 'package:dart_openai/src/core/networking/client.dart';
import 'package:dart_openai/src/core/utils/logger.dart';
import 'package:meta/meta.dart';

@immutable
@protected
class OpenAIResponses extends OpenAIResponsesBase {
  @override
  String get endpoint => OpenAIStrings.endpoints.responses;

  /// {@macro openai_completion}
  OpenAIResponses() {
    OpenAILogger.logEndpoint(endpoint);
  }

  @override
  Future<OpenAiResponse> create({
    required input,
    String? model,
    bool? background,
    conversation,
    List? inlcude,
    String? instructions,
    int? maxOutputTokens,
    int? maxToolCalls,
    Map<String, dynamic>? metadata,
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
    return await OpenAINetworkingClient.post<OpenAiResponse>(
      to: BaseApiUrlBuilder.build(endpoint),
      body: {
        if (background != null) "background": background,
        if (conversation != null) "conversation": conversation,
        if (inlcude != null) "inlcude": inlcude,
        if (input != null) "input": input,
        if (instructions != null) "instructions": instructions,
        if (maxOutputTokens != null) "max_output_tokens": maxOutputTokens,
        if (maxToolCalls != null) "max_tool_calls": maxToolCalls,
        if (metadata != null) "metadata": metadata,
        if (model != null) "model": model,
        if (parallelToolCalls != null) "parallel_tool_calls": parallelToolCalls,
        if (prompt != null) "prompt": prompt,
        if (promptCacheKey != null) "prompt_cache_key": promptCacheKey,
        if (reasoning != null) "reasoning": reasoning,
        if (safetyIdentifier != null) "safety_identifier": safetyIdentifier,
        if (serviceTier != null) "service_tier": serviceTier,
        if (store != null) "store": store,
        if (temperature != null) "temperature": temperature,
        if (text != null) "text": text,
        if (toolChoice != null) "tool_choice": toolChoice,
        if (tools != null) "tools": tools,
        if (topLogprobs != null) "top_logprobs": topLogprobs,
        if (topP != null) "top_p": topP,
        if (truncation != null) "truncation": truncation,
      },
      onSuccess: (Map<String, dynamic> response) {
        return OpenAiResponse.fromMap(response);
      },
    );
  }

  @override
  Future<OpenAiResponse> cancel({
    required String responseId,
  }) async {
    return await OpenAINetworkingClient.post<OpenAiResponse>(
      to: BaseApiUrlBuilder.build(
        endpoint,
        responseId + '/cancel',
      ),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAiResponse.fromMap(response);
      },
    );
  }

  @override
  Future<void> delete({
    required String responseId,
  }) async {
    await OpenAINetworkingClient.delete(
      from: BaseApiUrlBuilder.build(endpoint, responseId),
      onSuccess: (Map<String, dynamic> response) {},
    );
  }

  @override
  Future<OpenAiResponse> get({
    required String responseId,
    List? include,
    bool? include_obfuscation,
    int? startingAfter,
  }) async {
    return await OpenAINetworkingClient.get<OpenAiResponse>(
      from: BaseApiUrlBuilder.build(
        endpoint,
        responseId,
      ),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAiResponse.fromMap(response);
      },
    );
  }
}
