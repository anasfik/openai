import 'package:meta/meta.dart';

import '../constants/config.dart';

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
  @internal
  static String build(String endpoint, [String? id, String? query]) {
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

  // This is used to handle the endpoints that don't start with a slash.
  static String _handleEndpointsStarting(String endpoint) {
    return endpoint.startsWith("/") ? endpoint : "/$endpoint";
  }
}
