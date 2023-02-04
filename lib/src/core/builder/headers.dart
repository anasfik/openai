import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:dart_openai/src/core/utils/logger.dart';

@immutable
class HeadersBuilder {
  static String? _organization;
  static String? get organization => _organization;
  static set organization(String? organizationId) {
    OpenAILogger.log("setting organization id");
    _organization = organizationId;
  }

  static String? _apiKey;
  static String? get apiKey => _apiKey;
  static set apiKey(String? apiKey) {
    OpenAILogger.log("setting API key");
    _apiKey = apiKey;
  }

  static Map<String, String> build() {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    assert(
      apiKey != null,
      """You must set the API key before making building any headers for a request.""",
    );

    if (organization != null) {
      headers['OpenAI-Organization'] = organization!;
    }

    headers["Authorization"] = "Bearer $apiKey";
    return headers;
  }
}
