import 'dart:developer' as dev;

import 'package:meta/meta.dart';

import '../constants/strings.dart';

@protected
@immutable
@internal
abstract final class OpenAILogger {
  /// This represents the default value of the logger active state.
  static bool _isActive = true;

  /// Changes the logger active state.
  ///
  /// if true, the logger will log messages.
  /// If false, the logger will not log messages.
  ///
  /// The default value is [_isActive].
  static set isActive(bool newValue) {
    _isActive = newValue;
  }

  /// Logs a message, if the logger is active.
  static void log(String message, [Object? error]) {
    if (_isActive) {
      dev.log(message, name: OpenAIStrings.openai, error: error);
    }
  }

  /// Logs that a request to an [endpoint] is being made, if the logger is active.
  static void logEndpoint(String endpoint) {
    log("accessing endpoint: $endpoint");
  }

  /// Logs that an api key is being set, if the logger is active.
  static void logAPIKey([String? apiKey]) {
    if (apiKey != null) {
      final hiddenApiKey = apiKey.replaceRange(0, apiKey.length - 10, '****');
      log("api key set to $hiddenApiKey");
    } else {
      log("api key is set");
    }
  }

  /// Logs that an baseUrl key is being set, if the logger is active.
  static void logBaseUrl([String? baseUrl]) {
    if (baseUrl != null) {
      log("base url set to $baseUrl");
    } else {
      log("base url is set");
    }
  }

  /// Logs that an organization id is being set, if the logger is active.
  static void logOrganization(String? organizationId) {
    log("organization id set to $organizationId");
  }

  static void logStartRequest(String from) {
    return log("starting request to $from");
  }

  static void requestToWithStatusCode(String url, int statusCode) {
    return log("request to $url finished with status code ${statusCode}");
  }

  static void startingDecoding() {
    return log("starting decoding response body");
  }

  static void decodedSuccessfully() {
    return log("response body decoded successfully");
  }

  static void errorOcurred([Object? error]) {
    return log("an error occurred, throwing exception: $error");
  }

  static void requestFinishedSuccessfully() {
    return log("request finished successfully");
  }

  static void streamResponseDone() {
    return log("stream response is done");
  }

  static void startReadStreamResponse() {
    return log("Starting to reading stream response");
  }

  static void logIncludedHeaders(
    Map<String, dynamic> additionalHeadersToRequests,
  ) {
    for (int index = 0;
        index < additionalHeadersToRequests.entries.length;
        index++) {
      final entry = additionalHeadersToRequests.entries.elementAt(index);
      log("header ${entry.key}:${entry.value} will be added to all requets");
    }
  }
}
