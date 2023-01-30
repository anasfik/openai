import 'package:openai/src/core/models/model.dart';

abstract class OneInterface {
  Future<OpenAIModelModel> one(String modelId);
}
