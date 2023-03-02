import 'package:collection/collection.dart';

import 'sub_models/choices/choices.dart';
import 'sub_models/usage.dart';

export 'sub_models/usage.dart';
export 'sub_models/choices/choices.dart';

class OpenAIChatCompletionModel {
  /// The [id] of the chat completion.
  final String id;

  /// The date and time when the chat completion is [created].
  final DateTime created;

  /// The [choices] of the chat completion.
  final List<OpenAIChatCompletionChoiceModel> choices;

  /// The [usage] of the chat completion.
  final OpenAIChatCompletionUsageModel usage;

  @override
  int get hashCode {
    return id.hashCode ^ created.hashCode ^ choices.hashCode ^ usage.hashCode;
  }

  OpenAIChatCompletionModel({
    required this.id,
    required this.created,
    required this.choices,
    required this.usage,
  });

  factory OpenAIChatCompletionModel.fromJson(Map<String, dynamic> json) {
    return OpenAIChatCompletionModel(
      id: json['id'],
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000),
      choices: (json['choices'] as List)
          .map((e) => OpenAIChatCompletionChoiceModel.fromJson(e))
          .toList(),
      usage: OpenAIChatCompletionUsageModel.fromJson(json['usage']),
    );
  }

  @override
  String toString() {
    return 'OpenAIChatCompletionModel(id: $id, created: $created, choices: $choices, usage: $usage)';
  }

  @override
  bool operator ==(Object other) {
    const ListEquality listEquals = ListEquality();
    if (identical(this, other)) return true;

    return other is OpenAIChatCompletionModel &&
        other.id == id &&
        other.created == created &&
        listEquals.equals(other.choices, choices) &&
        other.usage == usage;
  }
}
