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
    return _postSession(
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
    return _postSession(
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
    return _postSession(
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
    return _postSession(
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
    return OpenAINetworkingClient.post(
      to: to,
      body: body,
      onSuccess: OpenAIRealtimeSession.fromMap,
      config: _config,
    );
  }

  String _callEndpoint(String callId) => '$_endpoint/calls/$callId';

  /// Accepts an incoming SIP call with an SDP answer
  /// (`POST /realtime/calls/{call_id}/accept`). Raw response map.
  Future<Map<String, dynamic>> acceptCall({
    required String callId,
    required String sdp,
    String type = 'sdp',
  }) async {
    return OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(
          _config, '${_callEndpoint(callId)}/accept'),
      body: {'type': type, 'sdp': sdp},
      onSuccess: (response) => response,
      config: _config,
    );
  }

  /// Rejects an incoming SIP call (`POST /realtime/calls/{call_id}/reject`).
  /// Raw response map.
  Future<Map<String, dynamic>> rejectCall({required String callId}) async {
    return OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(
          _config, '${_callEndpoint(callId)}/reject'),
      onSuccess: (response) => response,
      config: _config,
    );
  }

  /// Hangs up a SIP call (`DELETE /realtime/calls/{call_id}`).
  /// Raw response map.
  Future<Map<String, dynamic>> hangupCall({required String callId}) async {
    return OpenAINetworkingClient.delete(
      from: BaseApiUrlBuilder.buildFor(_config, _callEndpoint(callId)),
      onSuccess: (response) => response,
      config: _config,
    );
  }

  /// Refers a SIP call to another target
  /// (`POST /realtime/calls/{call_id}/refer`). Raw response map.
  Future<Map<String, dynamic>> referCall({
    required String callId,
    required String target,
  }) async {
    return OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, '${_callEndpoint(callId)}/refer'),
      body: {'target': target},
      onSuccess: (response) => response,
      config: _config,
    );
  }
}
