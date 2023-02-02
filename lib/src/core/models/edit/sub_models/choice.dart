class OpenAIEditModelChoice {
  final String text;
  final int index;

  OpenAIEditModelChoice({
    required this.text,
    required this.index,
  });

  factory OpenAIEditModelChoice.fromJson(Map<String, dynamic> json) {
    return OpenAIEditModelChoice(
      text: json['text'],
      index: json['index'],
    );
  }
}
