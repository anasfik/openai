class OpenAIContainerExpiresAfter {
  final String anchor;
  final int minutes;

  OpenAIContainerExpiresAfter({
    required this.anchor,
    required this.minutes,
  });

  factory OpenAIContainerExpiresAfter.fromMap(Map<String, dynamic> map) {
    return OpenAIContainerExpiresAfter(
      anchor: map['anchor'],
      minutes: map['minutes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'anchor': anchor,
      'minutes': minutes,
    };
  }
}
