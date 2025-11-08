import 'dart:convert';
import 'dart:io';

import 'package:dart_openai/dart_openai.dart';
import 'package:example/env/env.dart';

void main() async {
  OpenAI.apiKey = Env.apiKey;

  try {
    final response = await OpenAI.instance.image.edit(
      model: "gpt-image-1", // Make sure to specify the model
      image: File("eagle.png"),
      prompt: 'mask the image with color red',
      n: 1,
      //  responseFormat: OpenAIImageResponseFormat.b64Json,
    );

    if (response.data.isNotEmpty && response.data.first.b64Json != null) {
      // Decode base64 image
      final bytes = base64Decode(response.data.first.b64Json!);

      final newFile = File("new_eagle.png");
      await newFile.writeAsBytes(bytes);

      print(newFile.path);
    } else {
      return null;
    }
  } catch (e) {
    print("Error generating clear image: $e");
    return null;
  }
}
