import 'package:openai/src/core/builder/base_api_url.dart';
import 'package:openai/src/core/models/file.dart';
import 'package:openai/src/core/networking/client.dart';

import 'dart:io';

import '../../core/base/files/base.dart';

class OpenAIFiles implements OpenAIFilesBase {
  @override
  String get endpoint => "/files";

  /// This method fetches for your files list that exists in your account
  /// Example:
  ///```dart
  ///
  ///```
  @override
  Future<List<OpenAIFileModel>> list() async {
    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.build(endpoint),
      onSuccess: (Map<String, dynamic> response) {
        final List<dynamic> filesList = response["data"];
        return filesList.map((e) => OpenAIFileModel.fromMap(e)).toList();
      },
    );
  }

  /// This method fetch for a single file based on it's id.
  ///```dart
  ///
  ///```
  @override
  Future<OpenAIFileModel> retrieve(String fileId) async {
    final String fileIdEndpoint = "/$fileId";

    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.build(endpoint + fileIdEndpoint),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIFileModel.fromMap(response);
      },
    );
  }

  @override
  Future<dynamic> retrieveContent(String fileId) async {
    final String fileIdEndpoint = "/$fileId";

    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.build(endpoint + fileIdEndpoint),
      onSuccess: (response) {
        return response;
      },
    );
  }

  @override
  Future<OpenAIFileModel> upload({
    required File file,
    required String purpose,
  }) async {
    return await OpenAINetworkingClient.fileUpload(
      to: endpoint,
      body: {
        "purpose": purpose,
      },
      file: file,
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIFileModel.fromMap(response);
      },
    );
  }

  @override
  Future<bool> delete(String fileId) async {
    final String fileIdEndpoint = "/$fileId";
    return await OpenAINetworkingClient.deleteFile(
      from: fileIdEndpoint,
      onSuccess: (Map<String, dynamic> response) {
        final isDeleted = response["deleted"] as bool;

        return isDeleted;
      },
    );
  }
}
