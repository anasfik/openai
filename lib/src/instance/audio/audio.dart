import 'dart:typed_data';

import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/networking/client.dart';

import 'dart:io';

import '../../../dart_openai.dart';
import '../../core/base/audio/audio.dart';
import '../../core/constants/strings.dart';
import '../../core/utils/logger.dart';

/// {@template openai_audio}
/// This class is responsible for handling all audio requests, such as creating a transcription or translation for a given audio file.
/// {@endtemplate}
interface class OpenAIAudio implements OpenAIAudioBase {
  @override
  String get endpoint => OpenAIStrings.endpoints.audio;

  /// {@macro openai_audio}
  OpenAIAudio() {
    OpenAILogger.logEndpoint(endpoint);
  }

  /// Creates a transcription for a given audio file.
  ///
  /// [file] is the [File] audio which is the audio file to be transcribed.
  ///
  /// [model] is the model which to use for the transcription.
  ///
  /// [prompt] is an optional text to guide the model's style or continue a previous audio segment. The prompt should be in English.
  ///
  /// [responseFormat] is an optional format for the transcription. The default is [OpenAIAudioResponseFormat.json].
  ///
  /// [temperature] is the sampling temperature for the request.
  ///
  /// [language] is the language of the input audio. Supplying the input language in **ISO-639-1** format will improve accuracy and latency.
  ///
  /// [timestamp_granularities] The timestamp granularities to populate for this transcription. response_format must be set verbose_json to use timestamp granularities. Either: word or segment, both doesnt work.
  ///
  /// Example:
  /// ```dart
  /// final transcription = await openai.audio.createTranscription(
  ///  file: File("audio.mp3"),
  /// model: "whisper-1",
  /// prompt: "This is a prompt",
  /// responseFormat: OpenAIAudioResponseFormat.srt,
  /// temperature: 0.5,
  /// );
  /// ```
  @override
  Future<OpenAIAudioModel> createTranscription({
    required File file,
    required String model,
    String? prompt,
    OpenAIAudioResponseFormat? responseFormat,
    double? temperature,
    String? language,
    List<OpenAIAudioTimestampGranularity>? timestamp_granularities,
  }) async {
    return await OpenAINetworkingClient.fileUpload(
      file: file,
      to: BaseApiUrlBuilder.build(endpoint + "/transcriptions"),
      body: {
        "model": model,
        if (prompt != null) "prompt": prompt,
        if (responseFormat != null) "response_format": responseFormat.name,
        if (temperature != null) "temperature": temperature.toString(),
        if (language != null) "language": language,
        if (timestamp_granularities != null)
          "timestamp_granularities[]":
              timestamp_granularities.map((e) => e.name).join(","),
      },
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIAudioModel.fromMap(response);
      },
      responseMapAdapter: (res) {
        return {"text": res};
      },
    );
  }

  /// Creates a translation for a given audio file.
  ///
  /// [file] is the [File] audio which is the audio file to be transcribed.
  ///
  /// [model] is the model which to use for the transcription.
  ///
  /// [prompt] is an optional text to guide the model's style or continue a previous audio segment. The prompt should be in English.
  ///
  /// [responseFormat] is an optional format for the transcription. The default is [OpenAIAudioResponseFormat.json].
  ///
  /// [temperature] is the sampling temperature for the request.
  ///
  /// Example:
  /// ```dart
  /// final translation = await openai.audio.createTranslation(
  /// file: File("audio.mp3"),
  /// model: "whisper-1",
  /// prompt: "This is a prompt",
  /// responseFormat: OpenAIAudioResponseFormat.text,
  /// );
  /// ```
  @override
  Future<OpenAIAudioModel> createTranslation({
    required File file,
    required String model,
    String? prompt,
    OpenAIAudioResponseFormat? responseFormat,
    double? temperature,
  }) async {
    return await OpenAINetworkingClient.fileUpload(
      file: file,
      to: BaseApiUrlBuilder.build(endpoint + "/translations"),
      body: {
        "model": model,
        if (prompt != null) "prompt": prompt,
        if (responseFormat != null) "response_format": responseFormat.name,
        if (temperature != null) "temperature": temperature.toString(),
      },
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIAudioModel.fromMap(response);
      },
      responseMapAdapter: (res) {
        return {"text": res};
      },
    );
  }

  @override
  Future<File> createSpeech({
    required String model,
    required String input,
    required String voice,
    OpenAIAudioSpeechResponseFormat? responseFormat,
    double? speed,
    String outputFileName = "output",
    Directory? outputDirectory,
  }) async {
    return await OpenAINetworkingClient.postAndExpectFileResponse(
      to: BaseApiUrlBuilder.build(endpoint + "/speech"),
      body: {
        "model": model,
        "input": input,
        "voice": voice,
        if (responseFormat != null) "response_format": responseFormat.name,
        if (speed != null) "speed": speed,
      },
      onFileResponse: (File res) {
        return res;
      },
      outputFileName: outputFileName,
      outputDirectory: outputDirectory,
    );
  }

  @override
  Future<Uint8List> createSpeechBytes({
    required String model,
    required String input,
    required String voice,
    OpenAIAudioSpeechResponseFormat? responseFormat,
    double? speed,
  }) async {
    return await OpenAINetworkingClient.postAndGetBytes(
      to: BaseApiUrlBuilder.build(endpoint + "/speech"),
      body: {
        "model": model,
        "input": input,
        "voice": voice,
        if (responseFormat != null) "response_format": responseFormat.name,
        if (speed != null) "speed": speed,
      },
    );
  }
}
