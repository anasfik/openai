class OpenAIVectorStoreExpiresAfter {
  final String anchor;
  final int days;

  OpenAIVectorStoreExpiresAfter({
    required this.anchor,
    required this.days,
  });

  factory OpenAIVectorStoreExpiresAfter.fromMap(Map<String, dynamic> map) {
    return OpenAIVectorStoreExpiresAfter(
      anchor: map['anchor'],
      days: map['days'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'anchor': anchor,
      'days': days,
    };
  }
}
