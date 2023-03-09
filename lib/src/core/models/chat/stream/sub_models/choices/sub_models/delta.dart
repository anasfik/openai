class OpenAIStreamChatCompletionChoiceDeltaModel {
  final String? role;
  final String? content;

  @override
  int get hashCode {
    return role.hashCode ^ content.hashCode;
  }

  OpenAIStreamChatCompletionChoiceDeltaModel({
    required this.role,
    required this.content,
  });

  factory OpenAIStreamChatCompletionChoiceDeltaModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return OpenAIStreamChatCompletionChoiceDeltaModel(
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

  @override
  String toString() {
    return 'OpenAIStreamChatCompletionChoiceMessageModel(role: $role, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OpenAIStreamChatCompletionChoiceDeltaModel &&
        other.role == role &&
        other.content == content;
  }
}
