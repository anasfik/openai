import 'package:dart_openai/src/core/utils/logger.dart';
import 'package:meta/meta.dart';

/// {@template openai_config}
/// This class is responsible about general configs for the SDK such as the base url..
/// {@endtemplate}
@immutable
@internal
abstract class OpenAIConfig {
  /// {@template openai_config_base_url}
  /// This is base API url for all the requests.
  /// {@endtemplate}
  static String? _baseUrl;

  /// This is the version of the API.
  static String get version => "v1";

  /// {@macro openai_config_base_url}
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
}
