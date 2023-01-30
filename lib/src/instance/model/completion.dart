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

class OpenAICompletionModelUsage {
  int promptTokens;
  int completionTokens;
  int totalTokens;

  OpenAICompletionModelUsage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory OpenAICompletionModelUsage.fromJson(Map<String, dynamic> json) {
    return OpenAICompletionModelUsage(
      promptTokens: json['prompt_tokens'],
      completionTokens: json['completion_tokens'],
      totalTokens: json['total_tokens'],
    );
  }
}

class OpenAICompletionModelChoice {
  String text;
  int index;
  int? logprobs;
  String? finishReason;

  OpenAICompletionModelChoice({
    required this.text,
    required this.index,
    required this.logprobs,
    required this.finishReason,
  });

  factory OpenAICompletionModelChoice.fromJson(Map<String, dynamic> json) {
    return OpenAICompletionModelChoice(
      text: json['text'],
      index: json['index'],
      logprobs: json['logprobs'],
      finishReason: json['finish_reason'],
    );
  }
}
