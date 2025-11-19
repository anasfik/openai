import 'dart:io';

import 'package:dart_openai/src/core/models/containers/container_file.dart';

abstract class CreateInterface {
  Future<OpenAIContainerContainerFile> create({
    required String containerId,
    required File file,
    String? fileId,
  });
}
