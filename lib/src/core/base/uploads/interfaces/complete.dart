import 'package:dart_openai/src/core/models/uploads/uploads.dart';

abstract class CompleteInterface {
  Future<OpenAIUploadModel> complete({
    required String uploadId,
    required List<String> partIds,
    String? md5,
  });
}
