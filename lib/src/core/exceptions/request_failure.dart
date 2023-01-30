class RequestFailedException implements Exception {
  final String message;
  final int statusCode;
  RequestFailedException(this.message, this.statusCode);

  @override
  String toString() {
    return 'RequestFailedException{message: $message, statusCode: $statusCode}';
  }
}
