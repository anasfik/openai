import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/config/client_config.dart';
import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/models/realtime/models.dart';
import 'package:dart_openai/src/core/networking/client.dart';

/// The REST part of the Realtime API: session creation and ephemeral client
/// secrets. WebSocket connections are out of scope here.
class OpenAIRealtime {
  final OpenAIClientConfig? _config;

  OpenAIRealtime([this._config]);

  String get _endpoint => OpenAIStrings.endpoints.realtime;

  /// Creates a realtime session (`POST /realtime/sessions`).
  Future<OpenAIRealtimeSession> createSession({
    String? model = 'gpt-realtime',
    List<String>? modalities,
    String? voice,
    String? instructions,
    Map<String, dynamic> extra = const {},
  }) async {
    return await _postSession(
      to: BaseApiUrlBuilder.buildFor(_config, '$_endpoint/sessions'),
      body: {
        if (model != null) 'model': model,
        if (modalities != null) 'modalities': modalities,
        if (voice != null) 'voice': voice,
        if (instructions != null) 'instructions': instructions,
        ...extra,
      },
    );
  }

  /// Creates a transcription session
  /// (`POST /realtime/transcription_sessions`).
  Future<OpenAIRealtimeSession> createTranscriptionSession({
    Map<String, dynamic> extra = const {},
  }) async {
    return await _postSession(
      to: BaseApiUrlBuilder.buildFor(
          _config, '$_endpoint/transcription_sessions'),
      body: {...extra},
    );
  }

  /// Creates an ephemeral client secret for an existing session config
  /// (`POST /realtime/client_secrets`).
  Future<OpenAIRealtimeSession> createClientSecret({
    required Map<String, dynamic> session,
    Map<String, dynamic> extra = const {},
  }) async {
    return await _postSession(
      to: BaseApiUrlBuilder.buildFor(_config, '$_endpoint/client_secrets'),
      body: {'session': session, ...extra},
    );
  }

  /// Creates an ephemeral client secret for a translations session
  /// (`POST /realtime/translations/client_secrets`).
  Future<OpenAIRealtimeSession> createTranslationClientSecret({
    required Map<String, dynamic> session,
    Map<String, dynamic> extra = const {},
  }) async {
    return await _postSession(
      to: BaseApiUrlBuilder.buildFor(
        _config,
        '$_endpoint/translations/client_secrets',
      ),
      body: {'session': session, ...extra},
    );
  }

  Future<OpenAIRealtimeSession> _postSession({
    required String to,
    required Map<String, dynamic> body,
  }) async {
    return await OpenAINetworkingClient.post(
      to: to,
      body: body,
      onSuccess: OpenAIRealtimeSession.fromMap,
      config: _config,
    );
  }
}
