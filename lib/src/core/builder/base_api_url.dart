import 'package:dart_openai/src/core/utils/logger.dart';
import 'package:meta/meta.dart';

import '../constants/config.dart';
import 'headers.dart';

/// This class is responsible for  building the API url for all the requests endpoints
@immutable
@internal
abstract class BaseApiUrlBuilder {
  /// This is used to build the API url for all the requests, it will return a [String].
  ///
  ///
  /// [endpoint] is the endpoint of the request.
  /// if an [id] is pr =ovided, it will be added to the url as well.
  /// if a [query] is provided, it will be added to the url as well.
  /// if aitype == azure, if aitype == azure, the model is required.
  @internal
  static String build(
    String endpoint, [
    String? id,
    String? query,
    String? model,
  ]) {
    // OpenAILogger.log("model = ${model}, id=${id}, query=${query}");
    // final baseUrl = OpenAIConfig.baseUrl;
    // final version = OpenAIConfig.version;
    // final apiVersion = OpenAIConfig.azureApiVersion;

    // final usedEndpoint = _handleEndpointsStarting(endpoint);

    return OpenAIConfig.aiType == OpenAIType.openai
        ? _build(endpoint, id, query)
        : _buildAzureOpenAI(endpoint, model);

    // String apiLink = "$baseUrl";
    // apiLink += "/$version";
    // apiLink += "$usedEndpoint";

    // if (id != null) {
    //   apiLink += "/$id";
    // } else if (query != null) {
    //   apiLink += "?$query";
    // }

    // return apiLink;
  }

  static String _build(String endpoint, [String? id, String? query]) {
    final baseUrl = OpenAIConfig.baseUrl;
    final version = OpenAIConfig.version;
    final usedEndpoint = _handleEndpointsStarting(endpoint);
    if (HeadersBuilder.isAzureOpenAI) {
      final baseUrl = AzureOpenAIConfig.buildUrlForResource(
        resourceEndpoint: endpoint,
      );

      return baseUrl;
    } else {
      final baseUrl = OpenAIConfig.baseUrl;
      final version = OpenAIConfig.version;
      final usedEndpoint = _handleEndpointsStarting(endpoint);

      String apiLink = "$baseUrl";
      apiLink += "/$version";
      apiLink += "$usedEndpoint";

      if (id != null) {
        apiLink += "/$id";
      } else if (query != null) {
        apiLink += "?$query";
      }

      return apiLink;
    }
  }

  static String _buildAzureOpenAI(
    String endpoint,
    String? model,
  ) {
    final baseUrl = OpenAIConfig.baseUrl;
    final apiVersion = OpenAIConfig.azureApiVersion;
    // final version = OpenAIConfig.version;
    final usedEndpoint = _handleEndpointsStarting(endpoint);
    String apiLink = "$baseUrl";
    // apiLink += "/$version";

    apiLink += "/openai/deployments";

    apiLink += "/$model";

    apiLink += "$usedEndpoint";

    apiLink += "?api-version=$apiVersion";

    return apiLink;
  }

  // This is used to handle the endpoints that don't start with a slash.
  static String _handleEndpointsStarting(String endpoint) {
    return endpoint.startsWith("/") ? endpoint : "/$endpoint";
  }
}
