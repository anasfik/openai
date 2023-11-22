import 'package:meta/meta.dart';

/// {@template openai_moderation_result_categories_model}
///  This class is used to represent an OpenAI moderation job result categories.
/// {@endtemplate}
@immutable
final class OpenAIModerationResultCategoriesModel {
  /// The hate category.
  final bool hate;

  /// The hate and threatening category.
  final bool hateAndThreatening;

  /// The self harm category.
  final bool selfHarm;

  /// The sexual category.
  final bool sexual;

  /// The sexual and minors category.
  final bool sexualAndMinors;

  /// The violence category.
  final bool violence;

  /// The violence and graphic category.
  final bool violenceAndGraphic;

  /// Whether hate is detected or not.
  bool get isHate => hate;

  /// Whether hate and threatening is detected or not.
  bool get isHateAndThreatening => hateAndThreatening;

  /// Whether self harm is detected or not.
  bool get isSelfHarm => selfHarm;

  /// Whether sexual is detected or not.
  bool get isSexual => sexual;

  /// Whether sexual and minors is detected or not.
  bool get isSexualAndMinors => sexualAndMinors;

  /// Whether violence is detected or not.
  bool get isViolence => violence;

  /// Whether violence and graphic is detected or not.
  bool get isViolenceAndGraphic => violenceAndGraphic;

  /// Whether the moderation request is safe or not.
  bool get isSafe =>
      !hate &&
      !hateAndThreatening &&
      !selfHarm &&
      !sexual &&
      !sexualAndMinors &&
      !violence &&
      !violenceAndGraphic;

  /// Whether the moderation request is not safe or not.
  bool get isNotSafe => !isSafe;

  @override
  int get hashCode {
    return hate.hashCode ^
        hateAndThreatening.hashCode ^
        selfHarm.hashCode ^
        sexual.hashCode ^
        sexualAndMinors.hashCode ^
        violence.hashCode ^
        violenceAndGraphic.hashCode;
  }

  /// This class is used to represent an OpenAI moderation job result categories.
  const OpenAIModerationResultCategoriesModel({
    required this.hate,
    required this.hateAndThreatening,
    required this.selfHarm,
    required this.sexual,
    required this.sexualAndMinors,
    required this.violence,
    required this.violenceAndGraphic,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIModerationResultCategoriesModel] object.
  factory OpenAIModerationResultCategoriesModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return OpenAIModerationResultCategoriesModel(
      hate: json['hate'],
      hateAndThreatening: json['hate/threatening'],
      selfHarm: json['self-harm'],
      sexual: json['sexual'],
      sexualAndMinors: json['sexual/minors'],
      violence: json['violence'],
      violenceAndGraphic: json['violence/graphic'],
    );
  }

  @override
  String toString() {
    return 'OpenAIModerationResultCategoriesModel(hate: $hate, hateAndThreatening: $hateAndThreatening, selfHarm: $selfHarm, sexual: $sexual, sexualAndMinors: $sexualAndMinors, violence: $violence, violenceAndGraphic: $violenceAndGraphic)';
  }

  @override
  bool operator ==(covariant OpenAIModerationResultCategoriesModel other) {
    if (identical(this, other)) return true;

    return other.hate == hate &&
        other.hateAndThreatening == hateAndThreatening &&
        other.selfHarm == selfHarm &&
        other.sexual == sexual &&
        other.sexualAndMinors == sexualAndMinors &&
        other.violence == violence &&
        other.violenceAndGraphic == violenceAndGraphic;
  }
}
