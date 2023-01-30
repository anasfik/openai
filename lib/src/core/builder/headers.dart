import 'package:http/http.dart';
import 'package:meta/meta.dart';

@immutable
class HeadersBuilder {
  static String? _organization;
  static String? get organization => _organization;
  static set organization(String? organizationId) {
    _organization = organizationId;
  }

  static String? _apiKey;
  static String? get apiKey => _apiKey;
  static set apiKey(String? organizationId) {
    _organization = organizationId;
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
