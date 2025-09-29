import 'package:meta/meta.dart';

/// {@template openai_moderation_result_categories_model}
///  This class is used to represent an OpenAI moderation job result categories.
/// {@endtemplate}
@immutable
final class OpenAIModerationResultCategoriesModel {
  /// The harassment category.
  final bool harassment;

  /// The harassment and threatening category.
  final bool harassmentAndThreatening;

  /// The hate category.
  final bool hate;

  /// The hate and threatening category.
  final bool hateAndThreatening;

  /// The illicit category.
  final bool illicit;

  /// The illicit and violent category.
  final bool illicitAndViolent;

  /// The self harm category.
  final bool selfHarm;

  /// The self harm and instructions category.
  final bool selfHarmAndInstructions;

  /// The self harm intent category.
  final bool selfHarmIntent;

  /// The sexual category.
  final bool sexual;

  /// The sexual and minors category.
  final bool sexualAndMinors;

  /// The violence category.
  final bool violence;

  /// The violence and graphic category.
  final bool violenceAndGraphic;

  /// Whether harassment is detected or not.
  bool get isHarassment => harassment;

  /// Whether harassment and threatening is detected or not.
  bool get isHarassmentAndThreatening => harassmentAndThreatening;

  /// Whether hate is detected or not.
  bool get isHate => hate;

  /// Whether hate and threatening is detected or not.
  bool get isHateAndThreatening => hateAndThreatening;

  /// Whether illicit is detected or not.
  bool get isIllicit => illicit;

  /// Whether illicit and violent is detected or not.
  bool get isIllicitAndViolent => illicitAndViolent;

  /// Whether self harm is detected or not.
  bool get isSelfHarm => selfHarm;

  /// Whether self harm and instructions is detected or not.
  bool get isSelfHarmAndInstructions => selfHarmAndInstructions;

  /// Whether self harm intent is detected or not.
  bool get isSelfHarmIntent => selfHarmIntent;

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
      !violenceAndGraphic &&
      !harassment &&
      !harassmentAndThreatening &&
      !illicit &&
      !illicitAndViolent &&
      !selfHarmAndInstructions &&
      !selfHarmIntent;

  /// Whether the moderation request is not safe or not.
  bool get isNotSafe => !isSafe;

  /// This class is used to represent an OpenAI moderation job result categories.
  const OpenAIModerationResultCategoriesModel({
    required this.hate,
    required this.hateAndThreatening,
    required this.selfHarm,
    required this.sexual,
    required this.sexualAndMinors,
    required this.violence,
    required this.violenceAndGraphic,
    required this.harassment,
    required this.harassmentAndThreatening,
    required this.illicit,
    required this.illicitAndViolent,
    required this.selfHarmAndInstructions,
    required this.selfHarmIntent,
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
      harassment: json['harassment'],
      harassmentAndThreatening: json['harassment/threatening'],
      illicit: json['illicit'],
      illicitAndViolent: json['illicit/violent'],
      selfHarmAndInstructions: json['self-harm/instructions'],
      selfHarmIntent: json['self-harm/intent'],
    );
  }
}
