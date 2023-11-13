import 'dart:io';

import 'package:dart_openai/dart_openai.dart';
import 'package:example/env/env.dart';

void main() async {
  OpenAI.apiKey = Env.apiKey;

  OpenAIImageModel imageEdits = await OpenAI.instance.image.edit(
    prompt: 'mask the image with color red',
    image: File("IMAGE PATH HERE"),
    mask: File("MASK PATH HERE"),
    n: 1,
    size: OpenAIImageSize.size1024,
    responseFormat: OpenAIImageResponseFormat.b64Json,
  );

  for (int index = 0; index < imageEdits.data.length; index++) {
    final currentItem = imageEdits.data[index];
    print(currentItem.b64Json);
  }
}
