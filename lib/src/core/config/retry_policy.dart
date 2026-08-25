/// Bounded automatic retry policy for transient failures.
///
/// Applied to every request made through an [OpenAIClient] (and the legacy
/// global facade). Defaults: 2 total attempts with exponential backoff.
///
/// What gets retried:
/// - All GET/DELETE requests.
/// - POST requests only when the failure looks transient: HTTP 408/429/5xx,
///   or the connection failed before a response arrived.
/// - The server's `Retry-After` header wins over computed backoff when set.
class OpenAIRetryPolicy {
  /// Total attempts per request. `1` disables retries.
  final int maxAttempts;

  /// Delay before the second attempt. Doubles per subsequent attempt.
  final Duration initialBackoff;

  /// Adds 0–100% random jitter to each delay to avoid thundering herds.
  final bool jitter;

  const OpenAIRetryPolicy({
    this.maxAttempts = 2,
    this.initialBackoff = const Duration(milliseconds: 500),
    this.jitter = true,
  }) : assert(maxAttempts >= 1);

  /// No retries; every failure surfaces immediately.
  static const OpenAIRetryPolicy none = OpenAIRetryPolicy(maxAttempts: 1);

  /// Whether [method] may be retried for the given outcome.
  bool shouldRetry({
    required String method,
    int? statusCode,
    required bool responseReceived,
    required int attempt,
  }) {
    if (attempt >= maxAttempts) return false;
    if (!responseReceived) return true;
    if (!_retriableStatuses.contains(statusCode)) return false;
    if (_unretriableVerbs.contains(method.toUpperCase())) return false;
    return true;
  }

  /// Delay before the next attempt, honoring `retryAfterSeconds`.
  Duration delayFor(int attempt, {int? retryAfterSeconds}) {
    if (retryAfterSeconds != null && retryAfterSeconds > 0) {
      return Duration(seconds: retryAfterSeconds);
    }
    var ms = initialBackoff.inMilliseconds * (1 << (attempt - 1));
    if (jitter) ms = (ms * (0.5 + DateTime.now().microsecond % 1000 / 2000)).round();
    return Duration(milliseconds: ms);
  }

  static const Set<int> _retriableStatuses = {408, 429, 500, 502, 503, 504};
  static const Set<String> _unretriableVerbs = {'POST', 'PUT', 'PATCH'};
}

/// Parsed `x-ratelimit-*` response headers.
class OpenAIRateLimitInfo {
  final int? limitRequests;
  final int? remainingRequests;
  final int? limitTokens;
  final int? remainingTokens;
  final DateTime? resetRequests;

  const OpenAIRateLimitInfo({
    this.limitRequests,
    this.remainingRequests,
    this.limitTokens,
    this.remainingTokens,
    this.resetRequests,
  });

  factory OpenAIRateLimitInfo.fromHeaders(Map<String, String> headers) {
    String? h(String k) => headers[k] ?? headers[k.toLowerCase()];
    int? parse(String? v) => v == null ? null : int.tryParse(v);
    final resetSecs = parse(h('x-ratelimit-reset-requests'));
    return OpenAIRateLimitInfo(
      limitRequests: parse(h('x-ratelimit-limit-requests')),
      remainingRequests: parse(h('x-ratelimit-remaining-requests')),
      limitTokens: parse(h('x-ratelimit-limit-tokens')),
      remainingTokens: parse(h('x-ratelimit-remaining-tokens')),
      resetRequests:
          resetSecs == null ? null : DateTime.now().add(Duration(seconds: resetSecs)),
    );
  }
}

/// Last response metadata (rate limits) recorded by the networking layer,
/// updated after every request. Simple per-isolate snapshot for apps that
/// want to observe quota without threading metadata through every call.
class OpenAIResponseMeta {
  static OpenAIRateLimitInfo? lastRateLimit;

  static void record(Map<String, String> headers) {
    lastRateLimit = OpenAIRateLimitInfo.fromHeaders(headers);
  }
}
