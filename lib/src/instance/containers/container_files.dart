import 'package:dart_openai/src/core/base/container/container_files/container_files.dart';
import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/config/client_config.dart';
import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/io/openai_file.dart';
import 'package:dart_openai/src/core/models/containers/container_file.dart';
import 'package:dart_openai/src/core/models/containers/container_files_list.dart';
import 'package:dart_openai/src/core/networking/client.dart';

class OpenAIContainerFiles extends OpenAIContainerFilesBase {
  /// Per-client configuration; when null, global statics are used.
  final OpenAIClientConfig? _config;

  OpenAIContainerFiles([this._config]);

  @override
  String get endpoint => OpenAIStrings.endpoints.containers;

  @override
  Future<OpenAIContainerContainerFile> create({
    required String containerId,
    required OpenAIFile file,
    String? fileId,
  }) async {
    return OpenAINetworkingClient.fileUpload(
      to: BaseApiUrlBuilder.buildFor(_config, endpoint, '/$containerId/files'),
      body: {
        if (fileId != null) 'file_id': fileId,
      },
      file: file,
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIContainerContainerFile.fromMap(response);
      },
      config: _config,
    );
  }

  @override
  Future<OpenAIContainerContainerFileListModel> list({
    required String containerId,
    String? after,
    int? limit,
    String? order,
  }) async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: '$endpoint/$containerId/files',
        query: {
          if (after != null) 'after': after,
          if (limit != null) 'limit': limit.toString(),
          if (order != null) 'order': order,
        },
        config: _config,
      ),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIContainerContainerFileListModel.fromMap(response);
      },
      config: _config,
    );
  }

  @override
  Future<OpenAIContainerContainerFile> get({
    required String fileId,
    required String containerId,
  }) async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildFor(
          _config, '$endpoint/$containerId/files/$fileId'),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIContainerContainerFile.fromMap(response);
      },
      config: _config,
    );
  }

  @override
  Future getContent({
    required String fileId,
    required String containerId,
  }) async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildFor(
          _config, '$endpoint/$containerId/files/$fileId/content'),
      returnRawResponse: true,
      config: _config,
    );
  }

  @override
  Future<void> delete({
    required String fileId,
    required String containerId,
  }) async {
    return OpenAINetworkingClient.delete(
      from: BaseApiUrlBuilder.buildFor(
          _config, '$endpoint/$containerId/files/$fileId'),
      onSuccess: (Map<String, dynamic> response) {
        final deleted = response['deleted'] == true;

        if (deleted) {
          return;
        }
      },
      config: _config,
    );
  }
}
