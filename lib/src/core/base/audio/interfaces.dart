import 'dart:typed_data';

import '../../../../dart_openai.dart';

abstract class CreateInterface {
  /// Creates speech audio. Returns the raw bytes; on native platforms, when
  /// [outputDirectory] and [outputFileName] are provided, the bytes are also
  /// written to disk.
  Future<Uint8List> createSpeech({
    required String model,
    required String input,
    required OpenAIAudioVoice voice,
    String? instructions,
    OpenAIAudioSpeechResponseFormat? responseFormat,
    double? speed,
    String outputFileName = 'output',
    String? outputDirectory,
  });

  /// Creates speech audio and returns the raw bytes. Identical to
  /// [createSpeech] without disk side effects; the web-friendly path.
  Future<Uint8List> createSpeechBytes({
    required String model,
    required String input,
    required OpenAIAudioVoice voice,
    String? instructions,
    OpenAIAudioSpeechResponseFormat? responseFormat,
    double? speed,
  });
  Future<OpenAITranscriptionGeneralModel> createTranscription({
    required OpenAIFile file,
    required String model,
    String? prompt,
    OpenAIAudioResponseFormat? responseFormat,
    double? temperature,
    String? language,
    List<OpenAIAudioTimestampGranularity>? timestampGranularities,
    OpenAIAudioChunkingConfig? chunkingStrategy,
  });

  Future<String> createTranslation({
    required OpenAIFile file,
    required String model,
    String? prompt,
    OpenAIAudioResponseFormat? responseFormat,
    double? temperature,
  });
}
