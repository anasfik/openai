import 'package:collection/collection.dart';

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

class OpenAIModelModelPermission {
  final String? id;
  final String? object;
  final int? created;
  final bool? allowCreateEngine;
  final bool? allowSampling;
  final bool? allowLogprobs;
  final bool? allowSearchIndices;
  final bool? allowView;
  final bool? allowFineTuning;
  final String? organization;
  final String? group;
  final bool? isBlocking;

  OpenAIModelModelPermission(
      {this.id,
      this.object,
      this.created,
      this.allowCreateEngine,
      this.allowSampling,
      this.allowLogprobs,
      this.allowSearchIndices,
      this.allowView,
      this.allowFineTuning,
      this.organization,
      this.group,
      this.isBlocking});

  factory OpenAIModelModelPermission.fromJson(Map<String, dynamic> json) {
    return OpenAIModelModelPermission(
      id: json['id'],
      object: json['object'],
      created: json['created'],
      allowCreateEngine: json['allow_create_engine'],
      allowSampling: json['allow_sampling'],
      allowLogprobs: json['allow_logprobs'],
      allowSearchIndices: json['allow_search_indices'],
      allowView: json['allow_view'],
      allowFineTuning: json['allow_fine_tuning'],
      organization: json['organization'],
      group: json['group'],
      isBlocking: json['is_blocking'],
    );
  }

  @override
  String toString() {
    return 'OpenAIModelModelPermission(id: $id, object: $object, created: $created, allowCreateEngine: $allowCreateEngine, allowSampling: $allowSampling, allowLogprobs: $allowLogprobs, allowSearchIndices: $allowSearchIndices, allowView: $allowView, allowFineTuning: $allowFineTuning, organization: $organization, group: $group, isBlocking: $isBlocking)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OpenAIModelModelPermission &&
        other.id == id &&
        other.object == object &&
        other.created == created &&
        other.allowCreateEngine == allowCreateEngine &&
        other.allowSampling == allowSampling &&
        other.allowLogprobs == allowLogprobs &&
        other.allowSearchIndices == allowSearchIndices &&
        other.allowView == allowView &&
        other.allowFineTuning == allowFineTuning &&
        other.organization == organization &&
        other.group == group &&
        other.isBlocking == isBlocking;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        object.hashCode ^
        created.hashCode ^
        allowCreateEngine.hashCode ^
        allowSampling.hashCode ^
        allowLogprobs.hashCode ^
        allowSearchIndices.hashCode ^
        allowView.hashCode ^
        allowFineTuning.hashCode ^
        organization.hashCode ^
        group.hashCode ^
        isBlocking.hashCode;
  }
}
