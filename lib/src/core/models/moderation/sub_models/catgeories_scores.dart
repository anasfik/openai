import 'package:meta/meta.dart';

@immutable
class OpenAIModerationResultScoresModel {
  /// The hate score of the moderation job.
  final double hate;

  /// The hate and threatening score of the moderation job.
  final double hateAndThreatening;

  /// The self harm score of the moderation job.
  final double selfHarm;

  /// The sexual score of the moderation job.
  final double sexual;

  /// The sexual and minors score of the moderation job.
  final double sexualAndMinors;

  /// The violence score of the moderation job.
  final double violence;

  /// The violence and graphic score of the moderation job.
  final double violenceAndGraphic;

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

  /// This class is used to represent an OpenAI moderation job result scores.
  const OpenAIModerationResultScoresModel({
    required this.hate,
    required this.hateAndThreatening,
    required this.selfHarm,
    required this.sexual,
    required this.sexualAndMinors,
    required this.violence,
    required this.violenceAndGraphic,
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
}
