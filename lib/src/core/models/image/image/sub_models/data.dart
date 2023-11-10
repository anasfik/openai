import 'package:meta/meta.dart';

@immutable
final class OpenAIImageData {
  /// The URL of the image.
  final String? url;

  /// the [OpenAIImageResponseFormat] b64Json data
  final String? b64Json;

  ///
  final String? revisedPrompt;

  @override
  int get hashCode => url.hashCode;

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
