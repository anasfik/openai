import 'package:collection/collection.dart';

import 'sub_models/choices/choices.dart';

export 'sub_models/choices/choices.dart';
export 'sub_models/usage.dart';

class OpenAIStreamChatCompletionModel {
  /// The [id] of the chat completion.
  final String id;

  /// The date and time when the chat completion is [created].
  final DateTime created;

  /// The [choices] of the chat completion.
  final List<OpenAIStreamChatCompletionChoiceModel> choices;

  @override
  int get hashCode {
    return id.hashCode ^ created.hashCode ^ choices.hashCode;
  }

  OpenAIStreamChatCompletionModel({
    required this.id,
    required this.created,
    required this.choices,
  });

  factory OpenAIStreamChatCompletionModel.fromMap(Map<String, dynamic> json) {
    return OpenAIStreamChatCompletionModel(
      id: json['id'],
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000),
      choices: (json['choices'] as List)
          .map((e) => OpenAIStreamChatCompletionChoiceModel.fromMap(e))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'OpenAIStreamChatCompletionModel(id: $id, created: $created, choices: $choices)';
  }

  @override
  bool operator ==(Object other) {
    const ListEquality listEquals = ListEquality();
    if (identical(this, other)) return true;

    return other is OpenAIStreamChatCompletionModel &&
        other.id == id &&
        other.created == created &&
        listEquals.equals(other.choices, choices);
  }
}
