import 'package:collection/collection.dart';

import 'sub_models/permission.dart';

class OpenAIModelModel {
  final String id;
  final String ownedBy;
  final List<OpenAIModelModelPermission> permission;

  OpenAIModelModel({
    required this.id,
    required this.ownedBy,
    required this.permission,
  });

  factory OpenAIModelModel.fromJson(Map<String, dynamic> json) {
    return OpenAIModelModel(
      id: json['id'],
      ownedBy: json['owned_by'],
      permission: (json['permission'] as List<dynamic>)
          .map((e) =>
              OpenAIModelModelPermission.fromJson(e as Map<String, dynamic>))
          .toList(),
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

  @override
  int get hashCode => id.hashCode ^ ownedBy.hashCode ^ permission.hashCode;
}

