enum OpenAIImageSize {
  size256,
  size512,
  size1024,
  size1792Horizontal,
  size1792Vertical
}

enum OpenAIImageStyle { vivid, natural }

enum OpenAIImageQuality { hd }

enum OpenAIImageResponseFormat { url, b64Json }

enum OpenAIAudioTimestampGranularity { word, segment }

enum OpenAIAudioResponseFormat { json, text, srt, verbose_json, vtt }

enum OpenAIAudioSpeechResponseFormat { mp3, opus, aac, flac, wav, pcm }

enum OpenAIAudioChunkingStrategy { auto, server_vad }

enum OpenAIChatMessageRole { system, user, assistant, function, tool }

enum OpenAIAudioVoice {
  alloy("alloy"),
  ash("ash"),
  ballad("ballad"),
  coral("coral"),
  echo("echo"),
  fable("fable"),
  onyx("onyx"),
  nova("nova"),
  sage("sage"),
  shimmer("shimmer"),
  verse("verse");

  final String name;
  const OpenAIAudioVoice(this.name);

  @override
  String toString() => name;
}
