import 'dart:convert';
import 'dart:io';

import 'package:dart_openai/openai.dart';
import 'package:dotenv/dotenv.dart';

void main() async {
  // Load the .env file
  DotEnv env = DotEnv()..load([".env"]);

  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = env['OPEN_AI_API_KEY']!;

// // Upload an example File
//   OpenAIFileModel file = await OpenAI.instance.file.upload(
//     purpose: 'fine-tune',
//     file: jsonLFileExample(),
//   );

  // Creating a fine-tune job.
  OpenAIFineTuneModel fineTuneModel = await OpenAI.instance.fineTune.create(
    model: "ada",
    trainingFile: "file-trITb8KgJfPnrohis0RsbIVH",
  );


  // Get a stream of events for a fine-tune job.
  Stream fineTuneEventStream = OpenAI.instance.fineTune
      .listEventsStream(fineTuneModel.id);

  // Listen to the stream.
  fineTuneEventStream.listen((event) {
    print(event);
  });
}

File jsonLFileExample() {
  final file = File("example.jsonl");
  file.writeAsStringSync(
    jsonEncode(
        {"prompt": "<prompt text>", "completion": "<ideal generated text>"}),
  );
  return file;
}
