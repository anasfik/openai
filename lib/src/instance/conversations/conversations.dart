import 'package:dart_openai/src/core/base/conversations/conversations.dart';
import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/models/conversation/conversation.dart';
import 'package:dart_openai/src/core/models/conversation/conversation_item.dart';
import 'package:dart_openai/src/core/models/conversation/conversation_items_response.dart';
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
  Future<OpenAIConversationItemsResponse> listItems({
    required String conversationId,
    int? limit,
    String? order,
    String? after,
    List<String>? include,
  }) async {
    final Map<String, String> queryParams = {
      if (limit != null) 'limit': limit.toString(),
      if (order != null) 'order': order,
      if (after != null) 'after': after,
      if (include != null) 'include': include.join(","),
    };

    // Build the endpoint URL with conversation ID and items path
    final itemsEndpoint = '$endpoint';

    return await OpenAINetworkingClient.get<OpenAIConversationItemsResponse>(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: itemsEndpoint,
        id: "$conversationId/items",
        query: queryParams,
      ),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIConversationItemsResponse.fromMap(response);
      },
    );
  }

  @override
  Future<OpenAIConversationItemsResponse> createItems({
    required String conversationId,
    required List<Map<String, dynamic>> items,
    List<String>? include,
  }) async {
    return await OpenAINetworkingClient.post<OpenAIConversationItemsResponse>(
      to: BaseApiUrlBuilder.buildWithQuery(
        endpoint: endpoint,
        id: conversationId + "/items",
        query: {
          if (include != null) 'include': include.join(","),
        },
      ),
      body: {
        'items': items,
      },
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIConversationItemsResponse.fromMap(response);
      },
    );
  }

  @override
  Future<OpenAIConversationItem> getItem({
    required String conversationId,
    required String itemId,
    List<String>? include,
  }) async {
    return await OpenAINetworkingClient.get<OpenAIConversationItem>(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: endpoint,
        id: "$conversationId/items/$itemId",
        query: {
          if (include != null) 'include': include.join(","),
        },
      ),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIConversationItem.fromMap(response);
      },
    );
  }
}
