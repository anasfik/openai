import 'package:dart_openai/dart_openai.dart';
import 'package:example/env/env.dart';

void main() async {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;

  final response = await OpenAI.instance.responses.create(
    model: "gpt-4.1",
    input: [
      {
        "id": "msg_abc123",
        "type": "message",
        "role": "user",
        "content": [
          {
            "type": "input_text",
            "text": "Tell me a three sentence bedtime story about a unicorn."
          }
        ]
      }
    ],
  );

  final inputItems = await OpenAI.instance.responses.listInputItems(
    responseId: response.id,
  );

  print(inputItems);
}
