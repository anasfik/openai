/// {@template openai_conversation_item}
/// A model representing a conversation item from the OpenAI API.
/// {@endtemplate}
class OpenAIConversationItem {
  /// Constant for converting seconds to milliseconds
  static const int _secondsToMilliseconds = 1000;
  /// The unique identifier for the conversation item.
  final String id;

  /// The type of the conversation item.
  final String type;

  /// The content of the conversation item.
  final String content;

  /// The timestamp when the item was created.
  final DateTime createdAt;

  /// The timestamp when the item was last updated.
  final DateTime? updatedAt;

  /// Additional metadata for the conversation item.
  final Map<String, dynamic> metadata;

  /// {@macro openai_conversation_item}
  const OpenAIConversationItem({
    required this.id,
    required this.type,
    required this.content,
    required this.createdAt,
    this.updatedAt,
    this.metadata = const {},
  });

  /// Creates a new [OpenAIConversationItem] from a JSON map.
  factory OpenAIConversationItem.fromMap(Map<String, dynamic> json) {
    return OpenAIConversationItem(
      id: json['id'] as String,
      type: json['type'] as String,
      content: json['content'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        (json['created_at'] as num).toInt() * _secondsToMilliseconds,
      ),
      updatedAt: json['updated_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              (json['updated_at'] as num).toInt() * _secondsToMilliseconds,
            )
          : null,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
    );
  }

  /// Converts this [OpenAIConversationItem] to a JSON map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'content': content,
      'created_at': createdAt.millisecondsSinceEpoch ~/ _secondsToMilliseconds,
      if (updatedAt != null)
        'updated_at': updatedAt!.millisecondsSinceEpoch ~/ _secondsToMilliseconds,
      'metadata': metadata,
    };
  }

  /// Creates a copy of this [OpenAIConversationItem] with the given fields replaced.
  OpenAIConversationItem copyWith({
    String? id,
    String? type,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? metadata,
  }) {
    return OpenAIConversationItem(
      id: id ?? this.id,
      type: type ?? this.type,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  String toString() {
    return 'OpenAIConversationItem(id: $id, type: $type, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OpenAIConversationItem &&
        other.id == id &&
        other.type == type &&
        other.content == content &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.metadata.toString() == metadata.toString();
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        content.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        metadata.hashCode;
  }
}
