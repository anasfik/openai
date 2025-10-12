import 'package:meta/meta.dart';

abstract class OpenAITranscriptionGeneralModel {}

final class OpenAITranscriptionModel extends OpenAITranscriptionGeneralModel {
  final List<OpenAITranscriptionModelLogProb>? logprobs;
  final String text;
  final OpenAITranscriptionModelUsage? usage;

  OpenAITranscriptionModel({
    required this.text,
    this.logprobs,
    this.usage,
  });

  factory OpenAITranscriptionModel.fromMap(Map<String, dynamic> json) {
    return OpenAITranscriptionModel(
      text: json['text'],
      logprobs: json['logprobs'] != null
          ? List<OpenAITranscriptionModelLogProb>.from(
              json['logprobs']
                  .map((x) => OpenAITranscriptionModelLogProb.fromMap(x)),
            )
          : null,
      usage: json['usage'] != null
          ? OpenAITranscriptionModelUsage.fromMap(json['usage'])
          : null,
    );
  }
}

class OpenAITranscriptionModelLogProb {
  final List<int> bytes;
  final num logprob;
  final String token;

  const OpenAITranscriptionModelLogProb({
    required this.bytes,
    required this.logprob,
    required this.token,
  });

  factory OpenAITranscriptionModelLogProb.fromMap(Map<String, dynamic> json) {
    return OpenAITranscriptionModelLogProb(
      bytes: List<int>.from(json['bytes']),
      logprob: json['logprob'],
      token: json['token'],
    );
  }
}

class OpenAITranscriptionModelUsage {
  final OpenAITranscriptionModelUsageTokenUsage? tokenUsage;
  final OpenAITranscriptionModelUsageDurationUsage? durationUsage;

  const OpenAITranscriptionModelUsage({
    required this.tokenUsage,
    required this.durationUsage,
  });

  factory OpenAITranscriptionModelUsage.fromMap(Map<String, dynamic> json) {
    return OpenAITranscriptionModelUsage(
      tokenUsage: json['token_usage'] != null
          ? OpenAITranscriptionModelUsageTokenUsage.fromMap(
              json['token_usage'],
            )
          : null,
      durationUsage: json['duration_usage'] != null
          ? OpenAITranscriptionModelUsageDurationUsage.fromMap(
              json['duration_usage'],
            )
          : null,
    );
  }
}

class OpenAITranscriptionModelUsageDurationUsage {
  final num seconds;
  final String type;

  const OpenAITranscriptionModelUsageDurationUsage({
    required this.seconds,
    required this.type,
  });

  factory OpenAITranscriptionModelUsageDurationUsage.fromMap(
    Map<String, dynamic> json,
  ) {
    return OpenAITranscriptionModelUsageDurationUsage(
      seconds: json['seconds'],
      type: json['type'],
    );
  }
}

class OpenAITranscriptionModelUsageTokenUsage {
  final int inputTokens;
  final int outputTokens;
  final int totalTokens;
  final String type;
  final OpenAITranscriptionModelUsageTokenUsageInputTokenDetails
      inputTokenDetails;

  const OpenAITranscriptionModelUsageTokenUsage({
    required this.inputTokens,
    required this.outputTokens,
    required this.totalTokens,
    required this.type,
    required this.inputTokenDetails,
  });

  factory OpenAITranscriptionModelUsageTokenUsage.fromMap(
    Map<String, dynamic> json,
  ) {
    return OpenAITranscriptionModelUsageTokenUsage(
      inputTokens: json['input_tokens'],
      outputTokens: json['output_tokens'],
      totalTokens: json['total_tokens'],
      type: json['type'],
      inputTokenDetails:
          OpenAITranscriptionModelUsageTokenUsageInputTokenDetails.fromMap(
        json['input_token_details'],
      ),
    );
  }
}

class OpenAITranscriptionModelUsageTokenUsageInputTokenDetails {
  final int audioTokens;
  final int textTokens;

  const OpenAITranscriptionModelUsageTokenUsageInputTokenDetails({
    required this.audioTokens,
    required this.textTokens,
  });

  factory OpenAITranscriptionModelUsageTokenUsageInputTokenDetails.fromMap(
    Map<String, dynamic> json,
  ) {
    return OpenAITranscriptionModelUsageTokenUsageInputTokenDetails(
      audioTokens: json['audio_tokens'],
      textTokens: json['text_tokens'],
    );
  }
}

