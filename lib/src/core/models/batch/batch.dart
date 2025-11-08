class OpenAiBatchModel {
  final String id;
  final String object;
  final String endpoint;
  final String model;
  final Map<String, dynamic> errors;
  final String inputFileId;
  final String completionWindow;
  final String status;
  final String outputFileId;
  final String errorFileId;
  final int? createdAt;
  final int? inProgressAt;
  final int? expiresAt;
  final int? finalizingAt;
  final int? completedAt;
  final int? failedAt;
  final int? expiredAt;
  final int? cancellingAt;
  final int? cancelledAt;
  final RequestCounts requestCounts;
  final Usage usage;
  final Map<String, dynamic> metadata;

  OpenAiBatchModel({
    required this.id,
    required this.object,
    required this.endpoint,
    required this.model,
    required this.errors,
    required this.inputFileId,
    required this.completionWindow,
    required this.status,
    required this.outputFileId,
    required this.errorFileId,
    required this.createdAt,
    required this.inProgressAt,
    required this.expiresAt,
    required this.finalizingAt,
    required this.completedAt,
    required this.failedAt,
    required this.expiredAt,
    required this.cancellingAt,
    required this.cancelledAt,
    required this.requestCounts,
    required this.usage,
    required this.metadata,
  });

  OpenAiBatchModel copyWith({
    String? id,
    String? object,
    String? endpoint,
    String? model,
    errors,
    String? inputFileId,
    String? completionWindow,
    String? status,
    String? outputFileId,
    String? errorFileId,
    int? createdAt,
    int? inProgressAt,
    int? expiresAt,
    int? finalizingAt,
    int? completedAt,
    int? failedAt,
    int? expiredAt,
    int? cancellingAt,
    int? cancelledAt,
    RequestCounts? requestCounts,
    Usage? usage,
    Map<String, dynamic>? metadata,
  }) =>
      OpenAiBatchModel(
        id: id ?? this.id,
        object: object ?? this.object,
        endpoint: endpoint ?? this.endpoint,
        model: model ?? this.model,
        errors: errors ?? this.errors,
        inputFileId: inputFileId ?? this.inputFileId,
        completionWindow: completionWindow ?? this.completionWindow,
        status: status ?? this.status,
        outputFileId: outputFileId ?? this.outputFileId,
        errorFileId: errorFileId ?? this.errorFileId,
        createdAt: createdAt ?? this.createdAt,
        inProgressAt: inProgressAt ?? this.inProgressAt,
        expiresAt: expiresAt ?? this.expiresAt,
        finalizingAt: finalizingAt ?? this.finalizingAt,
        completedAt: completedAt ?? this.completedAt,
        failedAt: failedAt ?? this.failedAt,
        expiredAt: expiredAt ?? this.expiredAt,
        cancellingAt: cancellingAt ?? this.cancellingAt,
        cancelledAt: cancelledAt ?? this.cancelledAt,
        requestCounts: requestCounts ?? this.requestCounts,
        usage: usage ?? this.usage,
        metadata: metadata ?? this.metadata,
      );
}

class RequestCounts {
  final int total;
  final int completed;
  final int failed;

  RequestCounts({
    required this.total,
    required this.completed,
    required this.failed,
  });

  RequestCounts copyWith({
    int? total,
    int? completed,
    int? failed,
  }) =>
      RequestCounts(
        total: total ?? this.total,
        completed: completed ?? this.completed,
        failed: failed ?? this.failed,
      );
}

class Usage {
  final int inputTokens;
  final InputTokensDetails inputTokensDetails;
  final int outputTokens;
  final OutputTokensDetails outputTokensDetails;
  final int totalTokens;

  Usage({
    required this.inputTokens,
    required this.inputTokensDetails,
    required this.outputTokens,
    required this.outputTokensDetails,
    required this.totalTokens,
  });

  Usage copyWith({
    int? inputTokens,
    InputTokensDetails? inputTokensDetails,
    int? outputTokens,
    OutputTokensDetails? outputTokensDetails,
    int? totalTokens,
  }) =>
      Usage(
        inputTokens: inputTokens ?? this.inputTokens,
        inputTokensDetails: inputTokensDetails ?? this.inputTokensDetails,
        outputTokens: outputTokens ?? this.outputTokens,
        outputTokensDetails: outputTokensDetails ?? this.outputTokensDetails,
        totalTokens: totalTokens ?? this.totalTokens,
      );
}

class InputTokensDetails {
  final int cachedTokens;

  InputTokensDetails({
    required this.cachedTokens,
  });

  InputTokensDetails copyWith({
    int? cachedTokens,
  }) =>
      InputTokensDetails(
        cachedTokens: cachedTokens ?? this.cachedTokens,
      );
}

class OutputTokensDetails {
  final int reasoningTokens;

  OutputTokensDetails({
    required this.reasoningTokens,
  });

  OutputTokensDetails copyWith({
    int? reasoningTokens,
  }) =>
      OutputTokensDetails(
        reasoningTokens: reasoningTokens ?? this.reasoningTokens,
      );
}
