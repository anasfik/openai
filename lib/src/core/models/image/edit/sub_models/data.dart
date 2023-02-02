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
