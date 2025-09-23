import 'package:dart_openai/src/core/models/conversation/conversation.dart';

abstract class UpdateInterface {
  Future<OpenAIConversation> update({
    required String conversationId,
    required Map<String, dynamic> metadata,
  });
}
