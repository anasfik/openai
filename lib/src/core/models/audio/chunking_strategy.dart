import 'package:meta/meta.dart';

import '../../enum.dart';

/// {@template openai_audio_chunking_config}
/// This class represents the chunking strategy configuration for audio transcription.
/// It can be either "auto" or a server VAD configuration with custom parameters.
/// {@endtemplate}
@immutable
abstract class OpenAIAudioChunkingConfig {
  /// The type of chunking strategy to use.
  final OpenAIAudioChunkingStrategy type;

  /// {@macro openai_audio_chunking_config}
  const OpenAIAudioChunkingConfig({required this.type});

  /// Factory constructor for creating auto chunking strategy.
  factory OpenAIAudioChunkingConfig.auto() {
    return const OpenAIAudioChunkingConfigAuto();
  }

  /// Factory constructor for creating server VAD chunking strategy.
  factory OpenAIAudioChunkingConfig.serverVad({
    int? prefixPaddingMs,
    int? silenceDurationMs,
    double? threshold,
  }) {
    return OpenAIAudioChunkingConfigServerVad(
      prefixPaddingMs: prefixPaddingMs,
      silenceDurationMs: silenceDurationMs,
      threshold: threshold,
    );
  }

  /// This is used to convert a [Map<String, dynamic>] object to a [OpenAIAudioChunkingConfig] object.
  factory OpenAIAudioChunkingConfig.fromMap(Map<String, dynamic> json) {
    final type = OpenAIAudioChunkingStrategy.values.firstWhere(
      (e) => e.name == json['type'],
    );

    switch (type) {
      case OpenAIAudioChunkingStrategy.auto:
        return OpenAIAudioChunkingConfig.auto();
      case OpenAIAudioChunkingStrategy.server_vad:
        return OpenAIAudioChunkingConfig.serverVad(
          prefixPaddingMs: json['prefix_padding_ms'],
          silenceDurationMs: json['silence_duration_ms'],
          threshold: json['threshold'],
        );
    }
  }

  /// This method is used to convert the [OpenAIAudioChunkingConfig] to a [Map<String, dynamic>] object.
  Map<String, dynamic> toMap();

  @override
  String toString() => 'OpenAIAudioChunkingConfig(type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OpenAIAudioChunkingConfig && other.type == type;
  }

  @override
  int get hashCode => type.hashCode;
}

/// {@template openai_audio_chunking_config_auto}
/// Auto chunking strategy configuration.
/// {@endtemplate}
@immutable
final class OpenAIAudioChunkingConfigAuto extends OpenAIAudioChunkingConfig {
  /// {@macro openai_audio_chunking_config_auto}
  const OpenAIAudioChunkingConfigAuto()
      : super(type: OpenAIAudioChunkingStrategy.auto);

  @override
  Map<String, dynamic> toMap() {
    return {'type': type.name};
  }

  @override
  String toString() => 'OpenAIAudioChunkingConfigAuto()';
}

/// {@template openai_audio_chunking_config_server_vad}
/// Server VAD chunking strategy configuration with custom parameters.
/// {@endtemplate}
@immutable
final class OpenAIAudioChunkingConfigServerVad
    extends OpenAIAudioChunkingConfig {
  /// The amount of audio to include before the VAD detected speech starts, in milliseconds.
  final int? prefixPaddingMs;

  /// The amount of silence to wait before considering speech to have ended, in milliseconds.
  final int? silenceDurationMs;

  /// The threshold for voice activity detection. Lower values are more sensitive.
  final double? threshold;

  /// {@macro openai_audio_chunking_config_server_vad}
  const OpenAIAudioChunkingConfigServerVad({
    this.prefixPaddingMs,
    this.silenceDurationMs,
    this.threshold,
  }) : super(type: OpenAIAudioChunkingStrategy.server_vad);

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type.name,
      if (prefixPaddingMs != null) 'prefix_padding_ms': prefixPaddingMs,
      if (silenceDurationMs != null) 'silence_duration_ms': silenceDurationMs,
      if (threshold != null) 'threshold': threshold,
    };
  }

  @override
  String toString() {
    return 'OpenAIAudioChunkingConfigServerVad(prefixPaddingMs: $prefixPaddingMs, silenceDurationMs: $silenceDurationMs, threshold: $threshold)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OpenAIAudioChunkingConfigServerVad &&
        other.type == type &&
        other.prefixPaddingMs == prefixPaddingMs &&
        other.silenceDurationMs == silenceDurationMs &&
        other.threshold == threshold;
  }

  @override
  int get hashCode =>
      Object.hash(type, prefixPaddingMs, silenceDurationMs, threshold);
}
