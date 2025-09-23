import 'package:dart_openai/src/core/base/conversations/conversations.dart';
import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/models/conversation/conversation.dart';
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
      onSuccess: (Map<String, dynamic> response) {},
    );
  }
}
