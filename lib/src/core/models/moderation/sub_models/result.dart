import 'catgeories.dart';
import 'catgeories_scores.dart';

export 'catgeories.dart';
export 'catgeories_scores.dart';

class OpenAIModerationResultModel {
  /// The categories of the moderation job.
  final OpenAIModerationResultCategoriesModel categories;

  /// The category scores of the moderation job.
  final OpenAIModerationResultScoresModel categoryScores;

  /// The flagged status of the moderation job.
  final bool flagged;

  /// This class is used to represent an OpenAI moderation job result.
  OpenAIModerationResultModel({
    required this.categories,
    required this.categoryScores,
    required this.flagged,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIModerationResultModel] object.
  factory OpenAIModerationResultModel.fromJson(Map<String, dynamic> json) {
    return OpenAIModerationResultModel(
      categories: OpenAIModerationResultCategoriesModel.fromJson(
        json['categories'],
      ),
      categoryScores: OpenAIModerationResultScoresModel.fromJson(
        json['category_scores'],
      ),
      flagged: json['flagged'],
    );
  }

  @override
  String toString() =>
      'OpenAIModerationResultModel(categories: $categories, categoryScores: $categoryScores, flagged: $flagged)';

  @override
  bool operator ==(covariant OpenAIModerationResultModel other) {
    if (identical(this, other)) return true;

    return other.categories == categories &&
        other.categoryScores == categoryScores &&
        other.flagged == flagged;
  }

  @override
  int get hashCode =>
      categories.hashCode ^ categoryScores.hashCode ^ flagged.hashCode;
}
