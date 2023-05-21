import 'dart:convert';
import 'dart:io';

import 'package:dart_openai/dart_openai.dart';

import 'env/env.dart';

void main() async {
  // Set the OpenAI API key from the .env file.
  OpenAI.apiKey = Env.apiKey;

// Upload an example File
  OpenAIFileModel file = await OpenAI.instance.file.upload(
    purpose: 'fine-tune',
    file: jsonLFileExample(),
  );

  // Creating a fine-tune job.
  OpenAIFineTuneModel fineTuneModel = await OpenAI.instance.fineTune.create(
    model: "ada",
    trainingFile: file.id,
  );

  // Get a stream of events for a fine-tune job.
  Stream<OpenAIFineTuneEventStreamModel> fineTuneEventStream =
      OpenAI.instance.fineTune.listEventsStream(fineTuneModel.id);

  // Listen to the stream.
  fineTuneEventStream.listen((event) {
    print(event);
  });

  // Wait for 5 seconds.
  await Future.delayed(Duration(seconds: 5));

  // cancel the fine-tune job.
  final cancelledFineTune =
      await OpenAI.instance.fineTune.cancel(fineTuneModel.id);

  // print the cancelled fine-tune job.
  print("Cancelled fine-tune job: ${cancelledFineTune.id}");
}

File jsonLFileExample() {
  final file = File("example.jsonl");
  file.writeAsStringSync(
    jsonEncode(
        {"prompt": "<prompt text>", "completion": "<ideal generated text>"}),
  );
  return file;
}
