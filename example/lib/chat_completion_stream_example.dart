import 'package:dart_openai/dart_openai.dart';

import 'env/env.dart';

void main() {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;

  final userMessage = OpenAIChatCompletionChoiceMessageModel(
    content: [
      OpenAIChatCompletionChoiceMessageContentItemModel.text(
        "Hello my friend!",
      ),
    ],
    role: OpenAIChatMessageRole.user,
  );

  // Creates A Stream Of Chat Completions.
  final chatStream = OpenAI.instance.chat.createStream(
    model: "gpt-3.5-turbo",
    messages: [
      userMessage,
    ],
    toolChoice: "none",
    seed: 423,
    n: 2,
  );

  // Listen to the stream.
  chatStream.listen(
    (streamChatCompletion) {
      final content = streamChatCompletion.choices.first.delta.content;
      print(content);
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
