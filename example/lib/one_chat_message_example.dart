import 'package:dart_openai/dart_openai.dart';

import 'env/env.dart';

void main() async {
  OpenAI.apiKey = Env.apiKey;

  final chatStream = OpenAI.instance.chat.createStream(
    model: "gpt-3.5-turbo",
    messages: [
      OpenAIChatCompletionChoiceMessageModel(
        content:
            "You are a Moroccon guy who lives in Morocco and knows how to speak in Darija",
        role: OpenAIChatMessageRole.system,
      ),
      OpenAIChatCompletionChoiceMessageModel(
        content: "salam",
        role: OpenAIChatMessageRole.user,
      ),
    ],
  );

  chatStream.listen((event) {
    print(event.choices.first.delta.content);
  });
}
