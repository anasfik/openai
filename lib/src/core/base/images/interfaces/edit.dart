
import 'package:dart_openai/src/core/io/openai_file.dart';

import '../../../enum.dart';
import '../../../models/image/image/image.dart';


abstract class EditInterface {
  Future<OpenAIImageModel> edit({
    required OpenAIFile image,
    required String prompt,
    String? background,
    OpenAIImageInputFidelity? inputFidelity,
    OpenAIFile? mask,
    String? model,
    int? n,
    int? outputCompression,
    OpenAIImageModelOutputFormat? outputFormat,
    int? partialImages,
    OpenAIImageQuality? quality,
    OpenAIImageResponseFormat? responseFormat,
    OpenAIImageSize? size,
    String? user,
  });
}
