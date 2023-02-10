import 'package:meta/meta.dart';
import 'package:dart_openai/src/core/utils/logger.dart';

@immutable
@internal
abstract class HeadersBuilder {
  // This is used to store the organization id.
  static String? _organization;

  // This is the public getter for the organization id, it will return null if the organization id is not set.
  static String? get organization => _organization;
  @internal
  static set organization(String? organizationId) {
    _organization = organizationId;
    OpenAILogger.logOrganization(_organization);
  }

  // This is used to store the API key.
  static String? _apiKey;

  // This is the public getter for the API key, it will return null if the API key is not set.
  @internal
  static String? get apiKey => _apiKey;

  @internal
  static set apiKey(String? apiKey) {
    _apiKey = apiKey;
    OpenAILogger.logAPIKey();
  }

  /// This is used to build the headers for all the requests, it will return a [Map<String, String>].
  /// if an organization id is set, it will be added to the headers as well.
  /// If in anyhow the API key is not set, it will throw an [AssertionError].
  @internal
  static Map<String, String> build() {
    final Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
    };

    assert(
      apiKey != null,
      """You must set the API key before making building any headers for a request.""",
    );

    if (isOrganizationSet) {
      headers['OpenAI-Organization'] = organization!;
    }

    headers["Authorization"] = "Bearer $apiKey";

    return headers;
  }

  /// This is used to check if the organization id is set or not.
  @internal
  static bool get isOrganizationSet => organization != null;
}
