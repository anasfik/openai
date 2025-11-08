class OpenAIFileExpiresAfter {
  final String anchor;
  final int seconds;

  OpenAIFileExpiresAfter({
    required this.anchor,
    required this.seconds,
  });

  Map<String, dynamic> toMap() {
    return {
      "anchor": anchor,
      "seconds": seconds,
    };
  }
}
