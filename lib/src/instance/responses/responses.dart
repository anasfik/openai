// ignore_for_file: non_constant_identifier_names
import 'package:dart_openai/src/core/base/responses/responses.dart';
import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/config/client_config.dart';
import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/models/responses/responses.dart';
import 'package:dart_openai/src/core/networking/client.dart';
import 'package:dart_openai/src/core/utils/logger.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

@immutable
@protected
class OpenAIResponses extends OpenAIResponsesBase {
  @override
  String get endpoint => OpenAIStrings.endpoints.responses;

  /// Per-client configuration; when null, global statics are used.
  final OpenAIClientConfig? _config;

  /// {@macro openai_completion}
  OpenAIResponses([this._config]) {
    OpenAILogger.logEndpoint(endpoint);
  }

  @override
  Future<OpenAiResponse> create({
    required dynamic input,
    String? model,
    bool? background,
    dynamic conversation,
    List? include,
    String? instructions,
    int? maxOutputTokens,
    int? maxToolCalls,
    Map<String, dynamic>? metadata,
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
    List? tools,
    int? topLogprobs,
    num? topP,
    String? truncation,
  }) async {
    return OpenAINetworkingClient.post<OpenAiResponse>(
        to: BaseApiUrlBuilder.buildFor(_config, endpoint),
        body: {
          if (background != null) 'background': background,
          if (conversation != null) 'conversation': conversation,
          if (include != null) 'include': include,
          if (input != null) 'input': input,
          if (instructions != null) 'instructions': instructions,
          if (maxOutputTokens != null) 'max_output_tokens': maxOutputTokens,
          if (maxToolCalls != null) 'max_tool_calls': maxToolCalls,
          if (metadata != null) 'metadata': metadata,
          if (model != null) 'model': model,
          if (parallelToolCalls != null)
            'parallel_tool_calls': parallelToolCalls,
          if (previousResponseId != null)
            'previous_response_id': previousResponseId,
          if (prompt != null) 'prompt': prompt,
          if (promptCacheKey != null) 'prompt_cache_key': promptCacheKey,
          if (reasoning != null) 'reasoning': reasoning,
          if (safetyIdentifier != null) 'safety_identifier': safetyIdentifier,
          if (serviceTier != null) 'service_tier': serviceTier,
          if (store != null) 'store': store,
          if (temperature != null) 'temperature': temperature,
          if (text != null) 'text': text,
          if (toolChoice != null) 'tool_choice': toolChoice,
          if (tools != null) 'tools': tools,
          if (topLogprobs != null) 'top_logprobs': topLogprobs,
          if (topP != null) 'top_p': topP,
          if (truncation != null) 'truncation': truncation,
        },
        onSuccess: (Map<String, dynamic> response) {
          return OpenAiResponse.fromMap(response);
        },
        config: _config);
  }

  @override
  Future<OpenAiResponse> cancel({
    required String responseId,
  }) async {
    return OpenAINetworkingClient.post<OpenAiResponse>(
        to: BaseApiUrlBuilder.buildFor(_config, endpoint, '$responseId/cancel'),
        onSuccess: (Map<String, dynamic> response) {
          return OpenAiResponse.fromMap(response);
        },
        config: _config);
  }

  @override
  Future<void> delete({
    required String responseId,
  }) async {
    await OpenAINetworkingClient.delete(
      from: BaseApiUrlBuilder.buildFor(_config, endpoint, responseId),
      onSuccess: (Map<String, dynamic> response) {
        final deleted = response['deleted'];

        return deleted is bool && deleted;
      },
      config: _config,
    );
  }

