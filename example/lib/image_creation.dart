import 'package:dart_openai/dart_openai.dart';
import 'package:example/env/env.dart';

void main() async {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;

  // Creates the Image
  final images = await OpenAI.instance.image.create(
    model: "dall-e-3",
    prompt: "image of a cat in a spaceship",
    n: 1,
    responseFormat: OpenAIImageResponseFormat.url,
    size: OpenAIImageSize.size1024,
    quality: OpenAIImageQuality.standard,
    style: OpenAIImageStyle.vivid,
  );

  final url = images.data.firstOrNull?.url;

  print(url);
}
