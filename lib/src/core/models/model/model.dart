import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'sub_models/permission.dart';

export 'sub_models/permission.dart';

@immutable
final class OpenAIModelModel {
  /// The ID of the model.
  final String id;

  /// The name of the organization that owns the model.
  final String ownedBy;

  /// The permissions of the model.
  final List<OpenAIModelModelPermission>? permission;

  @override
  int get hashCode => id.hashCode ^ ownedBy.hashCode ^ permission.hashCode;

  /// This class is used to represent an OpenAI model.
  const OpenAIModelModel({
    required this.id,
    required this.ownedBy,
    required this.permission,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIModelModel] object.
  factory OpenAIModelModel.fromMap(Map<String, dynamic> json) {
    // 进行空检查，如果 'permission' 为 null，则使用空列表或者 null。
    final permissionJson = json['permission'] as List?;
    final permissions = permissionJson != null
        ? permissionJson.map((e) => OpenAIModelModelPermission.fromMap(e as Map<String, dynamic>)).toList()
        : null; // 或者使用 <OpenAIModelModelPermission>[] 代替 null，如果你想要一个空列表。

    return OpenAIModelModel(
      id: json['id'] as String,
      ownedBy: json['owned_by'] as String,
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
        other.ownedBy == ownedBy && listEquals(other.permission, permission);
  }
}
