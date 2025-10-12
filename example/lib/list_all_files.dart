import 'package:dart_openai/dart_openai.dart';

import 'env/env.dart';

Future<void> main() async {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;

  // List all files.
  final files = await OpenAI.instance.file.list();

  // Print the files.
  print(files);
}
