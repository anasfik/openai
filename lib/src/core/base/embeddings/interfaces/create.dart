import '../../../models/embedding.dart';

abstract class CreateInterface {
  Future<OpenAIEmbeddingsModel> create({
    required String model,
    required dynamic input,
    String? user,
  });
}
