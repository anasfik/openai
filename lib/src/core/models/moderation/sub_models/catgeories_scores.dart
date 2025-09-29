import 'package:meta/meta.dart';

/// {@template openai_moderation_result_scores_model}
///  This class is used to represent an OpenAI moderation job result scores.
/// {@endtemplate}
@immutable
final class OpenAIModerationResultScoresModel {
  /// The harassment category.
  final double harassment;

  /// The harassment and threatening category.
  final double harassmentAndThreatening;

  /// The hate category.
  final double hate;

  /// The hate and threatening category.
  final double hateAndThreatening;

  /// The illicit category.
  final double illicit;

  /// The illicit and violent category.
  final double illicitAndViolent;

  /// The self harm category.
  final double selfHarm;

  /// The self harm and instructions category.
  final double selfHarmAndInstructions;

  /// The self harm intent category.
  final double selfHarmIntent;

  /// The sexual category.
  final double sexual;

  /// The sexual and minors category.
  final double sexualAndMinors;

  /// The violence category.
  final double violence;

  /// The violence and graphic category.
  final double violenceAndGraphic;

  /// This class is used to represent an OpenAI moderation job result scores.
  const OpenAIModerationResultScoresModel({
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

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIModerationResultScoresModel] object.
  factory OpenAIModerationResultScoresModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return OpenAIModerationResultScoresModel(
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
