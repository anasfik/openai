import 'package:meta/meta.dart';

/// {@template openai_audio_model}
/// This class represents the audio model of the OpenAI API, which is used and get returned while using the [OpenAIAudio] methods.
/// {@endtemplate}
@immutable
final class OpenAIAudioModel {
  /// The text response from the audio requests.
  /// This is the only field that is returned from the API.
  final String text;

  @override
  int get hashCode => text.hashCode;

  /// {@macro openai_audio_model}
  const OpenAIAudioModel({
    required this.text,
  });

  /// This is used  to convert a [Map<String, dynamic>] object to a [OpenAIAudioModel] object.
  factory OpenAIAudioModel.fromMap(Map<String, dynamic> json) {
    return OpenAIAudioModel(
      text: json['text'],
    );
  }

  ///  This method used to convert the [OpenAIAudioModel] to a [Map<String, dynamic>] object.
  ///
  /// could be useful if you want to save an audio response to a database.
  Map<String, dynamic> toMap() {
    return {
      'text': text,
    };
  }

  @override
  String toString() {
    return 'OpenAIAudioModel(text: $text)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OpenAIAudioModel && other.text == text;
  }
}
