import 'package:dart_openai/src/core/models/containers/container.dart';
import 'package:dart_openai/src/core/models/containers/expires_after.dart';

abstract class CreateInterface {
  Future<OpenAIContainer> create({
    required String name,
    OpenAIContainerExpiresAfter? expiresAfter,
    List<String>? fileIds,
  });
}
