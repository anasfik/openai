import 'package:meta/meta.dart';
import 'package:dart_openai/src/core/utils/logger.dart';

/// {@template headers_builder}
/// This class is responsible for building the headers for all the requests.
/// {@endtemplate}
@immutable
@internal
abstract class HeadersBuilder {
  /// {@template headers_builder_api_key}
  /// This is used to store the API key if it is set.
  /// {@endtemplate}
  static String? _apiKey;

  /// {@template headers_builder_organization}
  /// This is used to store the organization id if it is set.
  /// {@endtemplate}
  static String? _organization;

  /// This represents additional hezders to be added in all requests made by the package/
  static Map<String, dynamic> _additionalHeadersToRequests = {};

  /// {@macro headers_builder_organization}
  @internal
  static String? get organization => _organization;

  /// This is used to check if the organization id is set or not.
  static bool get isOrganizationSet => organization != null;

  /// {@macro headers_builder_api_key}
  @internal
  static String? get apiKey => _apiKey;

  @internal
  static set organization(String? organizationId) {
    _organization = organizationId;
    OpenAILogger.logOrganization(_organization);
  }

  @internal
  static set apiKey(String? apiKey) {
    _apiKey = apiKey;
    OpenAILogger.logAPIKey(_apiKey);
  }

  /// {@macro headers_builder}
  ///
  /// it will return a [Map<String, String>].
  ///
  /// if the [organization] is set, it will be added to the headers as well.
  /// If in anyhow the API key is not set, it will throw an [AssertionError] while debugging.
  @internal
  static Map<String, String> build() {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
    };

    assert(
      apiKey != null,
      """
      You must set the API key before making building any headers for a request.""",
    );
    headers = {
      ...headers,
      ..._additionalHeadersToRequests,
      if (isOrganizationSet) 'OpenAI-Organization': organization!,
      "Authorization": "Bearer $apiKey",
    };

    return headers;
  }

  /// Will save the given [headers] to the [_additionalHeadersToRequests] map. so it will be used in all requests.
  @internal
  static void includeHeaders(Map<String, dynamic> headers) {
    _additionalHeadersToRequests = {
      ..._additionalHeadersToRequests,
      ...headers,
    };

    OpenAILogger.logIncludedHeaders(_additionalHeadersToRequests);
  }
}
