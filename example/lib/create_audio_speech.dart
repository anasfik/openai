import 'dart:io';

import 'package:dart_openai/dart_openai.dart';
import 'package:example/env/env.dart';

void main() async {
  OpenAI.apiKey = Env.apiKey;

  // The speech request.
  File speechFile = await OpenAI.instance.audio.createSpeech(
    model: "tts-1",
    input: "Say my name is ",
    voice: "nova",
    responseFormat: OpenAIAudioSpeechResponseFormat.mp3,
    outputDirectory: await Directory("speechOutput").create(),
    outputFileName: DateTime.now().microsecondsSinceEpoch.toString(),
  );

  // The file result.
  print(speechFile.path);
}
