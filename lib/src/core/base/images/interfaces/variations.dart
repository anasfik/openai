import 'dart:io';

import '../../../../../openai.dart';
import '../base.dart';

abstract class VariationInterface {
  Future<OpenAIImageVariationModel> variation({
    required File image,
    int? n,
    OpenAIImageSize? size,
    OpenAIResponseFormat? responseFormat,
    String? user,
  });
}
