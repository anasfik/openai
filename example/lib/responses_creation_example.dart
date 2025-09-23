import 'package:dart_openai/dart_openai.dart';
import 'package:example/env/env.dart';

Future<void> main() async {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;

  final createdResponse = await OpenAI.instance.responses.create(
    model: "gpt-4.1",
    input: "Hello, how are you?",
  );

  // Created response
  print("Created Response: $createdResponse");

  await Future.delayed(Duration(seconds: 3));

  final gotResponse = await OpenAI.instance.responses.get(
    responseId: createdResponse.id,
  );

  // Got response
  print("Got Response: $gotResponse");

  await Future.delayed(Duration(seconds: 3));

  // Deleted response

  try {
    await OpenAI.instance.responses.delete(
      responseId: createdResponse.id,
    );

    print('Response deleted successfully.');
  } catch (e) {
    print('Response already deleted or cannot be deleted: $e');
  }
}
