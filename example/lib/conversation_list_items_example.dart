import 'package:dart_openai/dart_openai.dart';

/// Example demonstrating how to list items in a conversation
/// using the OpenAI Conversations API.
void main() async {
  // Set your API key
  OpenAI.apiKey = "your-api-key-here";

  try {
    // Example conversation ID (replace with actual conversation ID)
    const String conversationId = "conv_1234567890";

    // List items in the conversation with default pagination
    print("Fetching conversation items...");
    List<OpenAIConversationItem> items = await OpenAI.instance.conversations.listItems(
      conversationId: conversationId,
    );

    print("Found ${items.length} items in conversation $conversationId");
    
    // Display each item
    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      print("\n--- Item ${i + 1} ---");
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
    }

    // Example with custom pagination
    print("\n\nFetching items with custom pagination...");
    List<OpenAIConversationItem> paginatedItems = await OpenAI.instance.conversations.listItems(
      conversationId: conversationId,
      limit: 10,  // Limit to 10 items
      offset: 5,  // Skip first 5 items
    );

    print("Found ${paginatedItems.length} items (limit: 10, offset: 5)");

    // Example of handling empty conversation
    if (items.isEmpty) {
      print("No items found in this conversation.");
    }

  } catch (e) {
    print("Error listing conversation items: $e");
  }
}
