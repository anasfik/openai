import 'package:dart_openai/src/core/models/containers/container.dart';
import 'package:dart_openai/src/core/models/containers/containers_list.dart';

abstract class GetInterface {
  Future<OpenAIContainerList> list({
    String? after,
    int? limit,
    String? order,
  });

  Future<OpenAIContainer> get({
    required String containerId,
  });
}
