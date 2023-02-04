class OpenAIStreamCompletionModelChoice {
  String text;
  int index;
  dynamic logprobs;
  dynamic finish_reason;

  OpenAIStreamCompletionModelChoice({
    required this.text,
    required this.index,
    required this.logprobs,
    required this.finish_reason,
  });

  factory OpenAIStreamCompletionModelChoice.fromJson(
      Map<String, dynamic> json) {
    return OpenAIStreamCompletionModelChoice(
      text: json['text'],
      index: json['index'],
      logprobs: json['logprobs'],
      finish_reason: json['finish_reason'],
    );
  }
}
