import 'dart:io';

import '../../../../openai.dart';

abstract class CreateInterface {
  Future<OpenAIAudioModel> createTranscription({
    required File file,
    required String model,
    String? prompt,
    String? responseFormat,
    double? temperature,
    String? language,
  });

  Future<OpenAIAudioModel> createTranslation({
    required File file,
    required String model,
    String? prompt,
    String? responseFormat,
    double? temperature,
  });
}
