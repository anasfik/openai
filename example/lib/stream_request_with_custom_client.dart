import 'package:dart_openai/dart_openai.dart';

import 'env/env.dart';

import 'package:http/http.dart' as http;

Future<void> main() async {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;

  // Start using!
  final chatStream = OpenAI.instance.chat.createStream(
    model: "gpt-3.5-turbo",
    messages: [
      OpenAIChatCompletionChoiceMessageModel(
        content: "Hello, can you say: 'You are Anas'",
        role: OpenAIChatMessageRole.user,
      ),
    ],
    client: http.Client(),
  );
  chatStream.listen((event) {
    print(event.choices.first.delta.content);
  });
}
