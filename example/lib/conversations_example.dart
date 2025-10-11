import 'package:dart_openai/dart_openai.dart';
import 'package:example/env/env.dart';

void main() async {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;

  final createdConversation = await OpenAI.instance.conversations.create(
    metadata: {"userRef": "123"},
    items: [
      {
        "type": "message",
        "role": "user",
        "content": "Hello!",
      }
    ],
  );

  // Created Conversation
  print("Created Conversation: $createdConversation");

  final gotConversation = await OpenAI.instance.conversations.get(
    conversationId: createdConversation.id,
  );

  // Got Conversation
  print("Got Conversation: $gotConversation");

  final updatedConversation = await OpenAI.instance.conversations.update(
    conversationId: createdConversation.id,
    metadata: {"userRef": "456"},
  );

  // Updated Conversation
  print("Updated Conversation: $updatedConversation");

  await Future.delayed(Duration(seconds: 3));

  try {
    await OpenAI.instance.conversations.delete(
      conversationId: createdConversation.id,
    );

    // Deleted Conversation
    print("Deleted Conversation Successfully");
  } catch (e) {
    print("Error deleting conversation: $e");
  }
}
