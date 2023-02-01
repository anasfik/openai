class OpenAIImageVariationModel {
  final DateTime created;
  final List<OpenAIVariationData> data;

  OpenAIImageVariationModel({required this.created, required this.data});

  factory OpenAIImageVariationModel.fromJson(Map<String, dynamic> json) {
    return OpenAIImageVariationModel(
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000),
      data: (json['data'] as List)
          .map((e) => OpenAIVariationData.fromJson(e))
          .toList(),
    );
  }
}

class OpenAIVariationData {
  final String url;

  OpenAIVariationData({
    required this.url,
  });

  factory OpenAIVariationData.fromJson(Map<String, dynamic> json) {
    return OpenAIVariationData(url: json['url']);
  }
}
