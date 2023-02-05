import 'package:collection/collection.dart';
import 'sub_models/choice.dart';
import 'sub_models/usage.dart';

export 'sub_models/choice.dart';
export 'sub_models/usage.dart';

class OpenAIEditModel {
  
  final DateTime created;
  final List<OpenAIEditModelChoice> choices;
  final OpenAIEditModelUsage usage;

  OpenAIEditModel({
    required this.created,
    required this.choices,
    required this.usage,
  });

  factory OpenAIEditModel.fromJson(Map<String, dynamic> json) {
    return OpenAIEditModel(
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000),
      choices: (json['choices'] as List<dynamic>)
          .map((e) => OpenAIEditModelChoice.fromJson(e))
          .toList(),
      usage: OpenAIEditModelUsage.fromJson(json['usage']),
    );
  }

  @override
  String toString() =>
      'OpenAIEditModel(created: $created, choices: $choices, usage: $usage)';

  @override
  bool operator ==(covariant OpenAIEditModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.created == created &&
        listEquals(other.choices, choices) &&
        other.usage == usage;
  }

  @override
  int get hashCode => created.hashCode ^ choices.hashCode ^ usage.hashCode;
}
