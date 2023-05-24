import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/models/file/file.dart';
import 'package:dart_openai/src/core/networking/client.dart';
import 'package:meta/meta.dart';

import 'dart:io';

import '../../core/base/files/base.dart';
import '../../core/constants/strings.dart';
import '../../core/utils/logger.dart';

import 'package:http/http.dart' as http;

/// {@template openai_files}
/// This class is responsible for handling all files requests, such as uploading a file to be used across various endpoints/features.
/// {@endtemplate}
@immutable
@protected
interface class OpenAIFiles implements OpenAIFilesBase {
  @override
  String get endpoint => OpenAIStrings.endpoints.files;

  /// {@macro openai_files}
  OpenAIFiles() {
    OpenAILogger.logEndpoint(endpoint);
  }

  /// This method fetches for your files list that exists in your OPenAI account.
  ///
  /// Example:
  ///```dart
  /// List<OpenAIFileModel> files = await OpenAI.instance.file.list();
  /// print(files.first.id);
  ///```
  @override
  Future<List<OpenAIFileModel>> list({
    http.Client? client,
  }) async {
    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.build(endpoint),
      client: client,
      onSuccess: (Map<String, dynamic> response) {
        final List filesList = response["data"];

        return filesList.map((e) => OpenAIFileModel.fromMap(e)).toList();
      },
    );
  }

  /// Fetches for a single file by it's id and returns informations about it.
  ///
  /// Example:
  ///```dart
  /// OpenAIFileModel file = await OpenAI.instance.file.retrieve("FILE ID");
  ///
  /// print(file);
  ///```
  @override
  Future<OpenAIFileModel> retrieve(
    String fileId, {
    http.Client? client,
  }) async {
    final String fileIdEndpoint = "/$fileId";

    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.build(endpoint + fileIdEndpoint),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIFileModel.fromMap(response);
      },
    );
  }

  /// Fetches for a single file content by it's id.
  ///
  /// Example:
  /// ```dart
  /// dynamic fileContent  = await OpenAI.instance.file.retrieveContent("FILE ID");
  ///
  /// print(fileContent);
  /// ```
  @override
  Future retrieveContent(
    String fileId, {
    http.Client? client,
  }) async {
    final String fileIdEndpoint = "/$fileId/content";

    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.build(endpoint + fileIdEndpoint),
      returnRawResponse: true,
    );
  }

  /// Upload a file that contains document(s) to be used across various endpoints/
  /// features. Currently, the size of all the files uploaded by one organization can be
  /// up to 1 GB. Please contact us if you need to increase the storage limit.
  ///
  /// [file] is the `jsonl` file to be uploaded, If the [purpose] is set to "fine-tune", each line is a JSON record with "prompt" and "completion.
  ///
  /// [purpose] Use "fine-tune" for Fine-tuning. This allows us to validate the format of the uploaded file.
  ///
  ///
  /// Example:
  /// ```dart
  /// OpenAIFileModel uploadedFile = await OpenAI.instance.file.upload(
  /// file: File("/* FILE PATH HERE */"),
  /// purpose: "fine-tuning",
  /// );
  /// ```
  @override
  Future<OpenAIFileModel> upload({
    required File file,
    required String purpose,
  }) async {
    return await OpenAINetworkingClient.fileUpload(
      to: BaseApiUrlBuilder.build(endpoint),
      body: {
        "purpose": purpose,
      },
      file: file,
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIFileModel.fromMap(response);
      },
    );
  }

  /// This method deleted an existent file from your account used it's id.
  ///
  ///
  /// ```dart
  /// bool isFileDeleted = await OpenAI.instance.file.delete("/* FILE ID */");
  ///
  /// print(isFileDeleted);
  /// ```
  @override
  Future<bool> delete(
    String fileId, {
    http.Client? client,
  }) async {
    final String fileIdEndpoint = "/$fileId";

    return await OpenAINetworkingClient.delete(
      from: BaseApiUrlBuilder.build(endpoint + fileIdEndpoint),
      onSuccess: (Map<String, dynamic> response) {
        final bool isDeleted = response["deleted"] as bool;

        return isDeleted;
      },
    );
  }
}
