class OpenAiImageEditModel {
  final DateTime created;
  final List<OpenAiImageEditDataModel> data;

  OpenAiImageEditModel({
    required this.created,
    required this.data,
  });

  factory OpenAiImageEditModel.fromJson(Map<String, dynamic> json) {
    return OpenAiImageEditModel(
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000),
      data: List<OpenAiImageEditDataModel>.from(
        json['data'].map(
          (x) => OpenAiImageEditDataModel.fromJson(x),
        ),
      ),
    );
  }
}

class OpenAiImageEditDataModel {
  final String url;

  OpenAiImageEditDataModel({
    required this.url,
  });

  factory OpenAiImageEditDataModel.fromJson(Map<String, dynamic> json) {
    return OpenAiImageEditDataModel(
      url: json['url'],
    );
  }
}
