class OpenAiImageEditDataModel {
  /// The url of the image.
  final String url;

  /// This class is used to represent an OpenAI image edit data.
  OpenAiImageEditDataModel({
    required this.url,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAiImageEditDataModel] object.
  factory OpenAiImageEditDataModel.fromJson(Map<String, dynamic> json) {
    return OpenAiImageEditDataModel(
      url: json['url'],
    );
  }

  @override
  String toString() => 'OpenAiImageEditDataModel(url: $url)';

  @override
  bool operator ==(covariant OpenAiImageEditDataModel other) {
    if (identical(this, other)) return true;

    return other.url == url;
  }

  @override
  int get hashCode => url.hashCode;
}
