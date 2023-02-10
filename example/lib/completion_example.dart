import 'package:dart_openai/openai.dart';
import 'package:dotenv/dotenv.dart';

Future<void> main() async {
  // Load the .env file
  DotEnv env = DotEnv()..load([".env"]);

  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = env['OPEN_AI_API_KEY']!;

  // Creates The Completion
  OpenAICompletionModel completion = await OpenAI.instance.completion.create(
    model: "text-davinci-003",
    prompt: 'Flutter is ',
    maxTokens: 100,
    temperature: 0.8,
  );

  // Prints the completion text.
  print(completion.choices.first.text);
}
