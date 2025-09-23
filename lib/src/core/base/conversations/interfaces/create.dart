import 'package:dart_openai/src/core/models/conversation/conversation.dart';

abstract class CreateInterface {
  Future<OpenAIConversation> create({
    List? items,
    Map<String, dynamic>? metadata,
  });
}
