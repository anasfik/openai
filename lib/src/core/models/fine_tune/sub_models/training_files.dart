import 'package:meta/meta.dart';

@immutable
class OpenAIFineTuneTrainingFilesModel {
  /// The id of the file.
  final String id;

  /// The number of bytes in the file.
  final int bytes;

  /// The time the file was created.
  final DateTime createdAt;

  /// The name of the file.
  final String filename;

  /// The purpose of the file.
  final String? purpose;

  @override
  int get hashCode {
    return id.hashCode ^
        bytes.hashCode ^
        createdAt.hashCode ^
        filename.hashCode ^
        purpose.hashCode;
  }

  /// This class is used to represent an OpenAI fine-tune training file.
  const OpenAIFineTuneTrainingFilesModel({
    required this.id,
    required this.bytes,
    required this.createdAt,
    required this.filename,
    required this.purpose,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIFineTuneTrainingFilesModel] object.
  factory OpenAIFineTuneTrainingFilesModel.fromMap(Map<String, dynamic> json) {
    return OpenAIFineTuneTrainingFilesModel(
      id: json['id'],
      bytes: json['bytes'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at'] * 1000),
      filename: json['filename'],
      purpose: json['purpose'],
    );
  }

  @override
  String toString() {
    return 'OpenAIFineTuneTrainingFilesModel(id: $id, bytes: $bytes, createdAt: $createdAt, filename: $filename, purpose: $purpose)';
  }

  @override
  bool operator ==(covariant OpenAIFineTuneTrainingFilesModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.bytes == bytes &&
        other.createdAt == createdAt &&
        other.filename == filename &&
        other.purpose == purpose;
  }
}
