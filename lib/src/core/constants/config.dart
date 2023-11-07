import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/utils/extensions.dart';
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
  static String get version => OpenAIStrings.version;

  /// {@macro openai_config_base_url}
  @internal
  static String get baseUrl {
    return _baseUrl ?? OpenAIStrings.defaultBaseUrl;
  }

  @internal
  static set baseUrl(String? baseUrl) {
    _baseUrl = baseUrl;
    OpenAILogger.logBaseUrl(_baseUrl);
  }
}

abstract class AzureOpenAIConfig {
  static String? resourceName;
  static String? deploymentName;
  static DateTime? apiVersion;

  static String buildUrlForResource({
    required String resourceEndpoint,
  }) {
    assert(resourceName != null, "resourceName is null");
    assert(deploymentName != null, "deploymentName is null");
    assert(apiVersion != null, "apiVersion is null");

    final apiVersionAsString = apiVersion!.toAzureAPIVersionString();

    dynamic ensuredEndpoint = resourceEndpoint.split("");

    if (ensuredEndpoint.last == "/") {
      ensuredEndpoint.removeLast();
    }

    if (ensuredEndpoint.first == "/") {
      ensuredEndpoint.removeAt(0);
    }

    ensuredEndpoint = ensuredEndpoint.join("");

    return "https://${resourceName!}.openai.azure.com/openai/deployments/${deploymentName!}/${ensuredEndpoint}?api-version=${apiVersionAsString}";
  }
}
