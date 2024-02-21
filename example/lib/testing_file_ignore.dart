import 'package:dart_openai/dart_openai.dart';

void main() async {
  Stream<OpenAIStreamCompletionModel> completionStream =
      OpenAI.instance.completion.createStream(
    model: "text-davinci-003",
    prompt: "Github is ",
    maxTokens: 100,
    temperature: 0.5,
    topP: 1,
    seed: 42,
    stop: '###',
    n: 2,
  );

  completionStream.listen((event) {
    final firstCompletionChoice = event.choices.first;
    print(firstCompletionChoice.index); // ...
    print(firstCompletionChoice.text); // ...
  });
}
