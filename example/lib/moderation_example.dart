import 'package:dart_openai/dart_openai.dart';

import 'env/env.dart';

Future<void> main() async {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;

  // Creates the moderation.
  OpenAIModerationModel moderation = await OpenAI.instance.moderation.create(
    input: 'I hate you, I will kill you',
  );

  // prints the result
  print(moderation.results.first.categories);
}
