class OpenAIModerationResultScoresModel {
  final double hate;
  final double hateAndThreatening;
  final double selfHarm;
  final double sexual;
  final double sexualAndMinors;
  final double violence;
  final double violenceAndGraphic;

  OpenAIModerationResultScoresModel({
    required this.hate,
    required this.hateAndThreatening,
    required this.selfHarm,
    required this.sexual,
    required this.sexualAndMinors,
    required this.violence,
    required this.violenceAndGraphic,
  });

  factory OpenAIModerationResultScoresModel.fromJson(
      Map<String, dynamic> json) {
    return OpenAIModerationResultScoresModel(
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
    return 'OpenAIModerationResultScoresModel(hate: $hate, hateAndThreatening: $hateAndThreatening, selfHarm: $selfHarm, sexual: $sexual, sexualAndMinors: $sexualAndMinors, violence: $violence, violenceAndGraphic: $violenceAndGraphic)';
  }

  @override
  bool operator ==(covariant OpenAIModerationResultScoresModel other) {
    if (identical(this, other)) return true;

    return other.hate == hate &&
        other.hateAndThreatening == hateAndThreatening &&
        other.selfHarm == selfHarm &&
        other.sexual == sexual &&
        other.sexualAndMinors == sexualAndMinors &&
        other.violence == violence &&
        other.violenceAndGraphic == violenceAndGraphic;
  }

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
}
