class OpenAiFineTuneTrainingFilesModel {
  final String id;
  final int bytes;
  final DateTime createdAt;
  final String filename;
  final String? purpose;

  OpenAiFineTuneTrainingFilesModel({
    required this.id,
    required this.bytes,
    required this.createdAt,
    required this.filename,
    required this.purpose,
  });

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
