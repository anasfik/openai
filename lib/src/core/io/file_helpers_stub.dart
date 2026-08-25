import 'openai_file.dart';

/// Stub for platforms without dart:io. Loading from a file path is only
/// possible on native platforms; use `OpenAIFile(bytes: ...)` on the web.
Future<OpenAIFile> loadOpenAIFile(String path, {String? name}) async {
  throw UnsupportedError(
    'loadOpenAIFile requires a native platform (dart:io). '
    'On the web, construct OpenAIFile(bytes: ..., fileName: ...) directly.',
  );
}

/// Stub for platforms without dart:io. Saving response bytes to disk is only
/// possible on native platforms; use `createSpeechBytes` on the web.
Future<void> saveOpenAIBytes({
  required List<int> bytes,
  required String outputDirectory,
  required String outputFileName,
}) async {
  throw UnsupportedError(
    'Saving to disk requires a native platform (dart:io). '
    'On the web, use createSpeechBytes() and handle the bytes yourself.',
  );
}
