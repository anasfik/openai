class OpenAIConversation {
  final String id;
  final DateTime createdAt;
  final Map<String, dynamic> metadata;

  OpenAIConversation({
    required this.id,
    required this.createdAt,
    required this.metadata,
  });

  factory OpenAIConversation.fromMap(Map<String, dynamic> json) =>
      OpenAIConversation(
        id: json["id"],
        createdAt:
            DateTime.fromMillisecondsSinceEpoch(json["created_at"] * 1000),
        metadata: json["metadata"] ?? {},
      );

  OpenAIConversation copyWith({
    String? id,
    DateTime? createdAt,
    Map<String, dynamic>? metadata,
  }) =>
      OpenAIConversation(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        metadata: metadata ?? this.metadata,
      );
}
