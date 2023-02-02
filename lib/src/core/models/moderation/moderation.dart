import 'sub-models/result/result.dart';

class OpenAIModerationModel {
  final String id;
  final String model;
  final List<OpenAIModerationResultModel> results;

  OpenAIModerationModel({
    required this.id,
    required this.model,
    required this.results,
  });

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
