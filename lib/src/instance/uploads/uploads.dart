import 'dart:io';

import 'package:dart_openai/src/core/base/uploads/uploads.dart';
import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/config/client_config.dart';
import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/models/uploads/expires_after.dart';
import 'package:dart_openai/src/core/models/uploads/upload_part.dart';
import 'package:dart_openai/src/core/models/uploads/uploads.dart';
import 'package:dart_openai/src/core/networking/client.dart';

class OpenAIUploads implements OpenAIUploadsBase {
  final OpenAIClientConfig? _config;

  OpenAIUploads([this._config]);

  String get endpoint => OpenAIStrings.endpoints.uploads;

  @override
  Future<OpenAIUploadModel> create({
    required int bytes,
    required String filename,
    required String mimeType,
    required String purpose,
    OpenAIUploadExpiresAfter? expiresAfter,
  }) async {
    return await OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, endpoint),
      body: {
        'bytes': bytes,
        'filename': filename,
        'mime_type': mimeType,
        'purpose': purpose,
        if (expiresAfter != null)
          'expires_after': {
            'anchor': expiresAfter.anchor,
            'seconds': expiresAfter.seconds,
          },
      },
      onSuccess: UploadModelParsing.fromMap,
      config: _config,
    );
  }

  @override
  Future<OpenAIUploadPartModel> addPart({
    required String uploadId,
    required File data,
  }) async {
    return await OpenAINetworkingClient.fileUpload(
      to: BaseApiUrlBuilder.buildFor(_config, '$endpoint/$uploadId/parts'),
      body: {},
      file: data,
      fileField: 'data',
      onSuccess: (map) => UploadPartParsing.fromMap(map),
      config: _config,
    );
  }

  @override
  Future<OpenAIUploadModel> complete({
    required String uploadId,
    required List<String> partIds,
    String? md5,
  }) async {
    return await OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, '$endpoint/$uploadId/complete'),
      body: {
        'part_ids': partIds,
        if (md5 != null) 'md5': md5,
      },
      onSuccess: UploadModelParsing.fromMap,
      config: _config,
    );
  }

  @override
  Future<OpenAIUploadModel> cancel({
    required String uploadId,
  }) async {
    return await OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, '$endpoint/$uploadId/cancel'),
      onSuccess: UploadModelParsing.fromMap,
      config: _config,
    );
  }
}
