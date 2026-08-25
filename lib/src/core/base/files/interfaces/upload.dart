
import 'package:dart_openai/src/core/io/openai_file.dart';

import '../../../models/file/file.dart';

abstract class UploadInterface {
  Future<OpenAIFileModel> upload({
    required OpenAIFile file,
    required String purpose,
  });
}
