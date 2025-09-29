import 'package:dart_openai/src/core/models/moderation/sub_models/category_applied_input_types.dart';
import 'package:meta/meta.dart';

import 'catgeories.dart';
import 'catgeories_scores.dart';

export 'catgeories.dart';
export 'catgeories_scores.dart';

/// {@template openai_moderation_result_model}
///  This class is used to represent an OpenAI moderation job result.
/// {@endtemplate}
@immutable
final class OpenAIModerationResultModel {
  /// The categories of the moderation job.
  final OpenAIModerationResultCategoriesModel categories;

  ///
  final OpenAIModerationResultCategoryAppliedInputTypes
      categoryAppliedInputTypes;

  /// The category scores of the moderation job.
  final OpenAIModerationResultScoresModel categoryScores;

  /// The flagged status of the moderation job.
  final bool flagged;

  /// {@macro openai_moderation_result_model}
  const OpenAIModerationResultModel({
    required this.categories,
    required this.categoryScores,
    required this.flagged,
    required this.categoryAppliedInputTypes,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIModerationResultModel] object.
  factory OpenAIModerationResultModel.fromMap(Map<String, dynamic> json) {
    return OpenAIModerationResultModel(
      categories: OpenAIModerationResultCategoriesModel.fromMap(
        json['categories'],
      ),
      categoryScores: OpenAIModerationResultScoresModel.fromMap(
        json['category_scores'],
      ),
      categoryAppliedInputTypes:
          OpenAIModerationResultCategoryAppliedInputTypes.fromMap(
        json['category_applied_input_types'],
      ),
      flagged: json['flagged'],
    );
  }
}
