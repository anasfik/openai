import 'dart:io';

import '../../../models/file/file.dart';

abstract class UploadInterface {
  Future<OpenAIFileModel> upload({
    required File file,
    required String purpose,
  });
}
