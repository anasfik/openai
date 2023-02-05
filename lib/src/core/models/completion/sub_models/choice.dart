class OpenAICompletionModelChoice {
  String text;
  int index;
  int? logprobs;
  String? finishReason;

  OpenAICompletionModelChoice({
    required this.text,
    required this.index,
    required this.logprobs,
    required this.finishReason,
  });

  factory OpenAICompletionModelChoice.fromJson(Map<String, dynamic> json) {
    return OpenAICompletionModelChoice(
      text: json['text'],
      index: json['index'],
      logprobs: json['logprobs'],
      finishReason: json['finishReason'],
    );
  }

  @override
  bool operator ==(covariant OpenAICompletionModelChoice other) {
    if (identical(this, other)) return true;

    return other.text == text &&
        other.index == index &&
        other.logprobs == logprobs &&
        other.finishReason == finishReason;
  }

  @override
  int get hashCode {
    return text.hashCode ^
        index.hashCode ^
        logprobs.hashCode ^
        finishReason.hashCode;
  }

  @override
  String toString() {
    return 'OpenAICompletionModelChoice(text: $text, index: $index, logprobs: $logprobs, finishReason: $finishReason)';
  }
}
