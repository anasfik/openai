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

enum OpenAIAudioSpeechResponseFormat { mp3, opus, aac, flac }

enum OpenAIChatMessageRole { system, user, assistant, function, tool }
