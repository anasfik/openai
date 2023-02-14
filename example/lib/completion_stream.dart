import 'package:dart_openai/openai.dart';

import 'env/env.dart';

void main() {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;

  // Creates A Stream Of Completions text.
  Stream<OpenAIStreamCompletionModel> stream =
      OpenAI.instance.completion.createStream(
    model: "text-davinci-003",
    prompt: 'Flutter is ',
    maxTokens: 20,
    temperature: 0.8,
  );

  // listen to the stream and print the text.
  stream.listen((event) {
    print(event.choices.first.text);
  });
}
