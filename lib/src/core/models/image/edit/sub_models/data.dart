// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  @override
  String toString() => 'OpenAiImageEditDataModel(url: $url)';

  @override
  bool operator ==(covariant OpenAiImageEditDataModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.url == url;
  }

  @override
  int get hashCode => url.hashCode;
}
