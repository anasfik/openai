import 'dart:developer' as dev;

import 'package:http/http.dart';
import 'package:meta/meta.dart';

import '../constants/strings.dart';

@protected
@immutable
@internal
abstract final class OpenAILogger {
  /// The valid min length of an api key.
  static const int _kValidApiKeyLength = 10;

  /// {@template openai_logger_is_active}
  /// Wether the to show operations flow logger is active or not.
  /// {@endtemplate}
  static bool _isActive = true;

  /// {@template openai_logger_show_responses_logs}
  /// Wether to show operations response bodies in logs or not.
  /// {@endtemplate}
  static bool _showResponsesLogs = false;

  /// {@macro openai_logger_is_active}
  static bool get isActive => _isActive;

  /// {@macro openai_logger_show_responses_logs}
  static bool get showResponsesLogs => _showResponsesLogs;

  /// Changes the logger active state.
  ///
  /// if true, the logger will log messages.
  /// If false, the logger will not log messages.
  ///
  /// The default value is [true].
  static set isActive(bool newValue) {
    _isActive = newValue;
  }

  /// Changes the logger show responses logs state.
  ///
  /// if true, the logger will log responses bodies.
  /// If false, the logger will not log responses bodies.
  ///
  /// The default value is [false].
  static set showResponsesLogs(bool newValue) {
    _showResponsesLogs = newValue;
  }

  /// Logs a message, if the logger is active.
  static void log(String message, [Object? error]) {
    if (_isActive) {
      dev.log(message, name: OpenAIStrings.openai, error: error);
    }
  }

  /// Logs the response of a request, if the logger is active.
  static void logResponseBody(response) {
    if (_isActive && _showResponsesLogs) {
      if (response is Response) {
        dev.log(response.body.toString(), name: OpenAIStrings.openai);
      } else {
        dev.log(
          response.toString(),
          name: OpenAIStrings.openai,
        );
      }
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
        key.length > _kValidApiKeyLength;
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

  static void logIsWeb(bool isWeb) {
    return log("isWeb set to $isWeb");
  }
}
