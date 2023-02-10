import 'dart:io';

import 'package:dart_openai/openai.dart';
import 'package:dotenv/dotenv.dart';

Future<void> main() async {
  // Load the .env file
  DotEnv env = DotEnv()..load([".env"]);

  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = env['OPEN_AI_API_KEY']!;

  // Creates the Image Variation
  OpenAIImageVariationModel variation = await OpenAI.instance.image.variation(
    image: File("example.png"),
    n: 1,
    size: OpenAIImageSize.size256,
    responseFormat: OpenAIResponseFormat.b64Json,
  );

  // Prints the result.
  print(variation.data.first.url);
}
