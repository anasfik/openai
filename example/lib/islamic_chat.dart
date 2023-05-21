import 'package:dart_openai/dart_openai.dart';

import 'env/env.dart';

Future<void> main() async {
  OpenAI.apiKey = Env.apiKey;
  final chatStream = OpenAI.instance.chat.createStream(
    model: "gpt-3.5-turbo",
    messages: [
      OpenAIChatCompletionChoiceMessageModel(
        role: OpenAIChatMessageRole.user,
        content: "What are the five pillars of Islam",
      ),
    ],
    temperature: .9,
  );

  chatStream.listen((event) {
    print(event);
  });
}
