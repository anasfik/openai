import 'package:dart_openai/src/core/config/client_config.dart';
import 'package:dart_openai/src/instance/containers/container_files.dart';
import 'package:dart_openai/src/instance/containers/containers.dart';

class OpenAIContainerContainers {
  OpenAIContainerContainers([OpenAIClientConfig? config])
      : containers = OpenAIContainers(config),
        containerFiles = OpenAIContainerFiles(config);

  final OpenAIContainers containers;

  final OpenAIContainerFiles containerFiles;
}
