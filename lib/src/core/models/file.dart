import 'dart:convert';

class OpenAIFileModel {
  final String id;
  final int bytes;
  final DateTime createdAt;
  final String fileName;
  final String purpose;

  OpenAIFileModel({
    required this.id,
    required this.bytes,
    required this.createdAt,
    required this.fileName,
    required this.purpose,
  });

  factory OpenAIFileModel.fromMap(Map<String, dynamic> map) {
    return OpenAIFileModel(
      id: map['id'] as String,
      bytes: map['bytes'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      fileName: map['filename'] as String,
      purpose: map['purpose'] as String,
    );
  }
}
