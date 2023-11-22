import 'dart:io';

import '../../../enum.dart';
import '../../../models/image/image/image.dart';

abstract class EditInterface {
  Future<OpenAIImageModel> edit({
    required File image,
    File? mask,
    required String prompt,
    int? n,
    OpenAIImageSize? size,
    OpenAIImageResponseFormat? responseFormat,
    String? user,
  });
}
