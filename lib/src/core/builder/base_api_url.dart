import '../constants/config.dart';

abstract class BaseApiUrlBuilder {
  static final String _baseUrl = OpenAIConfig.baseUrl;
  static final String _version = OpenAIConfig.version;

  static String build(String endpoint, [String? id]) {
    String apiLink = "$_baseUrl/$_version$endpoint";
    if (id != null) {
      apiLink += "/$id";
    }
    return apiLink;
  }
}
