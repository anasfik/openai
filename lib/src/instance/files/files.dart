import 'package:openai/src/core/builder/base_api_url.dart';
import 'package:openai/src/core/models/file/file.dart';
import 'package:openai/src/core/networking/client.dart';

import 'dart:io';

import '../../core/base/files/base.dart';

class OpenAIFiles implements OpenAIFilesBase {
  @override
  String get endpoint => "/files";

  /// This method fetches for your files list that exists in your account
  /// Example:
  ///```dart
  /// List<OpenAIFileModel> files = await OpenAI.instance.file.list();
  /// print(files);
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
  /// OpenAIFileModel file = await OpenAI.instance.file.retrieve("FILE ID");
  ///  print(file);
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

  /// This method fetches for the actual content of an uploaded file in your account.
  /// Example:
  /// ```dart
  /// dynamic fileContent  = await OpenAI.instance.file.retrieveContent("FILE ID");
  /// ```
  @override
  Future<dynamic> retrieveContent(String fileId) async {
    final String fileIdEndpoint = "/$fileId/content";

    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.build(endpoint + fileIdEndpoint),
      returnRawResponse: true,
    );
  }

  /// This method uploads a file to your account directly
  /// Example:
  /// ```dart
  /// OpenAIFileModel uploadedFile = await OpenAI.instance.file.upload(
  /// file: File("FILE PATH HERE"),
  /// purpose: "fine-tuning",
  /// );
  /// ```
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

  /// This method deleted an existent fil from your account used it's id.
  /// ```dart
  /// bool isFileDeleted = await OpenAI.instance.file.delete("FILE ID");
  /// ```
  @override
  Future<bool> delete(String fileId) async {
    final String fileIdEndpoint = "/$fileId";
    return await OpenAINetworkingClient.deleteFile(
      from: BaseApiUrlBuilder.build(endpoint + fileIdEndpoint),
      onSuccess: (Map<String, dynamic> response) {
        final bool isDeleted = response["deleted"] as bool;

        return isDeleted;
      },
    );
  }
}
