/// {@template api_key_not_set_exception}
/// This exception is thrown when the API key is not set and the user tries to make a request.
/// {@endtemplate}
class MissingApiKeyException implements Exception {
  /// The message to be displayed when the exception is thrown.
  final String message;

  /// {@macro api_key_not_set_exception}
  MissingApiKeyException(this.message);

  @override
  String toString() {
    return message;
  }
}
