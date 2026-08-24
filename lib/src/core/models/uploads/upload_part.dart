class OpenAIUploadPartModel {
  final int createdAt;
  final String id;
  final String uploadId;

  OpenAIUploadPartModel({
    required this.createdAt,
    required this.id,
    required this.uploadId,
  });
}

extension UploadPartParsing on OpenAIUploadPartModel {
  static OpenAIUploadPartModel fromMap(Map<String, dynamic> map) {
    return OpenAIUploadPartModel(
      createdAt: map['created_at'] as int? ?? 0,
      id: map['id'] as String? ?? '',
      uploadId: map['upload_id'] as String? ?? '',
    );
  }
}
