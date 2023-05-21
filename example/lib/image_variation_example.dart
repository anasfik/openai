import 'dart:io';

import 'package:dart_openai/dart_openai.dart';

import 'env/env.dart';

Future<void> main() async {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;

  // Creates the Image Variation
  OpenAIImageVariationModel variation = await OpenAI.instance.image.variation(
    image: File("example.png"),
    n: 1,
    size: OpenAIImageSize.size256,
    responseFormat: OpenAIImageResponseFormat.b64Json,
  );

  // Prints the result.
  print(variation.data.first.url);
}
