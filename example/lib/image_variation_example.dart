
import 'package:dart_openai/dart_openai.dart';

import 'env/env.dart';

Future<void> main() async {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;

  // Creates the Image Variation
  final variation = await OpenAI.instance.image.create(
    prompt: "Tree with blue butterflies wings",
    n: 2,
  );

  // Prints the result.
  print(variation.data);
}
