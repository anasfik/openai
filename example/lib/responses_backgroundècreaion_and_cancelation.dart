import 'package:dart_openai/dart_openai.dart';
import 'package:example/env/env.dart';

Future<void> main() async {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;

  final createdResponse = await OpenAI.instance.responses.create(
    model: "gpt-4.1",
    // this got really fast, had to ask it to take longer so I can test cancellation, otherwise it completes before trying to cancel.
    input:
        "I want you to think about 1000 name of latest popular artists and players of footbal!, take your time to think, take minimum 10 seconds before responding",
    // To test cancellation.
    background: true,
  );

  // Created response
  print("response status: ${createdResponse.status}");

  await OpenAI.instance.responses.cancel(
    responseId: createdResponse.id,
  );

  print("cancelled");
}
