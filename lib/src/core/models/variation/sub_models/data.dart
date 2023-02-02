class OpenAIVariationData {
  final String url;

  OpenAIVariationData({
    required this.url,
  });

  factory OpenAIVariationData.fromJson(Map<String, dynamic> json) {
    return OpenAIVariationData(url: json['url']);
  }
}
