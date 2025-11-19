import 'dart:io';

import 'package:dart_openai/src/core/base/container/container_files/container_files.dart';
import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/models/containers/container_file.dart';
import 'package:dart_openai/src/core/models/containers/container_files_list.dart';
import 'package:dart_openai/src/core/networking/client.dart';

class OpenAIContainerFiles extends OpenAIContainerFilesBase {
  @override
  String get endpoint => OpenAIStrings.endpoints.containers;

  @override
  Future<OpenAIContainerContainerFile> create({
    required String containerId,
    required File file,
    String? fileId,
  }) async {
    return await OpenAINetworkingClient.fileUpload(
      to: BaseApiUrlBuilder.build(endpoint, "/$containerId/files"),
      body: {
        if (fileId != null) "file_id": fileId,
      },
      file: file,
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIContainerContainerFile.fromMap(response);
      },
    );
  }

  @override
  Future<OpenAIContainerContainerFileListModel> list({
    required String containerId,
    String? after,
    int? limit,
    String? order,
  }) async {
    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: endpoint + "/$containerId/files",
        query: {
          if (after != null) "after": after,
          if (limit != null) "limit": limit.toString(),
          if (order != null) "order": order,
        },
      ),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIContainerContainerFileListModel.fromMap(response);
      },
    );
  }

  @override
  Future<OpenAIContainerContainerFile> get({
    required String fileId,
    required String containerId,
  }) async {
    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.build(
        endpoint + "/$containerId/files/$fileId",
      ),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIContainerContainerFile.fromMap(response);
      },
    );
  }

  @override
  Future getContent({
    required String fileId,
    required String containerId,
  }) async {
    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.build(
        endpoint + "/$containerId/files/$fileId/content",
      ),
      returnRawResponse: true,
    );
  }

  @override
  Future<void> delete({
    required String fileId,
    required String containerId,
  }) async {
    return await OpenAINetworkingClient.delete(
      from: BaseApiUrlBuilder.build(
        endpoint + "/$containerId/files/$fileId",
      ),
      onSuccess: (Map<String, dynamic> response) {
        final deleted = response["deleted"] == true;

        if (deleted) {
          return;
        }
      },
    );
  }
}
