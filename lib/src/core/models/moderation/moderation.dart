// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'sub_models/result.dart';

export 'sub_models/result.dart';

/// {@template openai_moderation_model}
///  This class is used to represent an OpenAI moderation job.
/// {@endtemplate}
@immutable
final class OpenAIModerationModel {
  /// The [id]entifier of the moderation job.
  final String id;

  /// The [model] used for moderation.
  final String model;

  /// The [results] of the moderation job.
  final List<OpenAIModerationResultModel> results;

  /// Weither the moderation job have at least one result in [results].
  bool get haveResults => results.isNotEmpty;

  @override
  int get hashCode => id.hashCode ^ model.hashCode ^ results.hashCode;

  /// {@macro openai_moderation_model}
  const OpenAIModerationModel({
    required this.id,
    required this.model,
    required this.results,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIModerationModel] object.
  factory OpenAIModerationModel.fromMap(Map<String, dynamic> json) {
    return OpenAIModerationModel(
      id: json['id'],
      model: json['model'],
      results: List<OpenAIModerationResultModel>.from(
        json['results'].map(
          (x) => OpenAIModerationResultModel.fromMap(x),
        ),
      ),
    );
  }

  @override
  String toString() =>
      'OpenAIModerationModel(id: $id, model: $model, results: $results)';

  @override
  bool operator ==(covariant OpenAIModerationModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.model == model &&
        listEquals(other.results, results);
  }
}
