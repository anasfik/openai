import 'dart:io';
import 'dart:typed_data';

import '../../../../dart_openai.dart';

abstract class CreateInterface {
  Future<File> createSpeech({
    required String model,
    required String input,
    required OpenAIAudioVoice voice,
    String? instructions,
    OpenAIAudioSpeechResponseFormat? responseFormat,
    double? speed,
    String outputFileName = "output",
    Directory? outputDirectory,
  });

  Future<Uint8List> createSpeechBytes({
    required String model,
    required String input,
    required OpenAIAudioVoice voice,
    String? instructions,
    OpenAIAudioSpeechResponseFormat? responseFormat,
    double? speed,
    String outputFileName = "output",
    Directory? outputDirectory,
  });

  Future<OpenAITranscriptionGeneralModel> createTranscription({
    required File file,
    required String model,
    String? prompt,
    OpenAIAudioResponseFormat? responseFormat,
    double? temperature,
    String? language,
    List<OpenAIAudioTimestampGranularity>? timestampGranularities,
    OpenAIAudioChunkingConfig? chunkingStrategy,
  });

  Future<String> createTranslation({
    required File file,
    required String model,
    String? prompt,
    OpenAIAudioResponseFormat? responseFormat,
    double? temperature,
  });
}
