import 'package:dart_openai/dart_openai.dart';
import 'package:example/env/env.dart';

void main() async {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;
  final conversationId =
      "conv_68ea9ab08fa881948d6aca349f4b7792093b33304dee54b0";

  final createdConversationItems =
      await OpenAI.instance.conversations.createItems(
    conversationId: conversationId,
    items: [
      {
        "type": "message",
        "role": "user",
        "content": "Hello!",
      }
    ],
    include: ["message"],
  );

  print(createdConversationItems);

  final conversationItems = await OpenAI.instance.conversations.listItems(
    conversationId: conversationId,
  );

  print(conversationItems);

  final retrievedConversationItem = await OpenAI.instance.conversations.getItem(
    conversationId: conversationId,
    itemId: (conversationItems.data.first as Map<String, dynamic>)["id"],
  );

  print(retrievedConversationItem);

  await OpenAI.instance.conversations.deleteItem(
    conversationId: conversationId,
    itemId: (conversationItems.data.first as Map<String, dynamic>)["id"],
  );

  print("Deleted Conversation Item Successfully");
}
