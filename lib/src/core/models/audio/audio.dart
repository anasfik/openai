class OpenAIAudioModel {
  // lass from json
//   {
//   "text": "Imagine the wildest idea that you've ever had, and you're curious about how it might scale to something that's a 100, a 1,000 times bigger. This is a place where you can get to do that."
// }

  final String text;

  @override
  int get hashCode => text.hashCode;

  OpenAIAudioModel({
    required this.text,
  });
  factory OpenAIAudioModel.fromJson(Map<String, dynamic> json) {
    return OpenAIAudioModel(
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
    };
  }

  @override
  String toString() {
    return 'OpenAIAudioModel(text: $text)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OpenAIAudioModel && other.text == text;
  }
}
