import 'dart:io';

import 'package:dart_openai/dart_openai.dart';
import 'package:example/env/env.dart';

void main() async {
  OpenAI.apiKey = Env.apiKey;

  final outputDir = Directory('speechOutput');

  final exists = await outputDir.exists();

  final input = "I should've been strong";
  final model = "tts-1";
  final voice = OpenAIAudioVoice.fable;

  final fileName = [
    model,
    DateTime.now().millisecond.toString(),
  ].join('_');

  // The speech request.
  File speechFile = await OpenAI.instance.audio.createSpeech(
    model: model,
    input: input,
    voice: voice,
    responseFormat: OpenAIAudioSpeechResponseFormat.mp3,
    outputDirectory: exists ? outputDir : await outputDir.create(),
    outputFileName: fileName,
  );

  // The file result.
  print(speechFile.path);
}
