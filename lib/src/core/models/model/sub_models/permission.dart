import 'package:meta/meta.dart';

/// {@template openai_model_model_permission}
///  This class is used to represent an OpenAI model permission.
/// {@endtemplate}
@immutable
final class OpenAIModelModelPermission {
  /// The [id]entifier of the permission.
  final String? id;

  /// The time the permission was [created].
  final DateTime? created;

  /// Whether the permission allows the user to create engines.
  final bool? allowCreateEngine;

  /// Whether the permission allows the user to sample from the model.
  final bool? allowSampling;

  /// Whether the permission allows the user to view logprobs.
  final bool? allowLogprobs;

  /// Whether the permission allows the user to search indices.
  final bool? allowSearchIndices;

  /// Whether the permission allows the user to view the model.
  final bool? allowView;

  /// Whether the permission allows the user to fine-tune the model.
  final bool? allowFineTuning;

  /// The organization of the permission.
  final String? organization;

  /// The group of the permission.
  final String? group;

  /// Whether the permission is blocking.
  final bool? isBlocking;

  @override
  int get hashCode {
    return id.hashCode ^
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

  /// This class is used to represent an OpenAI model permission, it's used in [OpenAIModelModel].
  const OpenAIModelModelPermission({
    this.id,
    this.created,
    this.allowCreateEngine,
    this.allowSampling,
    this.allowLogprobs,
    this.allowSearchIndices,
    this.allowView,
    this.allowFineTuning,
    this.organization,
    this.group,
    this.isBlocking,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIModelModelPermission] object.
  factory OpenAIModelModelPermission.fromMap(Map<String, dynamic> json) {
    return OpenAIModelModelPermission(
      id: json['id'],
      created:
          DateTime.fromMillisecondsSinceEpoch((json['created'] ?? 0) * 1000),
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
    return 'OpenAIModelModelPermission(id: $id, created: $created, allowCreateEngine: $allowCreateEngine, allowSampling: $allowSampling, allowLogprobs: $allowLogprobs, allowSearchIndices: $allowSearchIndices, allowView: $allowView, allowFineTuning: $allowFineTuning, organization: $organization, group: $group, isBlocking: $isBlocking)';
  }

  @override
  bool operator ==(covariant OpenAIModelModelPermission other) {
    if (identical(this, other)) return true;

    return other.id == id &&
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
}
