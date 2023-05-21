import 'dart:io';

import 'package:dart_openai/dart_openai.dart';

import 'env/env.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

Future<void> main() async {
// Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;

// create the audio transcription.
  final translation = await OpenAI.instance.audio.createTranslation(
    file: await getFileFromUrl(
        'https://www.cbvoiceovers.com/wp-content/uploads/2017/05/Commercial-showreel.mp3',
        fileExtension: "mp3"),
    model: "whisper-1",
    responseFormat: OpenAIAudioResponseFormat.json,
  );

  // print the translation.
  print(translation);
}

Future<File> getFileFromUrl(
  String networkUrl, {
  String fileExtension = 'png',
}) async {
  final response = await http.get(Uri.parse(networkUrl));
  final uniqueImageName = DateTime.now().microsecondsSinceEpoch;
  final file = File("$uniqueImageName.$fileExtension");
  await file.writeAsBytes(response.bodyBytes);
  return file;
}
