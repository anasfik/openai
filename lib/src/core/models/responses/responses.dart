class OpenAiResponse {
  final bool background;
  final OpenAiResponseConversation? conversation;
  final DateTime createdAt;
  final OpenAiResponseError? error;
  final String id;
  final OpenAiResponseIncompleteDetails? incompleteDetails;
  // string or array
  final instructions;
  final int? maxOutputTokens;
  final int? maxToolCalls;
  final Map<String, dynamic>? metadata;
  final String model;
  final output;
  final bool parallelToolCalls;
  final String? previousResponseId;
  final prompt;
  final String? promptCacheKey;
  final OpenAiResponseReasoning? reasoning;
  final String? safetyIdentifier;
  final String? serviceTier;
  final OpenAiResponseStatus status;

  final num temperature;
  final OpenAiResponseText? text;
  final toolChoice;
  final List tools;
  final int? topLogprobs;
  final num? topP;
  final OpenAiResponseTruncation truncation;
  final bool store;
  final OpenAiResponseUsage? usage;

  OpenAiResponse({
    required this.id,
    required this.createdAt,
    required this.status,
    required this.error,
    required this.incompleteDetails,
    required this.instructions,
    required this.maxOutputTokens,
    required this.model,
    required this.output,
    required this.parallelToolCalls,
    required this.previousResponseId,
    required this.reasoning,
    required this.store,
    required this.temperature,
    required this.text,
    required this.toolChoice,
    required this.tools,
    required this.topP,
    required this.truncation,
    required this.usage,
    required this.metadata,
    required this.background,
    required this.conversation,
    required this.maxToolCalls,
    required this.prompt,
    required this.promptCacheKey,
    required this.safetyIdentifier,
    required this.serviceTier,
    required this.topLogprobs,
  });

  factory OpenAiResponse.fromMap(Map<String, dynamic> json) {
    return OpenAiResponse(
      id: json["id"],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json["created_at"] * 1000),
      status: OpenAiResponseStatus.values.firstWhere(
        (e) => e.name.toLowerCase() == json["status"].toLowerCase(),
        orElse: () => OpenAiResponseStatus.failed,
      ),
      error: json["error"] == null
          ? null
          : OpenAiResponseError.fromMap(json["error"]),
      incompleteDetails: json["incomplete_details"] == null
          ? null
          : OpenAiResponseIncompleteDetails.fromMap(json["incomplete_details"]),
      instructions: json["instructions"] == null ? null : json["instructions"],
      maxOutputTokens: json["max_output_tokens"],
      model: json["model"],
      output: json["output"],
      parallelToolCalls: json["parallel_tool_calls"],
      previousResponseId: json["previous_response_id"],
      reasoning: json["reasoning"] == null
          ? null
          : OpenAiResponseReasoning.fromMap(json["reasoning"]),
      store: json["store"],
      temperature: json["temperature"],
      text: json["text"] == null
          ? null
          : OpenAiResponseText.fromMap(json["text"]),
      toolChoice: json["tool_choice"],
      tools: List.from(json["tools"] ?? []),
      topP: json["top_p"],
      truncation: OpenAiResponseTruncation.values.firstWhere(
        (e) => e.name.toLowerCase() == json["truncation"].toLowerCase(),
        orElse: () => OpenAiResponseTruncation.disabled,
      ),
      usage: json["usage"] == null
          ? null
          : OpenAiResponseUsage.fromMap(json["usage"]),
      metadata: json["metadata"] != null
          ? Map<String, dynamic>.from(json["metadata"] ?? {})
          : null,
      background: json["background"] ?? false,
      conversation: json["conversation"] == null
          ? null
          : OpenAiResponseConversation.fromMap(json["conversation"]),
      maxToolCalls: json["max_tool_calls"],
      prompt: json["prompt"],
      promptCacheKey: json["prompt_cache_key"],
      safetyIdentifier: json["safety_identifier"],
      serviceTier: json["service_tier"],
      topLogprobs: json["top_logprobs"],
    );
  }
}

class OpenAiResponseUsage {
  final int? inputTokens;
  final OpenAiResponseUsageInputTokenDetails? inputTokensDetails;
  final int? outputTokens;
  final OpenAiResponseUsageOutputTokensDetails? outputTokensDetails;
  final int? totalTokens;

  OpenAiResponseUsage({
    required this.inputTokens,
    required this.inputTokensDetails,
    required this.outputTokens,
    required this.outputTokensDetails,
    required this.totalTokens,
  });

  OpenAiResponseUsage copyWith({
    int? inputTokens,
    OpenAiResponseUsageInputTokenDetails? inputTokensDetails,
    int? outputTokens,
    OpenAiResponseUsageOutputTokensDetails? outputTokensDetails,
    int? totalTokens,
  }) =>
      OpenAiResponseUsage(
        inputTokens: inputTokens ?? this.inputTokens,
        inputTokensDetails: inputTokensDetails ?? this.inputTokensDetails,
        outputTokens: outputTokens ?? this.outputTokens,
        outputTokensDetails: outputTokensDetails ?? this.outputTokensDetails,
        totalTokens: totalTokens ?? this.totalTokens,
      );

