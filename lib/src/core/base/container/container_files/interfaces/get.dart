import 'package:dart_openai/src/core/models/containers/container_file.dart';
import 'package:dart_openai/src/core/models/containers/container_files_list.dart';

abstract class GetInterface {
  Future<OpenAIContainerContainerFile> get({
    required String fileId,
    required String containerId,
  });

  Future getContent({
    required String fileId,
    required String containerId,
  });

  Future<OpenAIContainerContainerFileListModel> list({
    required String containerId,
    String? after,
    int? limit,
    String? order,
  });
}
