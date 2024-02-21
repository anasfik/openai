import 'package:meta/meta.dart';

/// {@template openai_image_data_model}
/// This class is used to represent an OpenAI image data.
/// {@endtemplate}
@immutable
final class OpenAIImageData {
  /// The [URL] of the image.
  final String? url;

  /// The  [b64Json] data.
  final String? b64Json;

  /// The revised prompt.
  final String? revisedPrompt;

  /// Weither the image have a [URL] result.
  bool get haveUrl => url != null;

  /// Weither the image have a [b64Json] result.
  bool get haveB64Json => b64Json != null;

  /// Weither the image have a revised prompt.
  bool get haveRevisedPrompt => revisedPrompt != null;

  @override
  int get hashCode => url.hashCode ^ b64Json.hashCode ^ revisedPrompt.hashCode;

  /// This class is used to represent an OpenAI image data.
  const OpenAIImageData({
    required this.url,
    required this.b64Json,
    required this.revisedPrompt,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIImageData] object.
  factory OpenAIImageData.fromMap(Map<String, dynamic> json) {
    return OpenAIImageData(
      url: json['url'],
      b64Json: json['b64_json'],
      revisedPrompt: json['revised_prompt'],
    );
  }

  @override
  bool operator ==(covariant OpenAIImageData other) {
    if (identical(this, other)) return true;

    return other.url == url &&
        other.b64Json == b64Json &&
        other.revisedPrompt == revisedPrompt;
  }

  @override
  String toString() =>
      'OpenAIImageData(url: $url, b64Json: $b64Json, revisedPrompt: $revisedPrompt)';
}
