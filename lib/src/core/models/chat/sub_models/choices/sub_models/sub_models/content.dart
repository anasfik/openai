class OpenAIChatCompletionChoiceMessageContentItemModel {
  final String type;
  final String? text;
  final String? imageUrl;

  OpenAIChatCompletionChoiceMessageContentItemModel({
    required this.type,
    this.text,
    this.imageUrl,
  });

  factory OpenAIChatCompletionChoiceMessageContentItemModel.fromMap(
    Map<String, dynamic> asMap,
  ) {
    return OpenAIChatCompletionChoiceMessageContentItemModel(
      type: asMap['type'],
      text: asMap['text'],
      imageUrl: asMap['image_url'],
    );
  }

  factory OpenAIChatCompletionChoiceMessageContentItemModel.text(String text) {
    return OpenAIChatCompletionChoiceMessageContentItemModel(
      type: 'text',
      text: text,
    );
  }

  factory OpenAIChatCompletionChoiceMessageContentItemModel.imageUrl(
    String imageUrl,
  ) {
    return OpenAIChatCompletionChoiceMessageContentItemModel(
      type: 'image',
      imageUrl: imageUrl,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "type": type,
      if (text != null) "text": text,
      if (imageUrl != null) "image_url": imageUrl,
    };
  }
}
