import 'dart:developer' as dev;

import 'package:meta/meta.dart';

import '../constants/strings.dart';

@protected
@immutable
@internal
abstract class OpenAILogger {
  static bool _isActive = true;

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
