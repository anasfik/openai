import 'dart:async';
import 'dart:io';

import 'package:dart_openai/dart_openai.dart';

import 'env/env.dart';

Future<void> main() async {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;

  // Creates the Image Variation
  final imageVariations = await OpenAI.instance.image.variation(
    model: "dall-e-2",
    image: File("dart.png"),
    n: 4,
    size: OpenAIImageSize.size512,
    responseFormat: OpenAIImageResponseFormat.url,
  );

  for (var index = 0; index < imageVariations.data.length; index++) {
    final currentItem = imageVariations.data[index];
    print(currentItem.url);
  }
}
