import 'package:meta/meta.dart';

@immutable
final class OpenAIImageData {
  /// The URL of the image.
  final String? url;

  /// the [OpenAIImageResponseFormat] b64Json data
  final String? data;

  @override
  int get hashCode => url.hashCode;

  /// This class is used to represent an OpenAI image data.
  const OpenAIImageData({
    this.url,
    this.data,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIImageData] object.
  factory OpenAIImageData.fromMap(Map<String, dynamic> json) {
    return OpenAIImageData(
      url: json.keys.contains('url') ? json['url'] : null,
      data: json.keys.contains('b64_json') ? json['b64_json'] : null,
    );
  }

  @override
  bool operator ==(covariant OpenAIImageData other) {
    if (identical(this, other)) return true;

    return other.url == url && other.data == data;
  }

  @override
  String toString() => 'OpenAIImageData(url: $url)';
}
