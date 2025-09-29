import 'package:dart_openai/src/core/models/uploads/uploads.dart';

abstract class CancelUpload {
  Future<OpenAIUploadModel> cancel({
    required String uploadId,
  });
}
