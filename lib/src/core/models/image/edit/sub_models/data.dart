import 'package:meta/meta.dart';

@immutable
class OpenAIImageEditDataModel {
  /// The url of the image.
  final String url;

  @override
  int get hashCode => url.hashCode;

  /// This class is used to represent an OpenAI image edit data.
  const OpenAIImageEditDataModel({
    required this.url,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIImageEditDataModel] object.
  factory OpenAIImageEditDataModel.fromMap(Map<String, dynamic> json) {
    return OpenAIImageEditDataModel(
      url: json['url'],
    );
  }

  @override
  String toString() => 'OpenAIImageEditDataModel(url: $url)';

  @override
  bool operator ==(covariant OpenAIImageEditDataModel other) {
    if (identical(this, other)) return true;

    return other.url == url;
  }
}
