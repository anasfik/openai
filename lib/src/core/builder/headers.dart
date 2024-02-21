import 'package:dart_openai/src/core/constants/config.dart';
import 'package:meta/meta.dart';
import 'package:dart_openai/src/core/utils/logger.dart';

/// {@template headers_builder}
/// This class is responsible for building the headers for all the requests.
/// {@endtemplate}
@immutable
@internal
abstract class HeadersBuilder {
  /// This is used to check if the Azure API key is set or not.
  static bool isAzureOpenAI = false;

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
    if (isAzureOpenAI) {
      _apiKey = apiKey;
      OpenAILogger.logAzureAPIKey(_apiKey);
    } else {
      _apiKey = apiKey;
      OpenAILogger.logAPIKey(_apiKey);
    }
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

    final authorizationHeaders = <String, String>{};

    if (isAzureOpenAI) {
      assert(
        _apiKey != null,
        """
        You must set the Azure API key before making building any headers for a request.""",
      );

      authorizationHeaders["api-key"] = apiKey!;
    } else {
      assert(
        apiKey != null,
        """
      You must set the API key before making building any headers for a request.""",
      );
      authorizationHeaders["Authorization"] = "Bearer $apiKey";
    }

    headers = {
      ...headers,
      ..._additionalHeadersToRequests,
      if (isOrganizationSet) 'OpenAI-Organization': organization!,
      //"Authorization": "Bearer $apiKey",
      ...authorizationHeader(),
//       ...authorizationHeaders,

    };

    return headers;
  }

  @internal
  static Map<String, String> authorizationHeader() {
    if (OpenAIConfig.aiType == OpenAIType.azure) {
      return {"api-key": "$apiKey"};
    }

    return {"Authorization": "Bearer $apiKey"};
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
