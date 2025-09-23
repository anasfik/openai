import 'package:dart_openai/src/core/models/conversation/conversation.dart';

abstract class GetInterface {
  Future<OpenAIConversation> get({
    required String conversationId,
  });
}