  factory OpenAiResponseUsage.fromMap(Map<String, dynamic> json) {
    return OpenAiResponseUsage(
      inputTokens: json["input_tokens"],
      inputTokensDetails: json["input_tokens_details"] == null
          ? null
          : OpenAiResponseUsageInputTokenDetails.fromMap(
              json["input_tokens_details"],
            ),
      outputTokens: json["output_tokens"],
      outputTokensDetails: json["output_tokens_details"] == null
          ? null
          : OpenAiResponseUsageOutputTokensDetails.fromMap(
              json["output_tokens_details"],
            ),
      totalTokens: json["total_tokens"],
    );
  }
}

class OpenAiResponseUsageInputTokenDetails {
  final int? cachedTokens;

  OpenAiResponseUsageInputTokenDetails({
    required this.cachedTokens,
  });

  OpenAiResponseUsageInputTokenDetails copyWith({
    int? cachedTokens,
  }) =>
      OpenAiResponseUsageInputTokenDetails(
        cachedTokens: cachedTokens ?? this.cachedTokens,
      );

  factory OpenAiResponseUsageInputTokenDetails.fromMap(
    Map<String, dynamic> json,
  ) =>
      OpenAiResponseUsageInputTokenDetails(
        cachedTokens: json["cached_tokens"],
      );
}

class OpenAiResponseUsageOutputTokensDetails {
  final int? reasoningTokens;

  OpenAiResponseUsageOutputTokensDetails({
    required this.reasoningTokens,
  });

  OpenAiResponseUsageOutputTokensDetails copyWith({
    int? reasoningTokens,
  }) =>
      OpenAiResponseUsageOutputTokensDetails(
        reasoningTokens: reasoningTokens ?? this.reasoningTokens,
      );

  factory OpenAiResponseUsageOutputTokensDetails.fromMap(
    Map<String, dynamic> json,
  ) =>
      OpenAiResponseUsageOutputTokensDetails(
        reasoningTokens: json["reasoning_tokens"],
      );
}

class OpenAiResponseText {
  final Map format;
  // variable enum values https://platform.openai.com/docs/api-reference/responses/object#responses/object-text-verbosity
  final String? verbosity;

  OpenAiResponseText({
    required this.format,
    required this.verbosity,
  });

  factory OpenAiResponseText.fromMap(Map<String, dynamic> json) =>
      OpenAiResponseText(
        format: json["format"] ?? {},
        verbosity: json["verbosity"],
      );

  OpenAiResponseText copyWith({
    Map<String, dynamic>? format,
    String? verbosity,
  }) =>
      OpenAiResponseText(
        format: format ?? this.format,
        verbosity: verbosity ?? this.verbosity,
      );
}

enum OpenAiResponseStatus {
  failed,
  inProgress,
  cancelled,
  queued,
  completed,
  incomplete;
}

class OpenAiResponseReasoning {
  final String? effort;
  final String? summary;

  OpenAiResponseReasoning({
    this.effort,
    this.summary,
  });

  OpenAiResponseReasoning copyWith({
    String? effort,
    String? summary,
  }) =>
      OpenAiResponseReasoning(
        effort: effort ?? this.effort,
        summary: summary ?? this.summary,
      );

  factory OpenAiResponseReasoning.fromMap(Map<String, dynamic> json) =>
      OpenAiResponseReasoning(
        effort: json["effort"],
        summary: json["summary"],
      );
}

class OpenAiResponseIncompleteDetails {
  final String? reason;

  OpenAiResponseIncompleteDetails({
    this.reason,
  });

  OpenAiResponseIncompleteDetails copyWith({
    String? reason,
  }) =>
      OpenAiResponseIncompleteDetails(
        reason: reason ?? this.reason,
      );

  factory OpenAiResponseIncompleteDetails.fromMap(Map<String, dynamic> json) =>
      OpenAiResponseIncompleteDetails(
        reason: json["reason"],
      );
}

class OpenAiResponseConversation {
  final String conversationId;

  OpenAiResponseConversation({
    required this.conversationId,
  });

  OpenAiResponseConversation copyWith({
    String? conversationId,
  }) =>
      OpenAiResponseConversation(
        conversationId: conversationId ?? this.conversationId,
      );

  factory OpenAiResponseConversation.fromMap(Map<String, dynamic> json) =>
      OpenAiResponseConversation(
        conversationId: json["id"],
      );
}

class OpenAiResponseError {
  final String? message;
  final String? code;

  OpenAiResponseError({
    this.message,
    this.code,
  });

  OpenAiResponseError copyWith({
    String? message,
    String? code,
  }) =>
      OpenAiResponseError(
        message: message ?? this.message,
        code: code ?? this.code,
      );

  factory OpenAiResponseError.fromMap(Map<String, dynamic> json) =>
      OpenAiResponseError(
        message: json["message"],
        code: json["code"],
      );
}

enum OpenAiResponseTruncation {
  auto,
  disabled,
}

class OpenAiResponseInputItemsList {
  final String object;
  final List data;
  final bool hasMore;
  final String? firstId;
  final String? lastId;

  OpenAiResponseInputItemsList({
    required this.object,
    required this.data,
    required this.hasMore,
    this.firstId,
    this.lastId,
  });

  factory OpenAiResponseInputItemsList.fromMap(Map<String, dynamic> json) {
    return OpenAiResponseInputItemsList(
      object: json["object"],
      data: json["data"],
      hasMore: json["has_more"] ?? false,
      firstId: json["first_id"],
      lastId: json["last_id"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "object": object,
      "data": data.map((item) => item.toMap()).toList(),
      "has_more": hasMore,
      "first_id": firstId,
      "last_id": lastId,
    };
  }
}