/// {@template openai_audio_model}
/// This class represents the audio model of the OpenAI API, which is used and get returned while using the [OpenAIAudio] methods.
/// {@endtemplate}
@immutable
final class OpenAITranscriptionVerboseModel
    extends OpenAITranscriptionGeneralModel {
  /// The text response from the audio requests.
  /// This is the only field that is returned from the API.
  final String text;
  final String? task;
  final String? language;
  final double? duration;
  final OpenAITranscriptionVerboseModelUsage? usage;
  final List<Word>? words;
  final List<Segment>? segments;

  @override
  int get hashCode => text.hashCode;

  /// {@macro openai_audio_model}
  OpenAITranscriptionVerboseModel({
    required this.text,
    this.task,
    this.language,
    this.duration,
    this.words,
    this.segments,
    this.usage,
  });

  /// This is used  to convert a [Map<String, dynamic>] object to a [OpenAITranscriptionVerboseModel] object.
  factory OpenAITranscriptionVerboseModel.fromMap(Map<String, dynamic> json) {
    return OpenAITranscriptionVerboseModel(
      text: json['text'],
      task: json['task'],
      language: json['language'],
      duration: json['duration'],
      words: json['words'] != null
          ? List<Word>.from(json['words'].map((x) => Word.fromMap(x)))
          : null,
      segments: json['segments'] != null
          ? List<Segment>.from(json['segments'].map((x) => Segment.fromMap(x)))
          : null,
      usage: json['usage'] != null
          ? OpenAITranscriptionVerboseModelUsage.fromMap(json['usage'])
          : null,
    );
  }

  ///  This method used to convert the [OpenAITranscriptionVerboseModel] to a [Map<String, dynamic>] object.
  ///
  /// could be useful if you want to save an audio response to a database.
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      if (task != null) 'task': task,
      if (language != null) 'language': language,
      if (duration != null) 'duration': duration,
      if (words != null) 'words': words,
      if (segments != null) 'segments': segments,
    };
  }

  @override
  String toString() {
    return 'OpenAITranscriptionVerboseModel(text: $text, task: $task, language: $language, duration: $duration, words: $words, segments: $segments)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OpenAITranscriptionVerboseModel &&
        other.text == text &&
        other.task == task &&
        other.language == language &&
        other.duration == duration &&
        other.words == words &&
        other.segments == segments;
  }
}

final class Word {
  final String word;
  final double start;
  final double end;

  const Word({
    required this.word,
    required this.start,
    required this.end,
  });

  factory Word.fromMap(Map<String, dynamic> json) {
    return Word(
      word: json['word'],
      start: json['start'],
      end: json['end'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'word': word,
      'start': start,
      'end': end,
    };
  }

  @override
  String toString() => 'Word(word: $word, start: $start, end: $end)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Word &&
        other.word == word &&
        other.start == start &&
        other.end == end;
  }
}

final class Segment {
  final int id;
  final int seek;
  final double start;
  final double end;
  final String text;
  final List<int> tokens;
  final double temperature;
  final double avg_logprob;
  final double compression_ratio;
  final double no_speech_prob;

  const Segment({
    required this.id,
    required this.seek,
    required this.start,
    required this.end,
    required this.text,
    required this.tokens,
    required this.temperature,
    required this.avg_logprob,
    required this.compression_ratio,
    required this.no_speech_prob,
  });

  factory Segment.fromMap(Map<String, dynamic> json) {
    return Segment(
      id: json['id'],
      seek: json['seek'],
      start: json['start'],
      end: json['end'],
      text: json['text'],
      tokens: List<int>.from(json['tokens']),
      temperature: json['temperature'],
      avg_logprob: json['avg_logprob'],
      compression_ratio: json['compression_ratio'],
      no_speech_prob: json['no_speech_prob'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'seek': seek,
      'start': start,
      'end': end,
      'text': text,
      'tokens': tokens,
      'temperature': temperature,
      'avg_logprob': avg_logprob,
      'compression_ratio': compression_ratio,
      'no_speech_prob': no_speech_prob,
    };
  }

  @override
  String toString() =>
      'Segment(id: $id, seek: $seek, start: $start, end: $end, text: $text, tokens: $tokens, temperature: $temperature, avg_logprob: $avg_logprob, compression_ratio: $compression_ratio, no_speech_prob: $no_speech_prob)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Segment &&
        other.id == id &&
        other.seek == seek &&
        other.start == start &&
        other.end == end &&
        other.text == text &&
        other.tokens == tokens &&
        other.temperature == temperature &&
        other.avg_logprob == avg_logprob &&
        other.compression_ratio == compression_ratio &&
        other.no_speech_prob == no_speech_prob;
  }
}

class OpenAITranscriptionVerboseModelUsage {
  final int seconds;
  final String type;

  const OpenAITranscriptionVerboseModelUsage({
    required this.seconds,
    required this.type,
  });

  factory OpenAITranscriptionVerboseModelUsage.fromMap(
    Map<String, dynamic> json,
  ) {
    return OpenAITranscriptionVerboseModelUsage(
      seconds: json['seconds'],
      type: json['type'],
    );
  }
}
