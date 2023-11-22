import '../../../enum.dart';
import '../../../models/image/image/image.dart';

import 'package:http/http.dart' as http;

abstract class CreateInterface {
  Future<OpenAIImageModel> create({
    required String prompt,
    int? n,
    OpenAIImageSize? size,
    OpenAIImageResponseFormat? responseFormat,
    String? user,
    http.Client? client,
  });
}
