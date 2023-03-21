import 'package:meta/meta.dart';

import '../constants/config.dart';

@immutable
@internal
abstract class BaseApiUrlBuilder {
  /// This is used to build the API url for all the requests, it will return a [String].
  /// if an [id] is provided, it will be added to the url as well.
  @internal
  static String build(String endpoint, [String? id, String? query]) {
    String apiLink = "${OpenAIConfig.baseUrl}/${OpenAIConfig.version}$endpoint";
    if (id != null) {
      apiLink += "/$id";
    }
    if (query != null) {
      apiLink += "?$query";
    }

    return apiLink;
  }
}
