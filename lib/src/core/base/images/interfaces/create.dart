import '../../../models/image.dart';

abstract class CreateInterface {
  Future<OpenAIImageModel> create(
      {required String prompt,
      int? n,
      String size,
      String? responseFormat,
      String? user});
}
