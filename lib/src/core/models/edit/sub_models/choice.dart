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

  @override
  bool operator ==(covariant OpenAIEditModelChoice other) {
    if (identical(this, other)) return true;
  
    return 
      other.text == text &&
      other.index == index;
  }

  @override
  int get hashCode => text.hashCode ^ index.hashCode;

  @override
  String toString() => 'OpenAIEditModelChoice(text: $text, index: $index)';
}
