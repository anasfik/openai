
import 'package:dart_openai/src/core/io/openai_file.dart';
import 'package:dart_openai/src/core/models/containers/container_file.dart';

abstract class CreateInterface {
  Future<OpenAIContainerContainerFile> create({
    required String containerId,
    required OpenAIFile file,
    String? fileId,
  });
}
