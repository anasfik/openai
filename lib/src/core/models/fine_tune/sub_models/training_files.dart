class OpenAiFineTuneTrainingFilesModel {
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

  /// This class is used to represent an OpenAI fine-tune training file.
  OpenAiFineTuneTrainingFilesModel({
    required this.id,
    required this.bytes,
    required this.createdAt,
    required this.filename,
    required this.purpose,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAiFineTuneTrainingFilesModel] object.
  factory OpenAiFineTuneTrainingFilesModel.fromJson(Map<String, dynamic> json) {
    return OpenAiFineTuneTrainingFilesModel(
      id: json['id'],
      bytes: json['bytes'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at'] * 1000),
      filename: json['filename'],
      purpose: json['purpose'],
    );
  }

  @override
  String toString() {
    return 'OpenAiFineTuneTrainingFilesModel(id: $id, bytes: $bytes, createdAt: $createdAt, filename: $filename, purpose: $purpose)';
  }

  @override
  bool operator ==(covariant OpenAiFineTuneTrainingFilesModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.bytes == bytes &&
        other.createdAt == createdAt &&
        other.filename == filename &&
        other.purpose == purpose;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        bytes.hashCode ^
        createdAt.hashCode ^
        filename.hashCode ^
        purpose.hashCode;
  }
}
