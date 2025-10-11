import 'package:dart_openai/src/core/models/conversation/conversation_item.dart';

/// {@template openai_conversations_list_items_interface}
/// Interface for listing conversation items.
/// {@endtemplate}
abstract class ListItemsInterface {
  /// Lists items in a conversation with optional pagination.
  /// 
  /// [conversationId] - The ID of the conversation to list items for.
  /// [limit] - The maximum number of items to return (default: 20, max: 100).
  /// [offset] - The number of items to skip for pagination (default: 0).
  /// 
  /// Returns a list of [OpenAIConversationItem] objects.
  Future<List<OpenAIConversationItem>> listItems({
    required String conversationId,
    int? limit,
    int? offset,
  });
}
