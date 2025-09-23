class OpenAIConversation {
  final String id;
  final int createdAt;
  final Map<String, dynamic> metadata;

  OpenAIConversation({
    required this.id,
    required this.createdAt,
    required this.metadata,
  });

  factory OpenAIConversation.fromMap(Map<String, dynamic> json) =>
      OpenAIConversation(
        id: json["id"],
        createdAt: json["created_at"],
        metadata: json["metadata"] ?? {},
      );

  OpenAIConversation copyWith({
    String? id,
    int? createdAt,
    Map<String, dynamic>? metadata,
  }) =>
      OpenAIConversation(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        metadata: metadata ?? this.metadata,
      );
}
