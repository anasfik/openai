import '../../../enum.dart';
import '../../../models/image/image/image.dart';

import 'package:http/http.dart' as http;

abstract class CreateInterface {
  Future<OpenAIImageModel> create({
    required String prompt,
    String? background,
    String? model,
    String? moderation,
    int? n,
    int? outputCompression,
    String? outputFormat,
    int? partialImages,
    String? quality,
    OpenAIImageResponseFormat? responseFormat,
    OpenAIImageSize? size,
    String? style,
    String? user,
    http.Client? client,
  });
}
