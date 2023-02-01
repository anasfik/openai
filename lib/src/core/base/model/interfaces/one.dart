import 'package:openai/src/core/models/model.dart';

abstract class RetrieveInterface {
  Future<OpenAIModelModel> retrieve(String modelId);
}
