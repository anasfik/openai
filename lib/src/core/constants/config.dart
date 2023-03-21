import 'package:dart_openai/src/core/utils/logger.dart';
import 'package:meta/meta.dart';

@immutable
@internal
abstract class OpenAIConfig {
  static String? _baseUrl;

  @internal
  static String get baseUrl {
    if (_baseUrl == null) {
      return "https://api.openai.com";
    }

    return _baseUrl!;
  }

  @internal
  static set baseUrl(String? baseUrl) {
    _baseUrl = baseUrl;
    OpenAILogger.logBaseUrl();
  }

  static String get version => "v1";
}
