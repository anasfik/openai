import 'dart:developer' as dev;

import '../constants/strings.dart';

abstract class OpenAILogger {
  static bool _isActive = false;

  static set isActive(bool newValue) {
    _isActive = newValue;
  }

  static void log(String message) {
    if (!_isActive) {
      return;
    }

    dev.log(
      message,
      name: OpenAIStrings.openai,
    );
  }

  static void logEndpoint(String endpoint) {
    log("accessing endpoint: $endpoint");
  }
}
