class OpenAIChatCompletionChoiceMessageModel {
  final String role;
  final String content;

  OpenAIChatCompletionChoiceMessageModel({
    required this.role,
    required this.content,
  });

  factory OpenAIChatCompletionChoiceMessageModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return OpenAIChatCompletionChoiceMessageModel(
      role: json['role'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "role": role,
      "content": content,
    };
  }
}
