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
    OpenAIConversationItemsResponse response = await OpenAI.instance.conversations.listItems(
      conversationId: conversationId,
    );

    print("Found ${response.data.length} items in conversation $conversationId");
    print("Has more items: ${response.hasMore}");
    if (response.firstId != null) print("First ID: ${response.firstId}");
    if (response.lastId != null) print("Last ID: ${response.lastId}");
    
    // Display each item
    for (int i = 0; i < response.data.length; i++) {
      final item = response.data[i];
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

    // Example with custom pagination using cursor-based pagination
    print("\n\nFetching items with custom pagination...");
    OpenAIConversationItemsResponse paginatedResponse = await OpenAI.instance.conversations.listItems(
      conversationId: conversationId,
      limit: 10,  // Limit to 10 items
      order: "desc",  // Order by creation time descending
      after: response.lastId,  // Start after the last item from previous response
    );

    print("Found ${paginatedResponse.data.length} items (limit: 10, order: desc)");
    print("Has more items: ${paginatedResponse.hasMore}");

    // Example of handling empty conversation
    if (response.data.isEmpty) {
      print("No items found in this conversation.");
    }

  } catch (e) {
    print("Error listing conversation items: $e");
  }
}
