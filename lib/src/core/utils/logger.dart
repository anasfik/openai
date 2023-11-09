import 'dart:developer' as dev;

import 'package:meta/meta.dart';

import '../constants/strings.dart';

@protected
@immutable
@internal
abstract final class OpenAILogger {
  /// This represents the default value of the logger active state.
  static bool _isActive = true;

  static bool get isActive => _isActive;

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
    if (apiKey != null && isValidApiKey(apiKey)) {
      final hiddenApiKey = apiKey.replaceRange(0, apiKey.length - 10, '****');
      log("api key set to $hiddenApiKey");
    } else {
      log("api key is set but not valid");
    }
  }

  /// simple check for api key validity
  static isValidApiKey(String key) {
    return key.isNotEmpty &&
        key.startsWith("sk-") &&
        key.length > 10; //magic number
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

  static void startingTryCheckingForError() {
    return log("starting to check for error in the response.");
  }

  static void errorFoundInRequest() {
    return log("error found in request, throwing exception");
  }

  static void unexpectedResponseGotten() {
    return log(
      "unexpected response gotten, this means that a change is made to the api, please open an issue on github",
    );
  }

  static void noErrorFound() {
    return log("Good, no error found in response.");
  }

  static void creatingFile(String fileName) {
    return log("creating output file: $fileName");
  }

  static void fileCreatedSuccessfully(String fileName) {
    return log("file $fileName created successfully");
  }

  static void writingFileContent(String fileName) {
    return log("writing content to file $fileName");
  }

  static void fileContentWrittenSuccessfully(String fileName) {
    return log("content written to file $fileName successfully");
  }

  static void requestsTimeoutChanged(Duration requestsTimeOut) {
    return log("requests timeout changed to $requestsTimeOut");
  }
}
