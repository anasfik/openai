import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'sub_models/permission.dart';

/// {@template openai_model_model}
///  This class is used to represent an OpenAI model.
/// {@endtemplate}
@immutable
final class OpenAIModelModel {
  /// The [id]entifier of the model.
  final String id;

  /// The name of the organization that owns the model.
  final String ownedBy;

  /// The [permission]s of the model.
  final List<OpenAIModelModelPermission>? permission;

  /// Weither the model have at least one permission in [permission].
  bool get havePermission => permission != null;

  @override
  int get hashCode => id.hashCode ^ ownedBy.hashCode ^ permission.hashCode;

  /// {@macro openai_model_model}
  const OpenAIModelModel({
    required this.id,
    required this.ownedBy,
    required this.permission,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIModelModel] object.
  factory OpenAIModelModel.fromMap(Map<String, dynamic> json) {
    // Perform a null check, and if 'permission' is null, use an empty list or null.
    final permissionJson = json['permission'] as List?;
    final permissions = permissionJson != null
        ? permissionJson
            .map((e) =>
                OpenAIModelModelPermission.fromMap(e as Map<String, dynamic>))
            .toList()
        : <OpenAIModelModelPermission>[];

    return OpenAIModelModel(
      id: json['id'],
      ownedBy: json['owned_by'],
      permission: permissions,
    );
  }

  @override
  String toString() =>
      'OpenAIModelModel(id: $id, ownedBy: $ownedBy, permission: $permission)';

  @override
  bool operator ==(covariant OpenAIModelModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.ownedBy == ownedBy &&
        listEquals(other.permission, permission);
  }
}
