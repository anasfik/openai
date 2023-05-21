import 'dart:io';

import '../../../../../dart_openai.dart';

abstract class VariationInterface {
  Future<OpenAIImageVariationModel> variation({
    required File image,
    int? n,
    OpenAIImageSize? size,
    OpenAIImageResponseFormat? responseFormat,
    String? user,
  });
}
