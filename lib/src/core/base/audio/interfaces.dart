import 'dart:io';

import '../../../../dart_openai.dart';

abstract class CreateInterface {
  Future<File> createSpeech({
    required String model,
    required String input,
    required String voice,
    OpenAIAudioSpeechResponseFormat? responseFormat,
    double? speed,
    String outputFileName = "output",
    Directory? outputDirectory,
  });

  Future<OpenAIAudioModel> createTranscription({
    required File file,
    required String model,
    String? prompt,
    OpenAIAudioResponseFormat? responseFormat,
    double? temperature,
    String? language,
    List<OpenAIAudioTimestampGranularity>? timestamp_granularities,
  });

  Future<OpenAIAudioModel> createTranslation({
    required File file,
    required String model,
    String? prompt,
    OpenAIAudioResponseFormat? responseFormat,
    double? temperature,
  });
}
