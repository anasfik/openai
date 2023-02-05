class OpenAIStreamCompletionModelChoice {
  String text;
  int index;
  dynamic logprobs;
  dynamic finishReason;

  OpenAIStreamCompletionModelChoice({
    required this.text,
    required this.index,
    required this.logprobs,
    required this.finishReason,
  });

  factory OpenAIStreamCompletionModelChoice.fromJson(
      Map<String, dynamic> json) {
    return OpenAIStreamCompletionModelChoice(
      text: json['text'],
      index: json['index'],
      logprobs: json['logprobs'],
      finishReason: json['finishReason'],
    );
  }
}
