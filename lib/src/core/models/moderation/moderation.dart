import 'sub_models/result.dart';

export 'sub_models/result.dart';

class OpenAIModerationModel {
  /// The ID of the moderation job.
  final String id;

  /// The model used for moderation.
  final String model;

  /// The results of the moderation job.
  final List<OpenAIModerationResultModel> results;

  /// This class is used to represent an OpenAI moderation job.
  OpenAIModerationModel({
    required this.id,
    required this.model,
    required this.results,
  });

  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIModerationModel] object.
  factory OpenAIModerationModel.fromJson(Map<String, dynamic> json) {
    return OpenAIModerationModel(
      id: json['id'],
      model: json['model'],
      results: List<OpenAIModerationResultModel>.from(
        json['results'].map(
          (x) => OpenAIModerationResultModel.fromJson(x),
        ),
      ),
    );
  }
}
