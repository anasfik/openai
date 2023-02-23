import 'package:meta/meta.dart';

@immutable
class OpenAIFileModel {
  /// The ID of the file. This is used to reference the file in other API calls.
  final String id;

  /// The size of the file in bytes.
  final int bytes;

  /// The date the file was created.
  final DateTime createdAt;

  /// The name of the file.
  final String fileName;

  /// The purpose of the file.
  final String purpose;

  @override
  int get hashCode {
    return id.hashCode ^
        bytes.hashCode ^
        createdAt.hashCode ^
        fileName.hashCode ^
        purpose.hashCode;
  }

  /// This class is used to represent an OpenAI file.
  const OpenAIFileModel({
    required this.id,
    required this.bytes,
    required this.createdAt,
    required this.fileName,
    required this.purpose,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIFileModel] object.
  factory OpenAIFileModel.fromMap(Map<String, dynamic> map) {
    return OpenAIFileModel(
      id: map['id'] as String,
      bytes: map['bytes'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      fileName: map['filename'] as String,
      purpose: map['purpose'] as String,
    );
  }

  @override
  bool operator ==(covariant OpenAIFileModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.bytes == bytes &&
        other.createdAt == createdAt &&
        other.fileName == fileName &&
        other.purpose == purpose;
  }

  @override
  String toString() {
    return 'OpenAIFileModel(id: $id, bytes: $bytes, createdAt: $createdAt, fileName: $fileName, purpose: $purpose)';
  }
}
