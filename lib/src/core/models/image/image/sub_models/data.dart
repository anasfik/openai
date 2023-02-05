class OpenAIImageData {
  /// The URL of the image.
  final String url;

  /// This class is used to represent an OpenAI image data.
  OpenAIImageData({
    required this.url,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIImageData] object.
  factory OpenAIImageData.fromJson(Map<String, dynamic> json) {
    return OpenAIImageData(url: json['url']);
  }

  @override
  bool operator ==(covariant OpenAIImageData other) {
    if (identical(this, other)) return true;

    return other.url == url;
  }

  @override
  int get hashCode => url.hashCode;

  @override
  String toString() => 'OpenAIImageData(url: $url)';
}
