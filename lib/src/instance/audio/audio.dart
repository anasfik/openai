import 'dart:typed_data';

import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/networking/client.dart';
import 'dart:convert';
import 'dart:io';

import '../../../dart_openai.dart';
import '../../core/base/audio/audio.dart';
import '../../core/constants/strings.dart';
import '../../core/utils/logger.dart';

/// {@template openai_audio}
/// This class is responsible for handling all audio requests, such as creating a transcription or translation for a given audio file.
/// {@endtemplate}
interface class OpenAIAudio implements OpenAIAudioBase {
  static const Set<OpenAIAudioVoice> _legacySpeechVoices = {
    OpenAIAudioVoice.alloy,
    OpenAIAudioVoice.ash,
    OpenAIAudioVoice.coral,
    OpenAIAudioVoice.echo,
    OpenAIAudioVoice.fable,
    OpenAIAudioVoice.nova,
    OpenAIAudioVoice.onyx,
    OpenAIAudioVoice.sage,
    OpenAIAudioVoice.shimmer,
  };

  @override
  String get endpoint => OpenAIStrings.endpoints.audio;

  /// Per-client configuration; when null, global statics are used.
  final OpenAIClientConfig? _config;

  /// {@macro openai_audio}
  OpenAIAudio([this._config]) {
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
  /// [chunkingStrategy] The chunking strategy to use for processing the audio file. Can be "auto" or server VAD configuration.
  ///
  /// Example:
  /// ```dart
  /// final transcription = await openai.audio.createTranscription(
  ///  file: File("audio.mp3"),
  /// model: "whisper-1",
  /// prompt: "This is a prompt",
  /// responseFormat: OpenAIAudioResponseFormat.srt,
  /// temperature: 0.5,
  /// chunkingStrategy: OpenAIAudioChunkingConfig.auto(),
  /// );
  /// ```
  @override
  Future<OpenAITranscriptionGeneralModel> createTranscription({
    required File file,
    required String model,
    OpenAIAudioChunkingConfig? chunkingStrategy,
    String? language,
    String? prompt,
    OpenAIAudioResponseFormat? responseFormat,
    double? temperature,
    List<OpenAIAudioTimestampGranularity>? timestampGranularities,
    List<String>? include,
  }) async {
    return await OpenAINetworkingClient.fileUpload(
      file: file,
      to: BaseApiUrlBuilder.buildFor(_config, endpoint + "/transcriptions"),
      body: {
        "model": model,
        if (prompt != null) "prompt": prompt,
        if (responseFormat != null) "response_format": responseFormat.name,
        if (temperature != null) "temperature": temperature.toString(),
        if (language != null) "language": language,
        if (timestampGranularities != null)
          "timestamp_granularities[]":
              timestampGranularities.map((e) => e.name).join(","),
        if (chunkingStrategy != null)
          "chunking_strategy":
              chunkingStrategy.type == OpenAIAudioChunkingStrategy.auto
                  ? "auto"
                  : jsonEncode(chunkingStrategy.toMap()),
        if (include != null && include.isNotEmpty)
          "include[]": include.join(","),
      },
      onSuccess: (Map<String, dynamic> response) {
        return responseFormat == OpenAIAudioResponseFormat.verbose_json
            ? OpenAITranscriptionVerboseModel.fromMap(response)
            : OpenAITranscriptionModel.fromMap(response);
      },
      responseMapAdapter: (res) {
        return {"text": res};
      },
      config: _config,
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
  /// [chunkingStrategy] The chunking strategy to use for processing the audio file. Can be "auto" or server VAD configuration.
  ///
  /// Example:
  /// ```dart
  /// final translation = await openai.audio.createTranslation(
  /// file: File("audio.mp3"),
  /// model: "whisper-1",
  /// prompt: "This is a prompt",
  /// responseFormat: OpenAIAudioResponseFormat.text,
  /// chunkingStrategy: OpenAIAudioChunkingConfig.auto(),
  /// );
  /// ```
  @override
  Future<String> createTranslation({
    required File file,
    required String model,
    String? prompt,
    OpenAIAudioResponseFormat? responseFormat,
    double? temperature,
  }) async {
    return await OpenAINetworkingClient.fileUpload(
      file: file,
      to: BaseApiUrlBuilder.buildFor(_config, endpoint + "/translations"),
      body: {
        "model": model,
        if (prompt != null) "prompt": prompt,
        if (responseFormat != null) "response_format": responseFormat.name,
        if (temperature != null) "temperature": temperature.toString(),
      },
      onSuccess: (Map<String, dynamic> response) {
        return response["text"] as String;
      },
      responseMapAdapter: (res) {
        try {
          final decoded = jsonDecode(res);

          if (decoded is Map<String, dynamic> && decoded.containsKey('text')) {
            return decoded;
          }
        } catch (e) {}

        return {"text": res};
      },
      config: _config,
    );
  }

  @override
  Future<File> createSpeech({
    required String model,
    required String input,
    required OpenAIAudioVoice voice,
    String? instructions,
    OpenAIAudioSpeechResponseFormat? responseFormat,
    double? speed,
    String outputFileName = "output",
    Directory? outputDirectory,
  }) async {
    _validateSpeechVoiceForModel(model: model, voice: voice);

    return await OpenAINetworkingClient.postAndExpectFileResponse(
      to: BaseApiUrlBuilder.buildFor(_config, endpoint + "/speech"),
      body: {
        "model": model,
        "input": input,
        "voice": voice.name,
        if (instructions != null) "instructions": instructions,
        if (responseFormat != null) "response_format": responseFormat.name,
        if (speed != null) "speed": speed,
      },
      onFileResponse: (File res) {
        return res;
      },
      outputFileExtension: responseFormat != null
          ? responseFormat.name
          : OpenAIAudioSpeechResponseFormat.mp3.name,
      outputFileName: outputFileName,
      outputDirectory: outputDirectory,
      config: _config,
    );
  }

  @override
  Future<Uint8List> createSpeechBytes({
    required String model,
    required String input,
    required OpenAIAudioVoice voice,
    String? instructions,
    OpenAIAudioSpeechResponseFormat? responseFormat,
    double? speed,
    String outputFileName = "output",
    Directory? outputDirectory,
  }) async {
    _validateSpeechVoiceForModel(model: model, voice: voice);

    return await OpenAINetworkingClient.postAndGetBytes(
      to: BaseApiUrlBuilder.buildFor(_config, endpoint + "/speech"),
      body: {
        "model": model,
        "input": input,
        "voice": voice.name,
        if (instructions != null) "instructions": instructions,
        if (responseFormat != null) "response_format": responseFormat.name,
        if (speed != null) "speed": speed,
      },
      config: _config,
    );
  }

  static void _validateSpeechVoiceForModel({
    required String model,
    required OpenAIAudioVoice voice,
  }) {
    final normalizedModel = model.trim().toLowerCase();

    if ((normalizedModel == 'tts-1' || normalizedModel == 'tts-1-hd') &&
        !_legacySpeechVoices.contains(voice)) {
      throw ArgumentError.value(
        voice.name,
        'voice',
        '${voice.name} is not supported by $model. '
            'Use one of alloy, ash, coral, echo, fable, nova, onyx, sage, or shimmer, '
            'or switch to gpt-4o-mini-tts for newer voices such as ballad, verse, marin, or cedar.',
      );
    }
  }

  /// Lists the available voices.
  ///
  /// Returns the raw voice entries as maps, since the schema varies between
  /// providers and API versions.
  Future<List<Map<String, dynamic>>> listVoices() async {
    return await OpenAINetworkingClient.get<List<Map<String, dynamic>>>(
      from: BaseApiUrlBuilder.buildFor(_config, endpoint + "/voices"),
      onSuccess: (response) => ((response['data'] as List<dynamic>? ?? []))
          .whereType<Map<String, dynamic>>()
          .toList(),
      config: _config,
    );
  }

  /// Lists the voice consents.
  ///
  /// Returns the raw response map.
  Future<Map<String, dynamic>> listVoiceConsents() async {
    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildFor(_config, endpoint + "/voice_consents"),
      onSuccess: (response) => response,
      config: _config,
    );
  }

  /// Retrieves a single voice consent by id.
  ///
  /// [consentId] is the id of the consent to retrieve.
  ///
  /// Returns the raw response map.
  Future<Map<String, dynamic>> getVoiceConsent({
    required String consentId,
  }) async {
    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildFor(
          _config, endpoint + "/voice_consents/$consentId"),
      onSuccess: (response) => response,
      config: _config,
    );
  }

  /// Uploads a consent audio file to create a voice consent.
  ///
  /// [file] is the [File] audio recording of the consent statement.
  ///
  /// [fields] are optional extra multipart form fields.
  ///
  /// Example:
  /// ```dart
  /// final consent = await openai.audio.createVoiceConsent(
  ///   file: File("consent.wav"),
  /// );
  /// ```
  Future<Map<String, dynamic>> createVoiceConsent({
    required File file,
    Map<String, String> fields = const {},
  }) async {
    return await OpenAINetworkingClient.fileUpload(
      file: file,
      to: BaseApiUrlBuilder.buildFor(_config, endpoint + "/voice_consents"),
      body: fields,
      fileField: 'audio',
      onSuccess: (Map<String, dynamic> response) {
        return response;
      },
      config: _config,
    );
  }

  /// Deletes a voice consent by id.
  ///
  /// [consentId] is the id of the consent to delete.
  ///
  /// Returns the raw response map.
  Future<Map<String, dynamic>> deleteVoiceConsent({
    required String consentId,
  }) async {
    return await OpenAINetworkingClient.delete(
      from: BaseApiUrlBuilder.buildFor(
          _config, endpoint + "/voice_consents/$consentId"),
      onSuccess: (response) => response,
      config: _config,
    );
  }
}
