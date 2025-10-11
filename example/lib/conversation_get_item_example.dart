import 'package:dart_openai/dart_openai.dart';

/// Example demonstrating how to get a specific conversation item
/// using the OpenAI Conversations API.
void main() async {
  // Set your API key
  OpenAI.apiKey = "your-api-key-here";

  try {
    // Example conversation ID and item ID (replace with actual IDs)
    const String conversationId = "conv_1234567890";
    const String itemId = "item_1234567890";

    // Get a specific conversation item
    print("Fetching conversation item...");
    OpenAIConversationItem item = await OpenAI.instance.conversations.getItem(
      conversationId: conversationId,
      itemId: itemId,
    );

    print("Found conversation item:");
    print("ID: ${item.id}");
    print("Type: ${item.type}");
    print("Content: ${item.content}");
    print("Created: ${item.createdAt}");
    if (item.updatedAt != null) {
      print("Updated: ${item.updatedAt}");
    }
    if (item.metadata.isNotEmpty) {
      print("Metadata: ${item.metadata}");
    }

    // Example with include parameter to specify which fields to return
    print("\n\nFetching conversation item with specific fields...");
    OpenAIConversationItem itemWithFields = await OpenAI.instance.conversations.getItem(
      conversationId: conversationId,
      itemId: itemId,
      include: ["id", "content", "created_at"], // Only include these fields
    );

    print("Item with specific fields:");
    print("ID: ${itemWithFields.id}");
    print("Content: ${itemWithFields.content}");
    print("Created: ${itemWithFields.createdAt}");

  } catch (e) {
    print("Error getting conversation item: $e");
  }
}
