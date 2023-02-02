class OpenAIVariationData {
  final String url;

  OpenAIVariationData({
    required this.url,
  });

  factory OpenAIVariationData.fromJson(Map<String, dynamic> json) {
    return OpenAIVariationData(url: json['url']);
  }

  @override
  String toString() => 'OpenAIVariationData(url: $url)';

  @override
  bool operator ==(covariant OpenAIVariationData other) {
    if (identical(this, other)) return true;

    return other.url == url;
  }

  @override
  int get hashCode => url.hashCode;
}
