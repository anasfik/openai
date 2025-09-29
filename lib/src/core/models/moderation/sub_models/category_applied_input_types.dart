class OpenAIModerationResultCategoryAppliedInputTypes {
  /// The harassment category.
  final List<String> harassment;

  /// The harassment and threatening category.
  final List<String> harassmentAndThreatening;

  /// The hate category.
  final List<String> hate;

  /// The hate and threatening category.
  final List<String> hateAndThreatening;

  /// The illicit category.
  final List<String> illicit;

  /// The illicit and violent category.
  final List<String> illicitAndViolent;

  /// The self harm category.
  final List<String> selfHarm;

  /// The self harm and instructions category.
  final List<String> selfHarmAndInstructions;

  /// The self harm intent category.
  final List<String> selfHarmIntent;

  /// The sexual category.
  final List<String> sexual;

  /// The sexual and minors category.
  final List<String> sexualAndMinors;

  /// The violence category.
  final List<String> violence;

  /// The violence and graphic category.
  final List<String> violenceAndGraphic;

  OpenAIModerationResultCategoryAppliedInputTypes({
    required this.harassment,
    required this.harassmentAndThreatening,
    required this.hate,
    required this.hateAndThreatening,
    required this.illicit,
    required this.illicitAndViolent,
    required this.selfHarm,
    required this.selfHarmAndInstructions,
    required this.selfHarmIntent,
    required this.sexual,
    required this.sexualAndMinors,
    required this.violence,
    required this.violenceAndGraphic,
  });

  factory OpenAIModerationResultCategoryAppliedInputTypes.fromMap(
    Map<String, dynamic> json,
  ) {
    return OpenAIModerationResultCategoryAppliedInputTypes(
      harassment: List<String>.from(json['harassment'] ?? []),
      harassmentAndThreatening:
          List<String>.from(json['harassment/threatening'] ?? []),
      hate: List<String>.from(json['hate'] ?? []),
      hateAndThreatening: List<String>.from(json['hate/threatening'] ?? []),
      illicit: List<String>.from(json['illicit'] ?? []),
      illicitAndViolent: List<String>.from(json['illicit/violent'] ?? []),
      selfHarm: List<String>.from(json['self-harm'] ?? []),
      selfHarmAndInstructions:
          List<String>.from(json['self-harm/instructions'] ?? []),
      selfHarmIntent: List<String>.from(json['self-harm/intent'] ?? []),
      sexual: List<String>.from(json['sexual'] ?? []),
      sexualAndMinors: List<String>.from(json['sexual/minors'] ?? []),
      violence: List<String>.from(json['violence'] ?? []),
      violenceAndGraphic: List<String>.from(
        json['violence/graphic'] ?? [],
      ),
    );
  }
}
