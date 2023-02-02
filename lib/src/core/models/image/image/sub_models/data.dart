// ignore_for_file: public_member_api_docs, sort_constructors_first
class OpenAIImageData {
  final String url;

  OpenAIImageData({
    required this.url,
  });

  factory OpenAIImageData.fromJson(Map<String, dynamic> json) {
    return OpenAIImageData(url: json['url']);
  }

  @override
  bool operator ==(covariant OpenAIImageData other) {
    if (identical(this, other)) return true;
  
    return 
      other.url == url;
  }

  @override
  int get hashCode => url.hashCode;

  @override
  String toString() => 'OpenAIImageData(url: $url)';
}
