import 'dart:io';

import 'package:dart_openai/dart_openai.dart';

import 'env/env.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

Future<void> main() async {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;

  print("Demonstrating chunking_strategy in audio transcription...\n");

  // Example 1: Using auto chunking strategy
  print("1. Using auto chunking strategy:");
  final transcriptionAuto = await OpenAI.instance.audio.createTranscription(
    file: await getFileFromUrl(
      'https://www.cbvoiceovers.com/wp-content/uploads/2017/05/Commercial-showreel.mp3',
    ),
    model: "whisper-1",
    responseFormat: OpenAIAudioResponseFormat.json,
    chunkingStrategy: OpenAIAudioChunkingConfig.auto(),
  );
  print(
      "Auto chunking result: ${transcriptionAuto.text.substring(0, 100)}...\n");

  // Example 2: Using server VAD chunking strategy with custom parameters
  print("2. Using server VAD chunking strategy:");
  final transcriptionServerVad =
      await OpenAI.instance.audio.createTranscription(
    file: await getFileFromUrl(
      'https://www.cbvoiceovers.com/wp-content/uploads/2017/05/Commercial-showreel.mp3',
    ),
    model: "whisper-1",
    responseFormat: OpenAIAudioResponseFormat.json,
    chunkingStrategy: OpenAIAudioChunkingConfig.serverVad(
      prefixPaddingMs: 200, // Add 200ms of audio before detected speech
      silenceDurationMs:
          500, // Wait 500ms of silence before considering speech ended
      threshold:
          0.1, // Voice activity detection threshold (lower = more sensitive)
    ),
  );
  print(
      "Server VAD chunking result: ${transcriptionServerVad.text.substring(0, 100)}...\n");

  // Example 3: Using chunking strategy with translation
  print("3. Using auto chunking strategy for translation:");
  final translation = await OpenAI.instance.audio.createTranslation(
    file: await getFileFromUrl(
      'https://www.cbvoiceovers.com/wp-content/uploads/2017/05/Commercial-showreel.mp3',
    ),
    model: "whisper-1",
    chunkingStrategy: OpenAIAudioChunkingConfig.auto(),
  );
  print(
      "Translation with chunking: ${translation.text.substring(0, 100)}...\n");

  // Example 4: Different chunking configurations
  print("4. Different server VAD configurations:");

  // More sensitive VAD (lower threshold)
  final sensitiveTrans = await OpenAI.instance.audio.createTranscription(
    file: await getFileFromUrl(
      'https://www.cbvoiceovers.com/wp-content/uploads/2017/05/Commercial-showreel.mp3',
    ),
    model: "whisper-1",
    chunkingStrategy: OpenAIAudioChunkingConfig.serverVad(threshold: 0.05),
  );
  print("Sensitive VAD result: ${sensitiveTrans.text.substring(0, 100)}...\n");

  // Less sensitive VAD (higher threshold) with longer silence detection
  final conservativeTrans = await OpenAI.instance.audio.createTranscription(
    file: await getFileFromUrl(
      'https://www.cbvoiceovers.com/wp-content/uploads/2017/05/Commercial-showreel.mp3',
    ),
    model: "whisper-1",
    chunkingStrategy: OpenAIAudioChunkingConfig.serverVad(
      threshold: 0.3,
      silenceDurationMs: 1000,
    ),
  );
  print(
      "Conservative VAD result: ${conservativeTrans.text.substring(0, 100)}...\n");

  print("Chunking strategy demonstration completed!");
}

/// Downloads a file from the given URL and returns it as a File object.
Future<File> getFileFromUrl(String networkUrl) async {
  final response = await http.get(Uri.parse(networkUrl));
  final uniqueImageName = DateTime.now().microsecondsSinceEpoch;
  final file = File("$uniqueImageName.mp3");
  await file.writeAsBytes(response.bodyBytes);
  return file;
}
