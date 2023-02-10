class MissingApiKeyException implements Exception {
  /// The message to be displayed when the exception is thrown.
  final String message;

  MissingApiKeyException(this.message);

  @override
  String toString() {
    return message;
  }
}
