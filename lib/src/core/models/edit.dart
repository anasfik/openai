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
}

class OpenAIEditModelUsage {
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;

  OpenAIEditModelUsage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory OpenAIEditModelUsage.fromJson(Map<String, dynamic> json) {
    return OpenAIEditModelUsage(
      promptTokens: json['prompt_tokens'],
      completionTokens: json['completion_tokens'],
      totalTokens: json['total_tokens'],
    );
  }
}

class OpenAIEditModelChoice {
  final String text;
  final int index;

  OpenAIEditModelChoice({
    required this.text,
    required this.index,
  });

  factory OpenAIEditModelChoice.fromJson(Map<String, dynamic> json) {
    return OpenAIEditModelChoice(
      text: json['text'],
      index: json['index'],
    );
  }
}
