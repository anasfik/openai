import 'dart:io';

import '../../../enum.dart';
import '../../../models/image/image/image.dart';

abstract class EditInterface {
  Future<OpenAIImageModel> edit({
    required File image,
    required String prompt,
    String? background,
    String? inputFidelity,
    File? mask,
    String? model,
    int? n,
    int? outputCompression,
    String? outputFormat,
    int? partialImages,
    String? quality,
    OpenAIImageResponseFormat? responseFormat,
    OpenAIImageSize? size,
    String? user,
  });
}
