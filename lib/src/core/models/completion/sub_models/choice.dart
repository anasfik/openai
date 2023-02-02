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
      finishReason: json['finish_reason'],
    );
  }
}
