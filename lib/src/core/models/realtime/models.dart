/// Models for the /realtime REST API (sessions and client secrets).
library;

class OpenAIRealtimeClientSecret {
  /// The ephemeral token value, e.g. `ek_...`.
  final String value;

  /// Unix timestamp (seconds) after which this secret expires.
  final int? expiresAt;

  OpenAIRealtimeClientSecret({required this.value, this.expiresAt});

  factory OpenAIRealtimeClientSecret.fromMap(Map<String, dynamic> map) {
    return OpenAIRealtimeClientSecret(
      value: map['value']?.toString() ?? '',
      expiresAt: (map['expires_at'] as num?)?.toInt(),
    );
  }
}

/// A realtime session. The session payload schema varies across
/// `realtime.session`, `realtime.transcription_session` and
/// `client_secret` responses, so it is kept loose as a map.
class OpenAIRealtimeSession {
  final String id;
  final String object;
  final int? expiresAt;
  final Map<String, dynamic> session;
  final OpenAIRealtimeClientSecret? clientSecret;

  OpenAIRealtimeSession({
    required this.id,
    required this.object,
    required this.session,
    this.expiresAt,
    this.clientSecret,
  });

  factory OpenAIRealtimeSession.fromMap(Map<String, dynamic> map) {
    final secret = map['client_secret'];
    return OpenAIRealtimeSession(
      id: map['id'] as String? ?? '',
      object: map['object'] as String? ?? 'realtime.session',
      expiresAt: (map['expires_at'] as num?)?.toInt(),
      session: map['session'] is Map<String, dynamic>
          ? map['session'] as Map<String, dynamic>
          : {},
      clientSecret: secret is Map<String, dynamic>
          ? OpenAIRealtimeClientSecret.fromMap(secret)
          : null,
    );
  }
}
