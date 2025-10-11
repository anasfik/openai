import 'package:dart_openai/src/core/models/conversation/conversation_item.dart';

/// {@template openai_conversations_get_item_interface}
/// Interface for getting a specific conversation item.
/// {@endtemplate}
abstract class GetItemInterface {
  /// Gets a specific conversation item by its ID.
  /// 
  /// [conversationId] - The ID of the conversation.
  /// [itemId] - The ID of the item to retrieve.
  /// [include] - Optional list of fields to include in the response.
  /// 
  /// Returns an [OpenAIConversationItem] object.
  Future<OpenAIConversationItem> getItem({
    required String conversationId,
    required String itemId,
    List<String>? include,
  });
}
