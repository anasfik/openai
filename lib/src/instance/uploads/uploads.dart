import 'dart:io';

import 'package:dart_openai/src/core/base/uploads/uploads.dart';
import 'package:dart_openai/src/core/models/uploads/expires_after.dart';
import 'package:dart_openai/src/core/models/uploads/upload_part.dart';
import 'package:dart_openai/src/core/models/uploads/uploads.dart';

class OpenAIUploads implements OpenAIUploadsBase {
  @override
  Future<OpenAIUploadModel> create({
    required int bytes,
    required String filename,
    required String mimrType,
    required String purpose,
    OpenAIUploadExpiresAfter? expiresAfter,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<OpenAIUploadPartModel> addPart({
    required String uploadId,
    required File data,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<OpenAIUploadModel> cancel({
    required String uploadId,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<OpenAIUploadModel> complete({
    required String uploadId,
    required List<String> partIds,
    String? md5,
  }) async {
    throw UnimplementedError();
  }
}
