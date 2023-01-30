class MissingApiKeyException implements Exception {
  final String message;

  MissingApiKeyException(this.message);

  @override
  String toString() {
    return message;
  }
}
