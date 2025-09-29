import 'dart:io';

import 'package:dart_openai/src/core/models/uploads/upload_part.dart';

abstract class AddInterface {
  Future<OpenAIUploadPartModel> addPart({
    required String uploadId,
    required File data,
  });
}
