import 'package:dart_openai/src/core/io/openai_file.dart';
import 'package:dart_openai/src/core/models/uploads/upload_part.dart';

abstract class AddInterface {
  Future<OpenAIUploadPartModel> addPart({
    required String uploadId,
    required OpenAIFile data,
  });
}
