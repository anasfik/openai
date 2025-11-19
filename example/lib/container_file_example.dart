import 'dart:convert';
import 'dart:io';

import 'package:dart_openai/dart_openai.dart';
import 'package:example/env/env.dart';

void main() async {
  OpenAI.apiKey = Env.apiKey;
  final containerId = "cntr_691dc7f1316881908fcff33d04ba4a9603f8e5842a00c1cc";

  final containerFile = await OpenAI.instance.container.containerFiles.create(
    file: jsonLFileExample(),
    containerId: containerId,
  );

  print("Created container File: ${containerFile.id}");

  final gotContainerFile = await OpenAI.instance.container.containerFiles.get(
    containerId: containerId,
    fileId: containerFile.id,
  );

  print("Got container File: ${gotContainerFile.id}");

  final gotContainerFileContent =
      await OpenAI.instance.container.containerFiles.getContent(
    containerId: containerId,
    fileId: containerFile.id,
  );

  print("Got container File Content: ${gotContainerFileContent.length}");

  final allContainerFiles = await OpenAI.instance.container.containerFiles.list(
    containerId: containerId,
    limit: 10,
  );

  print("Listed container Files: ${allContainerFiles.data.length}");

  if (allContainerFiles.data.isNotEmpty) {
    final containerFile = allContainerFiles.data.first;

    await OpenAI.instance.container.containerFiles.delete(
      fileId: containerFile.id,
      containerId: containerFile.containerId,
    );

    print("Deleted container File: ${containerFile.id}");
  }
}

File jsonLFileExample() {
  final file = File("example.jsonl");
  file.writeAsStringSync(
    jsonEncode(
        {"prompt": "<prompt text>", "completion": "<ideal generated text>"}),
  );
  return file;
}
