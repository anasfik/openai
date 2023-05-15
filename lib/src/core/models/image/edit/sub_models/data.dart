import 'package:meta/meta.dart';

@immutable
final class OpenAIImageEditDataModel {
  /// The url of the image.
  final String? url;

  /// The [OpenAIImageResponseFormat] b64Json data
  final String? data;

  @override
  int get hashCode => url.hashCode;

  /// This class is used to represent an OpenAI image edit data.
  const OpenAIImageEditDataModel({
    this.url,
    this.data,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIImageEditDataModel] object.
  factory OpenAIImageEditDataModel.fromMap(Map<String, dynamic> json) {
    return OpenAIImageEditDataModel(
      url: json['url'],
      data: json['data'],
    );
  }

  @override
  String toString() => 'OpenAIImageEditDataModel(url: $url, data: $data)';

  @override
  bool operator ==(covariant OpenAIImageEditDataModel other) {
    if (identical(this, other)) return true;

    return other.url == url && other.data == data;
  }
}
