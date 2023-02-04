import 'sub_models/choices.dart';

export 'sub_models/choices.dart';

class OpenAIStreamCompletionModel {
  String id;
  DateTime created;
  List<OpenAIStreamCompletionModelChoice> choices;
  String model;

  OpenAIStreamCompletionModel({
    required this.id,
    required this.created,
    required this.choices,
    required this.model,
  });

  factory OpenAIStreamCompletionModel.fromJson(Map<String, dynamic> json) {
    return OpenAIStreamCompletionModel(
      id: json['id'],
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000),
      choices: (json['choices'] as List)
          .map((e) => OpenAIStreamCompletionModelChoice.fromJson(e))
          .toList(),
      model: json['model'],
    );
  }
}
