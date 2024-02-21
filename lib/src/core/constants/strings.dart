import 'package:meta/meta.dart';

import 'endpoints.dart';

/// {@template openai_strings}
/// This class is responsible for storing general [String] constants.
/// {@endtemplate}
@internal
@immutable
abstract class OpenAIStrings {
  /// This is the capitalized version of "openai" name used in the SDK, like the logger name.
  static const openai = 'OpenAI';

  /// This is the version of the API, in case it changes, it will be updated here.
  static const version = 'v1';

  /// This is the default base url for all the requests.
  static const defaultBaseUrl = 'https://api.openai.com';

  /// The verb name for the [GET] method.
  static const getMethod = 'GET';

  /// The verb name for the [POST] method.
  static const postMethod = 'POST';

  /// The identifier and initial value to exclude for stream responses (SSE).
  static const streamResponseStart = "data: ";

  /// The identifier and final value to exclude for stream responses (SSE).
  static const streamResponseEnd = "[DONE]";

  /// The name of the error field a failed response will have.
  static const errorFieldKey = 'error';

  /// The name of the message field a failed response will have.
  static const messageFieldKey = 'message';

  /// {@macro openai_endpoints}
  static final endpoints = OpenAIApisEndpoints.instance;
}
