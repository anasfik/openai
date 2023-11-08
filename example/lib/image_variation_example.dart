import 'dart:io';

import 'package:dart_openai/dart_openai.dart';

import 'env/env.dart';

Future<void> main() async {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;

  // Creates the Image Variation
  final variation = await OpenAI.instance.image.variation(
    model: "dall-e-2",
    image: File("dart.png"),
    n: 4,
  );

  // Prints the result.
  print(variation.data);
}
