// ignore_for_file: public_member_api_docs, sort_constructors_first
/// {@template openai_chat_completion_choice_message_content_item_model}
/// This represents the content item of the [OpenAIChatCompletionChoiceMessageModel] model of the OpenAI API, which is used in the [OpenAIChat] methods.
/// {@endtemplate}
class OpenAIChatCompletionChoiceMessageContentItemModel {
  /// The type of the content item.
  final String type;

  /// The text content of the item.
  final String? text;

  /// The image url content of the item.
  final String? imageUrl;

  @override
  int get hashCode => type.hashCode ^ text.hashCode ^ imageUrl.hashCode;

  /// {@macro openai_chat_completion_choice_message_content_item_model}
  OpenAIChatCompletionChoiceMessageContentItemModel._({
    required this.type,
    this.text,
    this.imageUrl,
  });

  /// This is used to convert a [Map<String, dynamic>] object to a [OpenAIChatCompletionChoiceMessageContentItemModel] object.
  factory OpenAIChatCompletionChoiceMessageContentItemModel.fromMap(
    Map<String, dynamic> asMap,
  ) {
    return OpenAIChatCompletionChoiceMessageContentItemModel._(
      type: asMap['type'],
      text: asMap['text'],
      imageUrl: asMap['image_url'],
    );
  }

  /// Represents a text content item factory, which is used to create a text [OpenAIChatCompletionChoiceMessageContentItemModel].
  factory OpenAIChatCompletionChoiceMessageContentItemModel.text(String text) {
    return OpenAIChatCompletionChoiceMessageContentItemModel._(
      type: 'text',
      text: text,
    );
  }

  /// Represents a image content item factory, which is used to create a image [OpenAIChatCompletionChoiceMessageContentItemModel].
  factory OpenAIChatCompletionChoiceMessageContentItemModel.imageUrl(
    String imageUrl,
  ) {
    return OpenAIChatCompletionChoiceMessageContentItemModel._(
      type: 'image_url',
      imageUrl: imageUrl,
    );
  }

  /// This method used to convert the [OpenAIChatCompletionChoiceMessageContentItemModel] to a [Map<String, dynamic>] object.
  Map<String, dynamic> toMap() {
    return {
      "type": type,
      if (text != null) "text": text,
      if (imageUrl != null) "image_url": imageUrl,
    };
  }

  @override
  bool operator ==(
    covariant OpenAIChatCompletionChoiceMessageContentItemModel other,
  ) {
    if (identical(this, other)) return true;

    return other.type == type &&
        other.text == text &&
        other.imageUrl == imageUrl;
  }

  //! TODO: make a dynamic toString method for different types of content items.
  @override
  String toString() {
    return 'OpenAIChatCompletionChoiceMessageContentItemModel(type: $type, text: $text, imageUrl: $imageUrl)';
  }
}
