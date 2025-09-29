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
