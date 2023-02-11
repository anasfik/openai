import 'dart:io';

import '../../../models/image/enum.dart';

abstract class EditInterface {
  Future<void> edit({
    required File image,
    File? mask,
    required String prompt,
    int? n,
    OpenAIImageSize? size,
    OpenAIResponseFormat? responseFormat,
    String? user,
  });
}
