import 'package:dart_openai/src/core/models/conversation/conversation_item.dart';

/// {@template openai_conversation_items_response}
/// A model representing the response from the conversations list-items API.
/// {@endtemplate}
class OpenAIConversationItemsResponse {
  /// The list of conversation items.
  final List<OpenAIConversationItem> data;

  /// Whether there are more items available.
  final bool hasMore;

  /// The ID of the first item in the response.
  final String? firstId;

  /// The ID of the last item in the response.
  final String? lastId;

  /// {@macro openai_conversation_items_response}
  const OpenAIConversationItemsResponse({
    required this.data,
    required this.hasMore,
    this.firstId,
    this.lastId,
  });

  /// Creates a new [OpenAIConversationItemsResponse] from a JSON map.
  factory OpenAIConversationItemsResponse.fromMap(Map<String, dynamic> json) {
    final Object? data = json['data'];
    final List<Map<String, dynamic>> itemsData = data is List
        ? data.cast<Map<String, dynamic>>()
        : <Map<String, dynamic>>[];
    
    return OpenAIConversationItemsResponse(
      data: itemsData
          .map((Map<String, dynamic> item) => OpenAIConversationItem.fromMap(item))
          .toList(),
      hasMore: json['has_more'] as bool? ?? false,
      firstId: json['first_id'] as String?,
      lastId: json['last_id'] as String?,
    );
  }

  /// Converts this [OpenAIConversationItemsResponse] to a JSON map.
  Map<String, dynamic> toMap() {
    return {
      'data': data.map((item) => item.toMap()).toList(),
      'has_more': hasMore,
      if (firstId != null) 'first_id': firstId,
      if (lastId != null) 'last_id': lastId,
    };
  }

  /// Creates a copy of this [OpenAIConversationItemsResponse] with the given fields replaced.
  OpenAIConversationItemsResponse copyWith({
    List<OpenAIConversationItem>? data,
    bool? hasMore,
    String? firstId,
    String? lastId,
  }) {
    return OpenAIConversationItemsResponse(
      data: data ?? this.data,
      hasMore: hasMore ?? this.hasMore,
      firstId: firstId ?? this.firstId,
      lastId: lastId ?? this.lastId,
    );
  }

  @override
  String toString() {
    return 'OpenAIConversationItemsResponse(data: ${data.length} items, hasMore: $hasMore, firstId: $firstId, lastId: $lastId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OpenAIConversationItemsResponse &&
        other.data.length == data.length &&
        other.hasMore == hasMore &&
        other.firstId == firstId &&
        other.lastId == lastId;
  }

  @override
  int get hashCode {
    return data.hashCode ^
        hasMore.hashCode ^
        firstId.hashCode ^
        lastId.hashCode;
  }
}
