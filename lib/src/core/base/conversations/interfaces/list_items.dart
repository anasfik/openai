import 'package:dart_openai/src/core/models/conversation/conversation_items_response.dart';

/// {@template openai_conversations_list_items_interface}
/// Interface for listing conversation items.
/// {@endtemplate}
abstract class ListItemsInterface {
  /// Lists items in a conversation with optional pagination.
  /// 
  /// [conversationId] - The ID of the conversation to list items for.
  /// [limit] - The maximum number of items to return (default: 20, max: 100).
  /// [order] - The order to sort items by (asc or desc, default: desc).
  /// [after] - The ID of the item to start after for pagination.
  /// [before] - The ID of the item to end before for pagination.
  /// 
  /// Returns an [OpenAIConversationItemsResponse] with pagination metadata.
  Future<OpenAIConversationItemsResponse> listItems({
    required String conversationId,
    int? limit,
    String? order,
    String? after,
    String? before,
  });
}
