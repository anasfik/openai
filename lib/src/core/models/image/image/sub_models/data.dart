import 'package:meta/meta.dart';

@immutable
class OpenAIImageData {
  /// The URL of the image.
  final String url;

  @override
  int get hashCode => url.hashCode;

  /// This class is used to represent an OpenAI image data.
  const OpenAIImageData({
    required this.url,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIImageData] object.
  factory OpenAIImageData.fromMap(Map<String, dynamic> json) {
    return OpenAIImageData(url: json['url']);
  }

  @override
  bool operator ==(covariant OpenAIImageData other) {
    if (identical(this, other)) return true;

    return other.url == url;
  }

  @override
  String toString() => 'OpenAIImageData(url: $url)';
}
