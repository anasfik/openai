import 'package:dart_openai/src/core/base/conversations/conversations.dart';
import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/models/conversation/conversation.dart';
import 'package:dart_openai/src/core/models/conversation/conversation_item.dart';
import 'package:dart_openai/src/core/networking/client.dart';
import 'package:dart_openai/src/core/utils/logger.dart';
import 'package:meta/meta.dart';

@immutable
@protected
class OpenAIConversations extends OpenAIConversationsBase {
  @override
  String get endpoint => OpenAIStrings.endpoints.conversations;

  /// {@macro openai_converdsations}
  OpenAIConversations() {
    OpenAILogger.logEndpoint(endpoint);
  }

  @override
  Future<OpenAIConversation> create({
    List? items,
    Map<String, dynamic>? metadata,
  }) async {
    return await OpenAINetworkingClient.post<OpenAIConversation>(
      to: BaseApiUrlBuilder.build(endpoint),
      body: {
        if (items != null) 'items': items,
        if (metadata != null) 'metadata': metadata,
      },
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIConversation.fromMap(response);
      },
    );
  }

  @override
  Future<OpenAIConversation> get({
    required String conversationId,
  }) async {
    return await OpenAINetworkingClient.get<OpenAIConversation>(
      from: BaseApiUrlBuilder.build(endpoint, conversationId),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIConversation.fromMap(response);
      },
    );
  }

  @override
  Future<OpenAIConversation> update({
    required String conversationId,
    required Map<String, dynamic> metadata,
  }) async {
    return await OpenAINetworkingClient.post<OpenAIConversation>(
      to: BaseApiUrlBuilder.build(endpoint, conversationId),
      body: {
        'metadata': metadata,
      },
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIConversation.fromMap(response);
      },
    );
  }

  @override
  Future<void> delete({
    required String conversationId,
  }) async {
    await OpenAINetworkingClient.delete(
      from: BaseApiUrlBuilder.build(endpoint, conversationId),
      onSuccess: (Map<String, dynamic> response) {
        final deleted = response["deleted"];

        return deleted is bool && deleted;
      },
    );
  }

  @override
  Future<List<OpenAIConversationItem>> listItems({
    required String conversationId,
    int? limit,
    int? offset,
  }) async {
    // Build query parameters
    final Map<String, String> queryParams = {};
    if (limit != null) {
      queryParams['limit'] = limit.toString();
    }
    if (offset != null) {
      queryParams['offset'] = offset.toString();
    }

    // Build the endpoint URL with conversation ID and items path
    final itemsEndpoint = '$endpoint/$conversationId/items';
    
    return await OpenAINetworkingClient.get<List<OpenAIConversationItem>>(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: itemsEndpoint,
        query: queryParams,
      ),
      onSuccess: (Map<String, dynamic> response) {
        final Object? data = response['data'];
        if (data is! List) {
          return <OpenAIConversationItem>[];
        }
        final List<Object?> itemsData = data;
        return itemsData
            .whereType<Map<String, Object?>>()
            .map<OpenAIConversationItem>((Map<String, Object?> item) => 
                OpenAIConversationItem.fromMap(Map<String, dynamic>.from(item)))
            .toList();
      },
    );
  }
}
