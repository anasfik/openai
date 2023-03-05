import 'package:dart_openai/openai.dart';

import 'env/env.dart';

void main() {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;

  // Creates A Stream Of Completions text.
  final stream = OpenAI.instance.chat.createStream(
    model: "gpt-3.5-turbo",
    messages: [
      OpenAIChatCompletionChoiceMessageModel(
        content: "hello",
        role: "user",
      )
    ],
  );

  var answer = "";
  // listen to the stream and print the text.
  stream.listen(
    (event) {
      final delta = event.choices.first.delta;
      print(delta.toString());
      if (delta.content != null) {
        answer += delta.content!;
      }
    },
    onDone: () => print(answer),
  );
}
