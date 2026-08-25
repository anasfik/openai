enum OpenAIImageSize {
  size256,
  size512,
  size1024,
  size1792Horizontal,
  size1792Vertical,
  size1536Horizontal,
  size1536Vertical,
  auto;

  String get value {
    switch (this) {
      case OpenAIImageSize.size256:
        return "256x256";
      case OpenAIImageSize.size512:
        return "512x512";
      case OpenAIImageSize.size1024:
        return "1024x1024";
      case OpenAIImageSize.size1792Horizontal:
        return "1792x1024";
      case OpenAIImageSize.size1792Vertical:
        return "1024x1792";
      case OpenAIImageSize.size1536Horizontal:
        return "1536x1024";
      case OpenAIImageSize.size1536Vertical:
        return "1024x1536";
      case OpenAIImageSize.auto:
        return "auto";
    }
  }

  static OpenAIImageSize fromValue(String value) {
    switch (value) {
      case "256x256":
        return OpenAIImageSize.size256;
      case "512x512":
        return OpenAIImageSize.size512;
      case "1024x1024":
        return OpenAIImageSize.size1024;
      case "1792x1024":
        return OpenAIImageSize.size1792Horizontal;
      case "1024x1792":
        return OpenAIImageSize.size1792Vertical;
      case "1536x1024":
        return OpenAIImageSize.size1536Horizontal;
      case "1024x1536":
        return OpenAIImageSize.size1536Vertical;
      case "auto":
        return OpenAIImageSize.auto;
      default:
        throw ArgumentError("Invalid value for OpenAIImageSize: $value");
    }
  }
}

enum OpenAIImageStyle {
  vivid,
  natural;

  String get value {
    return name;
  }
}

enum OpenAIImageResponseFormat {
  url,
  b64Json;

  String get value {
    switch (this) {
      case OpenAIImageResponseFormat.url:
        return "url";
      case OpenAIImageResponseFormat.b64Json:
        return "b64_json";
    }
  }
}

enum OpenAIImageInputFidelity {
  high,
  low;
}

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
