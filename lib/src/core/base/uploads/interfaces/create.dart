import 'package:dart_openai/src/core/models/uploads/expires_after.dart';
import 'package:dart_openai/src/core/models/uploads/uploads.dart';

abstract class CreateInterface {
  Future<OpenAIUploadModel> create({
    required int bytes,
    required String filename,
    required String mimrType,
    required String purpose,
    OpenAIUploadExpiresAfter? expiresAfter,
  });
}
