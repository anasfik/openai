import '../constants/config.dart';

abstract class BaseApiUrlBuilder {
  static final String _baseUrl = OpenAIConfig.baseUrl;
  static final String _version = OpenAIConfig.version;

  static String build(String endpoint) {
    return "$_baseUrl/$_version$endpoint";
  }
}
