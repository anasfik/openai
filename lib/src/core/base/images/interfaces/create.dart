import 'package:http/http.dart' as http;

import '../../../enum.dart';
import '../../../models/image/image/image.dart';

abstract class CreateInterface {
  Future<OpenAIImageModel> create({
    required String prompt,
    String? background,
    String? model,
    String? moderation,
    int? n,
    int? outputCompression,
    OpenAIImageModelOutputFormat? outputFormat,
    int? partialImages,
    OpenAIImageQuality? quality,
    OpenAIImageResponseFormat? responseFormat,
    OpenAIImageSize? size,
    OpenAIImageStyle? style,
    String? user,
    http.Client? client,
  });
}
