import 'package:dart_openai/openai.dart';

import 'env/env.dart';

void main() async {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;

  final chatCompletion = await OpenAI.instance.chat.create(
      model: "gpt-3.5-turbo",
      messages: [
        OpenAIChatCompletionChoiceMessageModel(content: "hello", role: "user")
      ]);

  print(chatCompletion.id);
  print(chatCompletion.choices.first.message);
}
