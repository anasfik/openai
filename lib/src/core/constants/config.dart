import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/utils/extensions.dart';
import 'package:dart_openai/src/core/utils/logger.dart';
import 'package:meta/meta.dart';

enum OpenAIType { openai, azure }

/// {@template openai_config}
/// This class is responsible about general configs for the SDK such as the base url..
/// {@endtemplate}
@immutable
@internal
abstract class OpenAIConfig {
  /// Define the types of OpenAI services, which can be used in two types: OpenAI and Azure OpenAI.
  static OpenAIType aiType = OpenAIType.openai;

  /// Define azure openai api version and set default version.
  static String azureApiVersion = "2023-05-15";

  /// {@template openai_config_default_requests_timeOut}
  /// The default maximum duration a request can take, this will be applied to all requests, defaults to 30 seconds.
  /// {@endtemplate}
  static final defaultRequestsTimeOut = Duration(seconds: 30);

  /// {@template openai_config_requests_timeOut}
  /// The maximum duration a request can take, this will be applied to all requests, defaults to 30 seconds.
  /// if you need custom timeout for each method individulaly, consider using the `client` field in each method and pass a custom HTTP client to it.
  /// {@endtemplate}
  static Duration requestsTimeOut = defaultRequestsTimeOut;

  /// {@template openai_config_base_url}
  /// This is base API url for all the requests.
  /// {@endtemplate}
  static String? _baseUrl;

  /// {@template openai_config_version}
  /// This is the version of the API.
  /// {@endtemplate}
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
