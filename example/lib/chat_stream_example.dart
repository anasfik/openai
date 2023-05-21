import 'package:dart_openai/dart_openai.dart';

import 'env/env.dart';

void main() async {
  OpenAI.apiKey = Env.apiKey;

  final chatStream = OpenAI.instance.chat.createStream(
    model: "gpt-3.5-turbo",
    messages: [
      OpenAIChatCompletionChoiceMessageModel(
        content: "Hello, can you say: 'You are Anas'",
        role: OpenAIChatMessageRole.user,
      ),
      OpenAIChatCompletionChoiceMessageModel(
        content: "You are Anas",
        role: OpenAIChatMessageRole.assistant,
      ),
      OpenAIChatCompletionChoiceMessageModel(
        content:
            "Now I want you to repeat it, but change the word 'Anas' to 'Mohamed'",
        role: OpenAIChatMessageRole.user,
      ),
    ],
  );

  chatStream.listen((event) {
    print(event.choices.first.delta.content);
  });
}
