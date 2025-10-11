import 'package:dart_openai/src/core/models/conversation/conversation.dart';
import 'package:dart_openai/src/core/models/conversation/conversation_items_response.dart';

abstract class GetInterface {
  Future<OpenAIConversation> get({
    required String conversationId,
  });

  Future<OpenAIConversationItemsResponse> listItems({
    required String conversationId,
    int? limit,
    String? order,
    String? after,
    List<String>? include,
  });

  Future getItem({
    required String conversationId,
    required String itemId,
    List<String>? include,
  });
}
