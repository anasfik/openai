import 'package:meta/meta.dart';

/// {@template openai_model_model}
///  This class is used to represent an OpenAI model.
/// {@endtemplate}
@immutable
final class OpenAIModelModel {
  /// The [id]entifier of the model.
  final String id;

  /// The name of the organization that owns the model.
  final String ownedBy;

  ///
  final int? created;

  /// {@macro openai_model_model}
  const OpenAIModelModel({
    required this.id,
    required this.ownedBy,
    required this.created,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIModelModel] object.
  factory OpenAIModelModel.fromMap(Map<String, dynamic> json) {
    return OpenAIModelModel(
      id: json['id'],
      ownedBy: json['owned_by'],
      created: json['created'],
    );
  }
}
