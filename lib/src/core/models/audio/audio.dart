import 'package:meta/meta.dart';

/// {@template openai_audio_model}
/// This class represents the audio model of the OpenAI API, which is used and get returned while using the [OpenAIAudio] methods.
/// {@endtemplate}
@immutable
final class OpenAIAudioModel {
  /// The text response from the audio requests.
  /// This is the only field that is returned from the API.
  final String text;
  final String? task;
  final String? language;
  final double? duration;

  final List<Word>? words;
  final List<Segment>? segments;

  @override
  int get hashCode => text.hashCode;

  /// {@macro openai_audio_model}
  const OpenAIAudioModel({
    required this.text,
    this.task,
    this.language,
    this.duration,
    this.words,
    this.segments,
  });

  /// This is used  to convert a [Map<String, dynamic>] object to a [OpenAIAudioModel] object.
  factory OpenAIAudioModel.fromMap(Map<String, dynamic> json) {
    return OpenAIAudioModel(
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
    );
  }

  ///  This method used to convert the [OpenAIAudioModel] to a [Map<String, dynamic>] object.
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
    return 'OpenAIAudioModel(text: $text, task: $task, language: $language, duration: $duration, words: $words, segments: $segments)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OpenAIAudioModel &&
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
