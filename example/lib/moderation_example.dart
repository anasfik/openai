import 'package:dart_openai/openai.dart';
import 'package:dotenv/dotenv.dart';

Future<void> main() async {
  // Load the .env file
  DotEnv env = DotEnv()..load([".env"]);

  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = env['OPEN_AI_API_KEY']!;

  // Creates the moderation.
  OpenAIModerationModel moderation = await OpenAI.instance.moderation.create(
    input: 'I hate you, I will kill you',
  );

  // prints the result
  print(moderation.results.first.categories);
}
