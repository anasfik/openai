import 'sub_models/choice.dart';
import 'sub_models/usage.dart';

class OpenAICompletionModel {
  String id;
  DateTime created;
  String model;
  List<OpenAICompletionModelChoice> choices;
  OpenAICompletionModelUsage usage;

  OpenAICompletionModel({
    required this.id,
    required this.created,
    required this.model,
    required this.choices,
    required this.usage,
  });

  factory OpenAICompletionModel.fromJson(Map<String, dynamic> json) {
    return OpenAICompletionModel(
      id: json['id'],
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000),
      model: json['model'],
      choices: (json['choices'] as List<dynamic>)
          .map((i) => OpenAICompletionModelChoice.fromJson(i))
          .toList(),
      usage: OpenAICompletionModelUsage.fromJson(json['usage']),
    );
  }
}
