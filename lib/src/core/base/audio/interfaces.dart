import 'dart:io';

import '../../../../dart_openai.dart';

abstract class CreateInterface {
  Future<OpenAIAudioModel> createTranscription({
    required File file,
    required String model,
    String? prompt,
    OpenAIAudioResponseFormat? responseFormat,
    double? temperature,
    String? language,
  });

  Future<OpenAIAudioModel> createTranslation({
    required File file,
    required String model,
    String? prompt,
    OpenAIAudioResponseFormat? responseFormat,
    double? temperature,
  });
}
