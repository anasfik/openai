import 'package:dart_openai/openai.dart';
import 'package:dotenv/dotenv.dart';

void main() {
  // Load the .env file
  DotEnv env = DotEnv()..load([".env"]);

  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = env['OPEN_AI_API_KEY']!;

  // Creates A Stream Of Completions text.
  Stream<OpenAIStreamCompletionModel> stream =
      OpenAI.instance.completion.createStream(
    model: "text-davinci-003",
    prompt: 'Flutter is ',
    maxTokens: 20,
    temperature: 0.8,
  );

  stream.listen((event) {
    print(event.choices.first.text);
  });
}
