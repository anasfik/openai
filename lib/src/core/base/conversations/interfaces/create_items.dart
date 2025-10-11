import 'package:dart_openai/src/core/models/conversation/conversation_items_response.dart';

/// {@template openai_conversations_create_items_interface}
/// Interface for creating conversation items.
/// {@endtemplate}
abstract class CreateItemsInterface {
  /// Creates new items in a conversation.
  /// 
  /// [conversationId] - The ID of the conversation.
  /// [items] - List of items to create.
  /// [include] - Optional list of fields to include in the response.
  /// 
  /// Returns an [OpenAIConversationItemsResponse] with the created items.
  Future<OpenAIConversationItemsResponse> createItems({
    required String conversationId,
    required List<Map<String, dynamic>> items,
    List<String>? include,
  });
}
