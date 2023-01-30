class OpenAIImageModel {
  final DateTime created;
  final List<OpenAIImageData> data;

  OpenAIImageModel({required this.created, required this.data});

  factory OpenAIImageModel.fromJson(Map<String, dynamic> json) {
    return OpenAIImageModel(
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000),
      data: (json['data'] as List)
          .map((e) => OpenAIImageData.fromJson(e))
          .toList(),
    );
  }
}

class OpenAIImageData {
  final String url;

  OpenAIImageData({
    required this.url,
  });

  factory OpenAIImageData.fromJson(Map<String, dynamic> json) {
    return OpenAIImageData(url: json['url']);
  }
}
