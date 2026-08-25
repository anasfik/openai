
import '../../../../../dart_openai.dart';


abstract class VariationInterface {
  Future<List<OpenAIImageData>> variation({
    required OpenAIFile image,
    int? n,
    OpenAIImageSize? size,
    OpenAIImageResponseFormat? responseFormat,
    String? user,
  });
}
