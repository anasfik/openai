import 'package:dart_openai/dart_openai.dart';
import 'package:example/env/env.dart';

Future<void> main() async {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;

  try {
    // First, create a response to get a response ID
    final createdResponse = await OpenAI.instance.responses.create(
      model: "gpt-4.1",
      input: "Hello, how are you?",
    );

    print("Created Response ID: ${createdResponse.id}");

    // Wait a bit for the response to be processed
    await Future.delayed(Duration(seconds: 3));

    // Now test the listInputItems method
    final inputItems = await OpenAI.instance.responses.listInputItems(
      responseId: createdResponse.id,
      limit: 10,
      order: "asc",
    );

    print("Input Items List:");
    print("Object: ${inputItems.object}");
    print("Has More: ${inputItems.hasMore}");
    print("First ID: ${inputItems.firstId}");
    print("Last ID: ${inputItems.lastId}");
    print("Number of items: ${inputItems.data.length}");

    // Print details of each input item
    for (int i = 0; i < inputItems.data.length; i++) {
      final item = inputItems.data[i];
      print("\nItem $i:");
      print("  ID: ${item.id}");
      print("  Role: ${item.role}");
      print("  Status: ${item.status}");
      print("  Type: ${item.type}");
      print("  Content:");
      for (int j = 0; j < item.content.length; j++) {
        final content = item.content[j];
        print("    $j: ${content.text} (${content.type})");
      }
    }

    // Clean up - delete the response
    try {
      await OpenAI.instance.responses.delete(
        responseId: createdResponse.id,
      );
      print('\nResponse deleted successfully.');
    } catch (e) {
      print('Response already deleted or cannot be deleted: $e');
    }
  } catch (e) {
    print('Error: $e');
  }
}
