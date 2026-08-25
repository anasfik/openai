import 'azure.dart';
import 'retry_policy.dart';

/// Per-client configuration.
///
/// A [OpenAIClientConfig] is owned by an [OpenAIClient] instance. The legacy
/// static facade (`OpenAI.apiKey = ...`) keeps working by falling back to a
/// config built from the global statics when no explicit config is provided.
class OpenAIClientConfig {
  /// API key used for authentication.
  final String? apiKey;

  /// Organization id sent as `OpenAI-Organization` when set.
  final String? organization;

  /// Base url, defaults to `https://api.openai.com`.
  final String baseUrl;

  /// API version path segment, defaults to `v1`.
  final String version;

  /// Maximum duration of a single request.
  final Duration requestsTimeOut;

  /// Extra headers merged into every request.
  final Map<String, dynamic> extraHeaders;

  /// Retry behavior for transient failures. Defaults to 2 total attempts.
  final OpenAIRetryPolicy retryPolicy;

  /// Azure OpenAI settings. When set, requests are rewritten to Azure's
  /// deployment-based URLs with the api-version parameter.
  final OpenAIAzure? azure;

  const OpenAIClientConfig({
    this.apiKey,
    this.organization,
    this.baseUrl = 'https://api.openai.com',
    this.version = 'v1',
    this.requestsTimeOut = const Duration(seconds: 30),
    this.extraHeaders = const {},
    this.retryPolicy = const OpenAIRetryPolicy(),
    this.azure,
  });

  /// Builds a config snapshot from the global statics used by the legacy
  /// [OpenAI] facade. Used whenever a module has no explicit config.
  factory OpenAIClientConfig.fromGlobals({
    required String? apiKey,
    required String? organization,
    required String baseUrl,
    required String version,
    required Duration requestsTimeOut,
    required Map<String, dynamic> extraHeaders,
  }) {
    return OpenAIClientConfig(
      apiKey: apiKey,
      organization: organization,
      baseUrl: baseUrl,
      version: version,
      requestsTimeOut: requestsTimeOut,
      extraHeaders: extraHeaders,
    );
  }

  /// Headers for a request. Compatible providers that don't use Bearer auth
  /// can override via [extraHeaders].
  Map<String, String> buildHeaders() {
    return <String, String>{
      'Content-Type': 'application/json',
      ...extraHeaders.map((k, v) => MapEntry(k, v.toString())),
      if (organization != null) 'OpenAI-Organization': organization!,
      if (apiKey != null && !extraHeaders.containsKey('Authorization'))
        'Authorization': 'Bearer $apiKey',
    };
  }
}
