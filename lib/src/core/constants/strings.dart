import 'package:meta/meta.dart';

import 'endpoints.dart';

/// This class is responsible for storing general [String] constants.
@internal
@immutable
abstract class OpenAIStrings {
  /// This is the capitalized version of "openai" used in the SDK.
  static const openai = 'OpenAI';

  static const version = 'v1';
  static const defaultBaseUrl = 'https://api.openai.com';

  static const getMethod = 'GET';

  static const postMethod = 'POST';

  static const streamResponseStart = "data: ";

  static const streamResponseEnd = "[DONE]";

  static const errorFieldKey = 'error';

  static const messageFieldKey = 'message';

  static final endpoints = OpenAIApisEndpoints.instance;
}
