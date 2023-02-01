class OpenAIVariationModel {
  final DateTime created;
  final List<OpenAIVariationData> data;

  OpenAIVariationModel({required this.created, required this.data});

  factory OpenAIVariationModel.fromJson(Map<String, dynamic> json) {
    return OpenAIVariationModel(
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