  @override
  Future<OpenAiResponse> get({
    required String responseId,
    List<String>? include,
    bool? include_obfuscation,
    int? startingAfter,
  }) async {
    return OpenAINetworkingClient.get<OpenAiResponse>(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: endpoint,
        id: responseId,
        query: {
          if (include != null) 'include': include.join(','),
          if (include_obfuscation != null)
            'include_obfuscation': include_obfuscation.toString(),
          if (startingAfter != null) 'starting_after': startingAfter.toString(),
        },
        config: _config,
      ),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAiResponse.fromMap(response);
      },
    );
  }

  @override
  Future<OpenAiResponseInputItemsList> listInputItems({
    required String responseId,
    String? after,
    List<String>? include,
    int? limit,
    String? order,
  }) async {
    return OpenAINetworkingClient.get<OpenAiResponseInputItemsList>(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: endpoint,
        id: '$responseId/input_items',
        query: {
          if (after != null) 'after': after,
          if (include != null) 'include': include.join(','),
          if (limit != null) 'limit': limit.toString(),
          if (order != null) 'order': order,
        },
        config: _config,
      ),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAiResponseInputItemsList.fromMap(response);
      },
    );
  }

  @override
  Future<int> getInputTokenCounts(
    dynamic conversation,
    dynamic input,
    String? instructions,
    String? model,
    bool? parallelToolCalls,
    String? previousResponseId,
    dynamic reasoning,
    dynamic text,
    dynamic toolChoice,
    List? tools,
    String? truncation,
  ) async {
    return OpenAINetworkingClient.post<int>(
        to: BaseApiUrlBuilder.buildFor(_config, endpoint, 'input_tokens'),
        body: {
          if (conversation != null) 'conversation': conversation,
          if (input != null) 'input': input,
          if (instructions != null) 'instructions': instructions,
          if (model != null) 'model': model,
          if (parallelToolCalls != null)
            'parallel_tool_calls': parallelToolCalls,
          if (previousResponseId != null)
            'previous_response_id': previousResponseId,
          if (reasoning != null) 'reasoning': reasoning,
          if (text != null) 'text': text,
          if (toolChoice != null) 'tool_choice': toolChoice,
          if (tools != null) 'tools': tools,
          if (truncation != null) 'truncation': truncation,
        },
        onSuccess: (Map<String, dynamic> response) {
          return int.parse(response['input_tokens']);
        },
        config: _config);
  }

  /// Creates a response and streams server-sent events back
  /// (`stream: true`). Each event is a decoded JSON map whose `type` field
  /// identifies it (e.g. `response.output_text.delta`,
  /// `response.completed`).
  ///
  /// ```dart
  /// await for (final event in client.responses.createStream(
  ///   model: 'gpt-4o',
  ///   input: 'Tell me a story',
  /// )) {
  ///   if (event['type'] == 'response.output_text.delta') {
  ///     stdout.write(event['delta']);
  ///   }
  /// }
  /// ```
  Stream<Map<String, dynamic>> createStream({
    required dynamic input,
    String? model,
    dynamic conversation,
    List? include,
    String? instructions,
    Map<String, dynamic>? metadata,
    bool? parallelToolCalls,
    String? previousResponseId,
    dynamic reasoning,
    bool? store,
    num? temperature,
    dynamic text,
    dynamic toolChoice,
    List? tools,
    num? topP,
    String? truncation,
    http.Client? client,
  }) {
    return OpenAINetworkingClient.postStream<Map<String, dynamic>>(
      to: BaseApiUrlBuilder.buildFor(_config, endpoint),
      body: {
        'stream': true,
        if (conversation != null) 'conversation': conversation,
        if (include != null) 'include': include,
        if (input != null) 'input': input,
        if (instructions != null) 'instructions': instructions,
        if (metadata != null) 'metadata': metadata,
        if (model != null) 'model': model,
        if (parallelToolCalls != null) 'parallel_tool_calls': parallelToolCalls,
        if (previousResponseId != null)
          'previous_response_id': previousResponseId,
        if (reasoning != null) 'reasoning': reasoning,
        if (store != null) 'store': store,
        if (temperature != null) 'temperature': temperature,
        if (text != null) 'text': text,
        if (toolChoice != null) 'tool_choice': toolChoice,
        if (tools != null) 'tools': tools,
        if (topP != null) 'top_p': topP,
        if (truncation != null) 'truncation': truncation,
      },
      onSuccess: (event) => event,
      client: client,
      config: _config,
    );
  }

  /// Compacts a stored response into a smaller representation.
  Future<Map<String, dynamic>> compact({
    required String responseId,
  }) async {
    return OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, endpoint, 'compact'),
      body: {'response_id': responseId},
      onSuccess: (response) => response,
      config: _config,
    );
  }
}
