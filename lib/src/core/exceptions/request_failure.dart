import 'package:meta/meta.dart';

@immutable
class RequestFailedException implements Exception {
  /// returns the error message of the request that failed, if any.
  final String message;

  /// returns the status code of the request that failed, if any.
  final int statusCode;

  /// This is thrown when a request fails.
  RequestFailedException(this.message, this.statusCode);

  @override
  String toString() {
    return 'RequestFailedException{message: $message, statusCode: $statusCode}';
  }
}
