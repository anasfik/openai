class OpenAIImageData {
  final String url;

  OpenAIImageData({
    required this.url,
  });

  factory OpenAIImageData.fromJson(Map<String, dynamic> json) {
    return OpenAIImageData(url: json['url']);
  }
}
