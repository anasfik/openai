import 'package:dart_openai/openai.dart';

import 'env/env.dart';

void main() {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;

  // Creates A Stream Of Chat Completions.
  final chatStream = OpenAI.instance.chat.createStream(
    model: "gpt-3.5-turbo",
    messages: [
      OpenAIChatCompletionChoiceMessageModel(
        content: "hello, what is Flutter and Dart ?",
        role: "user",
      )
    ],
  );

  chatStream.listen(
    (streamChatCompletion) {
      final delta = streamChatCompletion.choices.first.delta.content;
      print(delta);
    },
    onError: (error) {
      print(error);
    },
    cancelOnError: false,
    onDone: () {
      print("Done");
    },
  );
}
