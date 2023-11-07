import 'package:meta/meta.dart';

export 'sub_models/permission.dart';

@immutable
final class OpenAIModelModel {
  /// The ID of the model.
  final String id;

  /// The name of the organization that owns the model.
  final String ownedBy;

  @override
  int get hashCode => id.hashCode ^ ownedBy.hashCode;

  /// This class is used to represent an OpenAI model.
  const OpenAIModelModel({
    required this.id,
    required this.ownedBy,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIModelModel] object.
  factory OpenAIModelModel.fromMap(Map<String, dynamic> json) {
    return OpenAIModelModel(
      id: json['id'],
      ownedBy: json['owned_by'],
    );
  }

  @override
  String toString() => 'OpenAIModelModel(id: $id, ownedBy: $ownedBy)';

  @override
  bool operator ==(covariant OpenAIModelModel other) => identical(this, other)
      ? true
      : other.id == id && other.ownedBy == ownedBy;
}
