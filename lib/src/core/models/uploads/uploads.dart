class OpenAIUploadModel {
  final int bytes;
  final int createdAt;
  final int expiresAt;
  // to remove confusion, https://platform.openai.com/docs/api-reference/uploads/object#uploads/object-file
  final file;
  final String filename;
  final String id;
  final String purpose;
  final String status;

  OpenAIUploadModel({
    required this.bytes,
    required this.createdAt,
    required this.expiresAt,
    required this.file,
    required this.filename,
    required this.id,
    required this.purpose,
    required this.status,
  });
}

extension UploadModelParsing on OpenAIUploadModel {
  static OpenAIUploadModel fromMap(Map<String, dynamic> map) {
    return OpenAIUploadModel(
      bytes: map['bytes'] as int? ?? 0,
      createdAt: map['created_at'] as int? ?? 0,
      expiresAt: map['expires_at'] as int? ?? 0,
      file: map['file'],
      filename: map['filename'] as String? ?? '',
      id: map['id'] as String? ?? '',
      purpose: map['purpose'] as String? ?? '',
      status: map['status'] as String? ?? '',
    );
  }
}
