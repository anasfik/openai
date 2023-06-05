import 'package:meta/meta.dart';

/// {@template request_failure}
/// This exception is thrown when a request fails, from the API.
/// {@endtemplate}
@immutable
class RequestFailedException implements Exception {
  /// The error message of the request that failed, if any.
  final String message;

  /// The status code of the request that failed, if any.
  final int statusCode;

  /// {@macro request_failure}
  RequestFailedException(this.message, this.statusCode);

  @override
  String toString() {
    return 'RequestFailedException{message: $message, statusCode: $statusCode}';
  }
}

/// This exception is thrown when OpenAI returns 429 Rate Limited, due to too-many-requests
class RateLimitedException extends RequestFailedException {
  /// Length of time before the API key becomes unlocked for further calls
  final Duration timedOutDuration;

  /// Timestamp of when the API key will become unlocked for further calls
  final DateTime timedOutUntil;

  RateLimitedException(super.message, super.statusCode, this.timedOutDuration, this.timedOutUntil);
}

/// This exception is thrown when OpenAI returns 429 Rate Limited, due to no more credits
class OutOfCreditsException extends RequestFailedException {
  OutOfCreditsException(super.message, super.statusCode);
}
