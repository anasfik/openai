import 'package:dart_openai/src/core/models/conversation/conversation.dart';
import 'package:dart_openai/src/core/models/conversation/conversation_items_response.dart';

abstract class CreateInterface {
  Future<OpenAIConversation> create({
    List? items,
    Map<String, dynamic>? metadata,
  });

  Future<OpenAIConversationItemsResponse> createItems({
    required String conversationId,
    required List<Map<String, dynamic>> items,
    List<String>? include,
  });
}
